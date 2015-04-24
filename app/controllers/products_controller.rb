class ProductsController < ApplicationController
	layout 'main_layout'
  #restricting user if logged out
  before_action :check_user_stamp,:except=>[:index,:show]

  #To get category, subcategry etc variables
  before_action :get_modified_variables,:only=>[:new,:edit]

  def index
    @categories,@sub_categories,@product_types,@brands=get_variables
    if params[:search_query]
      #if searched
      @products = Product.search_for(params[:search_query]).recent
    elsif params[:category]
      # if category is clicked
      @products = Product.where(:category=>params[:category]).recent
    elsif params[:sub_category]
      # if sub category is clicked
      @products = Product.where(:sub_category=>params[:sub_category]).recent
    elsif params[:brand]
      @products = Product.where(:brand=>params[:brand]).recent
    elsif params[:product_type]
      @products = Product.where(:product_type=>params[:product_type]).recent
    else
      #display all products if no params are passed
  	 @products = Product.recent
    end
  end

  def new
  	Product.new
  end

  def create
    #passing hash of ad details of product filled by user
    product = Product.create(get_product_details)
    #Price might be empty if bid is allowed so set default value if blank
    product.price=product.price||'0'
    #append the product to the user who posts it
    user = User.find_by_id(session[:id])
    user.products << product 
    
    #set range only if product has bid option checked
    if product.can_bid
      #create bid range & append it to particular product
      bid = Bid.create(:min_bid=>params[:product][:min_bid],:max_bid=>params[:product][:max_bid])
      product.bids << bid
    end

    redirect_to(:controller=>'users',:action=>'show_messages',:product_id=>product.id)
  end


  def show
    @product = Product.find_by_id(params[:id])
    @bids = @product.bids
  end

  def edit 
    #form_for is for :product so @product will fill in details auto.
    @product = Product.find_by_id(params[:id])

  end

  def update
    @product = Product.find_by_id(params[:id])

    if @product.update_attributes(get_product_details) 
      redirect_to(:controller=>'users',:action=>'show_messages',:product_id=>@product.id)
    else
      render('edit')
      #while rendering, edit requires these things
      @categories,@sub_categories,@product_types,@brands=get_variables
    end

  end

  def destroy
    product = Product.find_by_id(params[:id])
    product.destroy
  
    flash[:notice]="Your ad has been deleted !"
    redirect_to(:controller=>'users',:action=>'index')
  end

  def place_bid
    #get Value & product id from params
    product = Product.find_by_id(params[:product_id])
    user = User.find_by_id(session[:id])

    if product.can_bid

      if Bid.get_user_bids(user.id,product.id).count > 0
        # if user already placed one bid
        flash[:notice]="You already placed a bid !"
      else
        #if bid is available for product
        bid = product.bids.first
        min_bid = bid.min_bid
        max_bid = bid.max_bid

        unless product.bids.first.user_id
          #if bid is there for which no user belongs
          # update the previous one that is created by product
          bid.value= params[:value]
          bid.save # very imp
          user.bids << bid # save the bid as well as add user to it
        else
          # add a new bid & associate user & product to it
          bid = Bid.create(:min_bid=>min_bid,:max_bid=>max_bid,:value=>params[:value])
          user.bids << bid 
          product.bids << bid 
        end
        flash[:notice]="Bid placed successfully !"
      end
    else 
      flash[:notice]="Bidding is not available for this product !"
    end

      redirect_to(:action=>'show',:id=>product.id)

  end

  private
    def get_variables
      #Creating hash such that 'categories => [subcategories]'
      categories = {
        'Vehicles'=>["Cars","Bikes","Trucks"],
        'Electronics & Aplliances'=>['Mobile','Tablets'],
        'Home & Lifestyle'=>["Houses"]
      }
      product_types=['Battery','Cable','Headsets']
      brands = ['nokia','sony','motorolla','philips']
      # categories.values => [['cars','bikes','trucks'],['mobile',tablets']] 
      # so get index of particualr category and see the subcategory using that in views
      return categories.keys,categories.values,product_types,brands
    end
    
    def get_modified_variables
      # This is to conver the multidimenstional array of sub_categories 
      # To single dimension by joining and spliting it again
      @categories,@sub_categories,@product_types,@brands=get_variables
      @sub_categories = @sub_categories.join(',').split(',')
    end

	  def get_product_details
	  	params.require(:product).permit(:title,:description,:category,:sub_category,:product_type,:used,:price,:brand,:can_bid,:image)
	  end
end

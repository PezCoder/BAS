class Bid < ActiveRecord::Base
	belongs_to :user
	belongs_to :product

	#returning user bids on a particular product
	scope :get_user_bids,lambda { |user_id,product_id| where(:user_id=>user_id,:product_id=>product_id)}
end

class Product < ActiveRecord::Base
	#relationships
	belongs_to :user
	has_many :messages
	has_many :bids

	#active record callbacks
	after_destroy :destroy_related_bids
	after_destroy :destroy_related_messages
	
	#Scopes
	scope :recent,lambda { order("created_at DESC")}
	scope :search_for,lambda{ |name| where(["title LIKE ?","%#{name}%"])}

	#for paperclip
	has_attached_file :image,:styles=>{:large=>"400x400>",:medium=>"250x180>",:thumb=>"50x50#"}
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	
	private 
	
	def destroy_related_bids
		#destroy all bids on it if exists
	    if can_bid
	      bids.each do |bid|
	        bid.destroy
	      end
	    end
	end

	def destroy_related_messages
		#destroy all the messages
    unless messages.empty?
      messages.each do |message|
        message.destroy
      end
    end
    
	end
end

class User < ActiveRecord::Base

	has_secure_password

	#relationships
	has_many :products
	has_many :messages
	has_and_belongs_to_many :admin_users
	has_many :bids
	
	#call backs
	after_destroy :remove_related_stuff

	#validations
	validates_uniqueness_of :username
	validates :email,:uniqueness=>true

	#for paperclip
	has_attached_file :profile_image,:styles=>{:large=>"400x400>",:medium=>"250x180>",:thumb=>"50x50#",:small=>"180x180>"}
	validates_attachment_content_type :profile_image, :content_type => /\Aimage\/.*\Z/
	
	private 
	def remove_related_stuff

		# remove related bids
		bids.each do |bid|
			bid.destroy
		end
		#remove related messages
		messages.each do |message|
			message.destroy
		end

		#remove realted products
		products.each do |product|
			product.destroy 
		end
		

	end

	

end

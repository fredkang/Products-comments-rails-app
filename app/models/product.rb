class Product < ActiveRecord::Base
	validates :name, :description, :pricing, presence:true
	validates :name, uniqueness: 	{case_sensitive:false, 
									message: "This product name already exists"}
	validate :category_exists

	belongs_to :category
	has_many :comments

	accepts_nested_attributes_for :comments

	def category_exists
		if self.category_id.nil?
			return true
		else
  			return false if Category.find(self.category_id).nil?
  		end
	end
end

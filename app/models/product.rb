class Product < ActiveRecord::Base
	validates :name, :description, :pricing, presence:true
	validates :name, uniqueness: 	{case_sensitive:false, 
									message: "This product name already exists"}
end

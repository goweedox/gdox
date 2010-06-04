class Documentation < ActiveRecord::Base
	belongs_to :user
	has_many  :screenies
	has_many :lessons

	validates_presence_of :title
	validates_presence_of :description
end

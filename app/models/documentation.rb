class Documentation < ActiveRecord::Base
	belongs_to :user
	has_many  :screenies

	validates_presence_of :title
	validates_presence_of :description
end

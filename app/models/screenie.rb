class Screenie < ActiveRecord::Base
  belongs_to  :documentation
  has_many  :annotations
end

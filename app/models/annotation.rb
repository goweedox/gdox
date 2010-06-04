class Annotation < ActiveRecord::Base
  belongs_to  :screenie
  has_one :screenie
end

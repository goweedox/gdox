class Screenshot < ActiveRecord::Base
  belongs_to :documentation
 
  has_attached_file :data,
  :styles => {
    :thumb => "50x50#",
    :large => "640x480#"
  }
 
  validates_attachment_presence :data
  validates_attachment_content_type :data, 
  :content_type => ['image/jpeg', 'image/pjpeg', 
                                   'image/jpg', 'image/png']

	def self.destroy_pics(documentation, screenshots)
		Screenshot.find(screenshots, :conditions => {:documentation_id => documentation}).each(&:destroy)
	end
end

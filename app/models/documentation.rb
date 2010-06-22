require 'screenstepslive_api'
  
class Documentation < ActiveRecord::Base
  belongs_to :user
  has_many  :screenshots
	accepts_nested_attributes_for :screenshots, :allow_destroy => true
  
  validates_presence_of :title
  validates_presence_of :description
	
  def lesson(url)
    ScreenStepsLiveAPI.user = 'codrschool'
    ScreenStepsLiveAPI.password = 'codrschool'
    temp = url.split("/")
    puts temp
    i = 0
    flag = 0

    while i < temp.length
      if i == 2
        temp_account = temp[i].split(".")
        account = temp_account[0]
      elsif temp[i].eql?("spaces")
        i += 1
        space_id_or_permalink = temp[i]
      elsif temp[i].eql?("manuals")
        i += 1
        flag = 1
        manual_id_or_permalink = temp[i]
      elsif temp[i].eql?("buckets")
        i += 1
        bucket_id_or_permalink = temp[i]
      elsif temp[i].eql?("lessons")
        i += 1
        last = temp[i]
        temp = last.split("-")
        lesson_id_or_permalink = temp[0]
      end
      i += 1
    end
    
    ScreenStepsLiveAPI.account = account  
    space = ScreenStepsLiveAPI::Space.find(space_id_or_permalink)
    if flag == 1
      manual = space.manual(manual_id_or_permalink)
      lesson = manual.lesson(lesson_id_or_permalink)
    else
      bucket = space.bucket(bucket_id_or_permalink)
      lesson = bucket.lesson(lesson_id_or_permalink)
    end
    
    result = lesson.title + lesson.description
    steps = lesson.steps
    
    ctr = 0
    until steps[ctr].nil?
      unless steps[ctr].title.nil?
        result += steps[ctr].title
      end
      unless steps[ctr].instructions.nil?
        result += steps[ctr].instructions
      end
      ctr += 1 
    end
    
    result
  end
	
end

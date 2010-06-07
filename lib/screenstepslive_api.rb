require 'rubygems'
require 'active_resource'

module ScreenStepsLiveAPI
  class Error < StandardError; end
  class << self
    attr_accessor :user, :password, :host_format, :site_format, :domain_format, :protocol, :path
    attr_reader :account, :token
 
    # Sets the account name, and updates all the resources with the new domain.
    def account=(name)
      resources.each do |r|
        r.site = r.site_format % (host_format % [protocol, domain_format % name, r.path])
      end
      @account = name
    end
    
    def user=(value)
      resources.each do |r|
        r.user = value
      end
    end
    
    def password=(value)
      resources.each do |r|
        r.password = value
      end
    end
 
    def resources
      @resources ||= []
    end
  
  end
  
  self.host_format = '%s://%s/%s'
  self.domain_format = '%s.screenstepslive.com'
  self.protocol = 'http'
  
  class Base < ActiveResource::Base
    def self.inherited(base)
      ScreenStepsLiveAPI.resources << base
      class << base
        attr_accessor :site_format
        attr_accessor :path
      end
      base.site_format = '%s'
      super
    end
  end
  
  class Space < Base
    self.path = ''
    def manual(id_or_permalink)
      manual = Manual.find(id_or_permalink, :params => { :space_id => self.id })
      manual.space_id = self.id
      manual
    end
    
    def bucket(id_or_permalink)
      bucket = Bucket.find(id_or_permalink, :params => { :space_id => self.id })
      bucket.space_id = self.id
      bucket
    end
    
    def search(text, options = {})
      get('searches', {:text => text}.merge(options) )
    end
    
    def create_task(params)
      Task.create(params.merge(:space_id => self.id))
    end
    
    def lessons_for_tag(tag_name)
      get('tags', :tag => tag_name)
    end
  end
  
  class Manual < Base
    self.path = "spaces/:space_id"

    attr_accessor :space_id

    def lesson(id)
      lesson = Lesson.find(id, :params => { :space_id => space_id, :manual_id => self.id })
      lesson.space_id = self.space_id
      lesson.manual_id = self.id
      lesson
    end
    
    def search(text, options = {})
      get('searches', {:text => text}.merge(options) )
    end
    
    def lessons_for_tag(tag_name)
      get('tags', :tag => tag_name)
    end
  end
  
  class Lesson < Base
    attr_accessor :space_id, :manual_id
    self.path = "spaces/:space_id/manuals/:manual_id"
    
  end
  
  class Bucket < Base
    self.path = "spaces/:space_id"

    attr_accessor :space_id

    def lesson(id)
      lesson = BucketLesson.find(id, :params => { :space_id => space_id, :bucket_id => self.id })
      lesson.space_id = self.space_id
      lesson.bucket_id = self.id
      lesson
    end
    
    def search(text, options = {})
      get('searches', {:text => text}.merge(options) )
    end
    
    def lessons_for_tag(tag_name)
      get('tags', :tag => tag_name)
    end
    
    
  end
  
  class BucketLesson < Base
    attr_accessor :space_id, :manual_id
    self.path = "spaces/:space_id/buckets/:bucket_id"    
    self.element_name = "lesson"
  end
  
  class Task < Base
    attr_accessor :space_id
    self.path = "spaces/:space_id"
  end
end


__END__
 
require 'screenstepslive_api'
ScreenStepsLiveAPI.account = 'youraccount'
ScreenStepsLiveAPI.user = 'username'
ScreenStepsLiveAPI.password = 'your_password'
 
space = ScreenStepsLiveAPI::Space.find(:first)

OR if your permalink is "mypermalink"

space = ScreenStepsLiveAPI::Space.find("mypermalink")

space.assets gives you all of the assets (Dividers, Manuals, Buckets) for a space

asset = space.assets.first

asset.asset_type returns the asset type. 

If it is a manual then we can call:

manual = space.manual(asset.id)

Then we can get the first lesson like so:

lesson_id = manual.chapters.first.lessons.first.id

mnaual.lesson(lesson_id)

Same method works for buckets.
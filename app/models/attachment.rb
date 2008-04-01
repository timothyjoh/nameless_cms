class Attachment < ActiveRecord::Base
  belongs_to :element
  acts_as_list :scope => :element
end

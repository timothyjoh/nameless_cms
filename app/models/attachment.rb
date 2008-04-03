class Attachment < ActiveRecord::Base
  # defaults :size_to => "500x300>"
  belongs_to :element
  acts_as_list :scope => :element
  has_attached_file :attachment,
                    :styles => { :medium => ("500x300>"),
                                 :thumb => "100x100#" }
                                 
  
  def content_type_png
    "filetypes/#{attachment_content_type.gsub(/\//, "_")}.png"
  end
end

class Element < ActiveRecord::Base
  acts_as_list 
  belongs_to :page
  belongs_to :user
  has_many :attachments, :dependent => :destroy
  
  Element::ELEMENTTYPES = [["Richtext"],
                          ["Embed"],
                          ["Files"],
                          ["TimeRange"],
                          ["Code"],
                          ["Head"]]
                          
  def has_only_photos?
    attachments.collect {|a| a.attachment_content_type }.grep(/image/).length == attachments.length
  end
  
end

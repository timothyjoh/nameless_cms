class Element < ActiveRecord::Base
  acts_as_ordered_tree :foreign_key => :page_id,
                       :order       => :position
  belongs_to :page
  belongs_to :user
  has_many :attachments
end

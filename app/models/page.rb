class Page < ActiveRecord::Base
  defaults :type => 'Standard', :parent_id => 0, :template => 'Main'
  acts_as_ordered_tree :foreign_key => :parent_id,
                       :order       => :position
  has_many :entries
end

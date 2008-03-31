class Page < ActiveRecord::Base
  defaults :type => 'StandardPage', :parent_id => 0, :template => 'Main'
  acts_as_ordered_tree :foreign_key => :parent_id,
                       :order       => :position
  has_many :entries
  
  
  
  def self.random
    ids = connection.select_all("SELECT id FROM widgets")
    find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
  
  def find_by_url(url, live = true, clean = true)
    return nil if virtual?
    url = clean_url(url) if clean
    my_url = self.url
    if (my_url == url) && (not live or published?)
      self
    elsif (url =~ /^#{Regexp.quote(my_url)}([^\/]*)/)
      slug_child = children.find_by_slug($1)
      if slug_child
        found = slug_child.find_by_url(url, live, clean)
        return found if found
      end
      children.each do |child|
        found = child.find_by_url(url, live, clean)
        return found if found
      end
      file_not_found_types = [FileNotFoundPage] + FileNotFoundPage.descendants
      condition = (['class_name = ?'] * file_not_found_types.length).join(' or ')
      file_not_found_names = file_not_found_types.map { |x| x.name }.uniq
      children.find(:first, :conditions => [condition] + file_not_found_names)
    end
  end
end

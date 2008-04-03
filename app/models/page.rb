require 'find'
class Page < ActiveRecord::Base
  defaults :parent_id => 0
  acts_as_ordered_tree :foreign_key => :parent_id,
                       :order       => :position
                       
  has_many :elements, :attributes => true, :dependent => :destroy, :order => "position"
  
  before_save :generate_slug, :set_proper_kind
  
  
  Page::PAGETYPES = [ ["Page"], 
                      ["Blog"],
                      ["Podcast"],
                      ["Gallery"],
                      ["Calendar"]]
    
                      
  def self.template_names
    filenames = []
    Find.find("#{RAILS_ROOT}/app/views/templates") do |path|
      filenames << path.split("/").last.split(".").first if File.file?(path)
    end
    filenames
  end
                      
  def self.random
    ids = connection.select_all("SELECT id FROM pages")
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
  
  def depth 
    parent.nil? ? 0 : parent.depth + 1
  end
  
  def can_has_subpages?(page = nil)
    self.kind.nil? || self.kind == "Page" || self.kind == "Calendar" || self.kind == "Blog" || self.kind == "Gallery" || self.kind == "Podcast"
  end
  
  def has_reversable?
    self.kind == "Calendar" || self.kind == "Blog" || self.kind == "Podcast"
  end
  
  protected
    def generate_slug
      if self.slug.blank?
        self.slug = self.title.gsub(/[^a-z1-9]+/i, '_').downcase
      else
        self.slug.gsub!(/[^a-z1-9]+/i, '_')
        self.slug.downcase!
      end
    end
    
    def set_proper_kind
      case self.parent.kind
      when "Blog"
        self.kind = "Post"
      when "Podcast"
        self.kind = "Episode"
      when "Calendar"
        self.kind = "Event"
      when "Gallery"
        self.kind = "Album"
      when "Page"
        # do nothing
      else
        return false
      end unless self.parent.nil?
    end
end

class Event < Element
  has_finder :upcoming, :conditions => {:end_at > Time.now}
  has_finder :future, :conditions => {:start_at < Time.now}
end

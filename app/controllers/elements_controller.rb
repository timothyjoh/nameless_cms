class ElementsController < ApplicationController
  resource_controller
  layout "page"
  
  belongs_to :page
  
  destroy.response do |wants|
    wants.html {redirect_to page_url(object.page)}
  end
  create.response do |wants|
    wants.html {redirect_to page_url(object.page)}
  end
end

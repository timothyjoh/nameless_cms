class AttachmentsController < ApplicationController
  resource_controller
  layout false
  
  belongs_to :element
  
  destroy.response do |wants|
    wants.html {redirect_to page_url(object.element.page)}
  end
  create.response do |wants|
    # wants.failure.html {render :text => "bad"}
    wants.html {redirect_to page_url(object.element.page)}
  end
  
  # show.before do {
  #   @attachment = Attachment.new
  # }
end

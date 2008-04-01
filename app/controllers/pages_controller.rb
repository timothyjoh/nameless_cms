class PagesController < ApplicationController
  resource_controller
  
  index.before do
    @page = Page.new
    @pages = Page.find( :all, :order => "parent_id, position").select {|p| p.parent_id == 0 }
  end
  

  create.response do |wants|
    wants.html { redirect_to :action => 'index' }
    wants.js { render :template => "show.rjs" }
  end
  
  uses_tiny_mce(:options => {
    :mode => "textareas",
    :editor_selector => "mceEditor",
    :theme => 'advanced',
    :theme_advanced_toolbar_location => "bottom",
    :theme_advanced_toolbar_align => "left",
    :theme_advanced_resizing => true,
    :theme_advanced_resize_horizontal => true,
    :paste_auto_cleanup_on_paste => true,
    :theme_advanced_buttons1 => %w{formatselect bold italic underline strikethrough separator justifyleft justifycenter justifyright indent outdent separator bullist numlist forecolor backcolor separator link unlink image undo redo},
    :theme_advanced_buttons2 => [],
    :theme_advanced_buttons3 => [],
    :plugins => %w{contextmenu paste}},
    :only => [:new, :edit, :show, :index])
    
  private
    def model_name
      'page'
    end
  
end

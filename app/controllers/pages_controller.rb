class PagesController < ApplicationController
    before_filter :find_page, :only => [ :show, :edit, :update, :destroy ]

  # GET /pages
  # GET /pages.ext_json
  def index
    respond_to do |format|
      format.html     # index.html.erb (no data required)
      format.ext_json { render :json => find_pages.to_ext_json(:class => :page, :count => Page.count) }
    end
  end

  # GET /pages/1
  def show
    # show.html.erb
  end

  # GET /pages/new
  def new
    @page = Page.new(params[:page])
    # new.html.erb
  end

  # GET /pages/1/edit
  def edit
    # edit.html.erb
  end

  # POST /pages
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.ext_json { render(:update) {|page| page.redirect_to pages_url } }
      else
        format.ext_json { render :json => @page.to_ext_json(:success => false) }
      end
    end
  end

  # PUT /pages/1
  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.ext_json { render(:update) {|page| page.redirect_to pages_url } }
      else
        format.ext_json { render :json => @page.to_ext_json(:success => false) }
      end
    end
  end

  # DELETE /pages/1
  def destroy
    @page.destroy

    respond_to do |format|
      format.js  { head :ok }
    end
  rescue
    respond_to do |format|
      format.js  { head :status => 500 }
    end
  end
  
  protected
  
    def find_page
      @page = Page.find(params[:id])
    end
    
    def find_pages
      pagination_state = update_pagination_state_with_params!(:page)
      @pages = Page.find(:all, options_from_pagination_state(pagination_state).merge(options_from_search(:page)))
    end
end

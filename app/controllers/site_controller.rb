class SiteController < ApplicationController
  # session :off
  # 
  # no_login_required
  # 
  # attr_accessor :config, :cache
  
  # def initialize
  #   @config = Radiant::Config
  #   @cache = ResponseCache.instance
  # end
  
  def show_page
    # response.headers.delete('Cache-Control')
   
    url = params[:url]
    logger.debug ("• Route to #{params[:url]}")
    if Array === url
      url = url.join('/')
    else
      url = url.to_s
    end
   
    @page = Page.find_by_slug(url)
    
    if @page.nil?
      flash[:error] = "We cannot find that page<br />#{params[:url]}"
      logger.debug ("Failed Route to #{params[:url]}")
      redirect_to :action => 'not_found' 
    else
      render :layout => "templates/#{@page.template}" 
    end
    # if (request.get? || request.head?) and live? and (@cache.response_cached?(url))
    #   @cache.update_response(url, response, request)
    #   @performed_render = true
    # else
    #   show_uncached_page(url)
    # end
  end
  
  def not_found
    render :text => flash[:error]    
  end
  
  def error
    render :text => "You have caused an error"
  end
  
  private
  
    def find_page(url)
      found = Page.find_by_url(url, live?)
      found if found and (found.published? or dev?)
    end
  
    def process_page(page)
      page.process(request, response)
    end
  
    def show_uncached_page(url)
      @page = find_page(url)
      unless @page.nil?
        process_page(@page)
        @cache.cache_response(url, response) if request.get? and live? and @page.cache?
        @performed_render = true
      else
        render :template => 'site/not_found', :status => 404
      end
    rescue Page::MissingRootPageError
      redirect_to welcome_url
    end
  
    def dev?
      if dev_host = @config['dev.host']
        request.host == dev_host
      else
        request.host =~ /^dev\./
      end
    end
  
    def live?
      not dev?
    end
end

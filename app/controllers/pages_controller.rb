class PagesController < ApplicationController
  def show
    # render plain: "#{params[:page]} Page"
    # Will search for html.erb extension automatically, assumes templates
    #  held in app/views directory, point it into pages and your specified page
    render template: "pages/#{params[:page]}"
  end

end

class LimitedController < ApplicationController
	
  before_filter :authorize, :except => :login	

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:controller => "admin", :action => "login")
  end
    
  def index
  end

end

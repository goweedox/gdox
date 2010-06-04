class WelcomeController < ApplicationController
	# GET /users/new
  # GET /users/new.xml
  def signup
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def login
    if session[:user_id] 
	    redirect_to(:controller => "admin", :action => "index")
    end  
		if request.post?
		 user = User.authenticate(params[:name], params[:password])   
		 if user
			 session[:user_id] = user.id
			 redirect_to(:controller => 'admin', :action => "index")

		 else
			 flash.now[:notice] = "Invalid user/password combination!"
		 end
		end
  end
  
  def index
			flash.now[:notice] = "Please click sign-up to create another account if you can't login. Sorry for the inconvenience. Thanks."	
	  if session[:user_id] 
	    redirect_to(:controller => "admin", :action => "index")
	  end
  end
end

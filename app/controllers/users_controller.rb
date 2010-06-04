class UsersController < ApplicationController
  layout "admin"

  # GET /users
  # GET /users.xml
  def index
    if session[:user_id] 
      redirect_to(:controller => "admin", :action => "show_users")	
    else
      redirect_to(:controller => "welcome", :action => "index")
    end
  end

	def new
		@user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
	end
		

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users	
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if (@user.save && session[:user_id])
        flash[:notice] = "User \'#{@user.name}\' successfully created."
        format.html { redirect_to(:controller => 'admin', :action => 'show_users') }#{ redirect_to(@user) } 
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      elsif @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Your account is successfully created."
        format.html { redirect_to(:controller => 'admin', :action => 'index') }#{ redirect_to(@user) } 
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

    
  # PUT /users/1
  # PUT /users/1.xml
  def update
		current_user= session[:user_id]
		@current = User.find(current_user)

    @user = User.find(params[:id])

    respond_to do |format|
      if @current.name != 'admin'
        flash[:notice] = "You are not allowed to update."
        format.html { redirect_to(:controller => 'admin', :action => 'show_users') }
      elsif @user.update_attributes(params[:user])
        flash[:notice] = "User \'#{@user.name}\' successfully updated."
        format.html { redirect_to(:controller => 'admin', :action => 'show_users') } #{ redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
		current_user= session[:user_id]
		@current = User.find(current_user)

    @user = User.find(params[:id])
    if @current.name != 'admin'
      flash[:notice] = "You are not allowed to delete."
    else
      @user.destroy
      flash[:notice] = "User \'#{@user.name}\' is now deleted."
    end
    respond_to do |format|
      format.html { redirect_to(:controller => 'admin', :action => 'show_users') }
      format.xml  { head :ok }
    end
  end
end

class DocumentationsController < ApplicationController
	before_filter :authorize, :except => :login
  in_place_edit_for :documentation, :title
  in_place_edit_for :documentation, :description

  # GET /documentations
  # GET /documentations.xml
  def index
		@documentations = Documentation.find(:all)

		respond_to do |format|
		  format.html # index.html.erb
		  format.xml  { render :xml => @documentations }
		end
  end

  # GET /documentations/1
  # GET /documentations/1.xml
  def show
		@current = User.find(session[:user_id])
    @documentation = Documentation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @documentation }
    end
  end

  # GET /documentations/new
  # GET /documentations/new.xml
  def new
		@documentation = Documentation.new
		@documentation.screenshots.build

		respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @documentation }
		end
  end

  # GET /documentations/1/edit
  def edit
		@documentation = Documentation.find(params[:id])
		    
		@current = User.find(session[:user_id])
		if @current.id != @documentation.user_id
			redirect_to(:controller => "documentations", :action => "#{@documentation.user_id}")
		end

		if @documentation.screenshots.first.nil?
		  @documentation.screenshots.build
		end
  end

  # POST /documentations
  # POST /documentations.xml
  def create
    @documentation = Documentation.new(params[:documentation])

    respond_to do |format|
      if @documentation.save
        flash[:notice] = 'Documentation was successfully created.'
        format.html { redirect_to(:controller => 'documentations', :id => "#{@documentation.id}", :action => 'edit') }
        format.xml  { render :xml => @documentation, :status => :created, :location => @documentation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @documentation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documentations/1
  # PUT /documentations/1.xml
  def update
    @documentation = Documentation.find(params[:id])

    respond_to do |format|
      if @documentation.update_attributes(params[:documentation])
        flash[:notice] = 'Documentation was successfully updated.'
        format.html { redirect_to(:controller => 'documentations', :id => "#{@documentation.id}", :action => 'edit') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @documentation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documentations/1
  # DELETE /documentations/1.xml
  def destroy
    @documentation = Documentation.find(params[:id])
    @documentation.destroy
		flash[:notice] = "Dox \'#{@documentation.title}\' successfully deleted."

    respond_to do |format|
      format.html { redirect_to(:controller => "admin", :action => "index") }
      format.xml  { head :ok }
    end
  end
end

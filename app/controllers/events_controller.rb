class EventsController < ApplicationController
  before_filter :login_required
  # GET /events
  # GET /events.xml
  def index
    #    @records = Todo.all
    @records = current_user.events

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @records }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @record = current_user.events.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @record }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @record = current_user.events.create

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @record }
    end
  end

  # GET /events/1/edit
  def edit
    @record = current_user.events.find(params[:id])

  end

  # POST /events
  # POST /events.xml
  def create
    @record = current_user.events.create(params[:todo])
    @record.user = current_user

    respond_to do |format|
      if @record.save
        flash[:notice] = 'Todo was successfully created.'
        format.html { redirect_to(@record) }
        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @record = current_user.events.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:event])
        flash[:notice] = 'Todo was successfully updated.'
        format.html { redirect_to(@record) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @record = current_user.events.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end

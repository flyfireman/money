class EntriesController < ApplicationController
  before_filter :login_required
  # GET /entries
  # GET /entries.xml
  def index
    @records = Entry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
#  def show
#    @record = Entry.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @record }
#    end
#  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @record = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @record }
    end
  end

  # GET /entries/1/edit
  def edit
    @record = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @record = Entry.new(params[:entry])

    respond_to do |format|
      if @record.save
        flash[:notice] = 'Entry was successfully created.'
        #format.html { redirect_to(@record) }
        format.html { redirect_to(entries_url) }
        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @record = Entry.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to(entries_url) }
        #format.html { redirect_to(@record) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @record = Entry.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.xml  { head :ok }
    end
  end
end

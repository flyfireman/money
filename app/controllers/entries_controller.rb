class EntriesController < ApplicationController
  before_filter :login_required
  # GET /entries
  # GET /entries.xml
  def index
    #@records = current_user.entries.find(:all)
    @records = current_user.entries.paginate(:page => params[:page],
      :per_page => params[:pre_page] || 3,
      #:include => :user,
      # :conditions => ["#{params[:user_id].to_i} == #{current_user.id}"],
      :conditions => ["amount like ?", "%#{params[:s]}%"],
      :order=>"created_at DESC")
    # Article.paginate
    #不要轻信ID(关于rails中find的使用) ->http://ilstar.blogbus.com/logs/41580720.html
    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @entries }
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
      #      format.xml  { render :xml => @record }
    end
  end

  # GET /entries/1/edit
  def edit
    @record = current_user.entries.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @record = Entry.new(params[:entry])
    @record.user = current_user

    respond_to do |format|
      if @record.save
        flash[:notice] = 'Entry was successfully created.'
        #format.html { redirect_to(@record) }
        format.html { redirect_to(entries_url) }
        #        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.html { render :action => "new" }
        #        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @record = current_user.entries.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to(entries_url) }
        #format.html { redirect_to(@record) }
        #        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        #        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @record = current_user.entries.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      #      format.xml  { head :ok }
    end
  end
end

class CapsController < ApplicationController
  # GET /caps
  # GET /caps.xml
  def index
    @caps = Cap.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @caps }
    end
  end

  # GET /caps/1
  # GET /caps/1.xml
  def show
    @cap = Cap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cap }
    end
  end

  # GET /caps/new
  # GET /caps/new.xml
  def new
    @cap = Cap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cap }
    end
  end

  # GET /caps/1/edit
  def edit
    @cap = Cap.find(params[:id])
  end

  # POST /caps
  # POST /caps.xml
  def create
    @cap = Cap.new(params[:cap])

    respond_to do |format|
      if @cap.save_with_captcha
        flash[:notice] = 'Cap was successfully created.'
        format.html { redirect_to(@cap) }
        format.xml  { render :xml => @cap, :status => :created, :location => @cap }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cap.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /caps/1
  # PUT /caps/1.xml
  def update
    @cap = Cap.find(params[:id])

    respond_to do |format|
      if @cap.update_attributes(params[:cap])
        flash[:notice] = 'Cap was successfully updated.'
        format.html { redirect_to(@cap) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cap.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /caps/1
  # DELETE /caps/1.xml
  def destroy
    @cap = Cap.find(params[:id])
    @cap.destroy

    respond_to do |format|
      format.html { redirect_to(caps_url) }
      format.xml  { head :ok }
    end
  end
end

class DatacentersController < ApplicationController
  # GET /datacenters
  # GET /datacenters.xml
  def index
    @datacenters = Datacenter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @datacenters }
    end
  end

  # GET /datacenters/1
  # GET /datacenters/1.xml
  def show
    @datacenter = Datacenter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @datacenter }
    end
  end

  # GET /datacenters/new
  # GET /datacenters/new.xml
  def new
    @datacenter = Datacenter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @datacenter }
    end
  end

  # GET /datacenters/1/edit
  def edit
    @datacenter = Datacenter.find(params[:id])
  end

  # POST /datacenters
  # POST /datacenters.xml
  def create
    @datacenter = Datacenter.new(params[:datacenter])

    respond_to do |format|
      if @datacenter.save
        format.html { redirect_to(@datacenter, :notice => 'Datacenter was successfully created.') }
        format.xml  { render :xml => @datacenter, :status => :created, :location => @datacenter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @datacenter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /datacenters/1
  # PUT /datacenters/1.xml
  def update
    @datacenter = Datacenter.find(params[:id])

    respond_to do |format|
      if @datacenter.update_attributes(params[:datacenter])
        format.html { redirect_to(@datacenter, :notice => 'Datacenter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @datacenter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /datacenters/1
  # DELETE /datacenters/1.xml
  def destroy
    @datacenter = Datacenter.find(params[:id])
    @datacenter.destroy

    respond_to do |format|
      format.html { redirect_to(datacenters_url, :notice => 'Datacenter was destroyed.') }
      format.xml  { head :ok }
    end
  end
end

class InterfacesController < ApplicationController
  # GET /interfaces
  # GET /interfaces.xml
  def index
    @interfaces = Interface.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interfaces }
    end
  end

  # GET /interfaces/1
  # GET /interfaces/1.xml
  def show
    @interface = Interface.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interface }
    end
  end

  # GET /interfaces/new
  # GET /interfaces/new.xml
  def new
    @interface = Interface.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @interface }
    end
  end

  # GET /interfaces/1/edit
  def edit
    @interface = Interface.find(params[:id])
  end

  # POST /interfaces
  # POST /interfaces.xml
  def create
    @interface = Interface.new(params[:interface])

    respond_to do |format|
      if @interface.save
        format.html { redirect_to(@interface, :notice => 'Interface was successfully created.') }
        format.xml  { render :xml => @interface, :status => :created, :location => @interface }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interface.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interfaces/1
  # PUT /interfaces/1.xml
  def update
    @interface = Interface.find(params[:id])

    respond_to do |format|
      if @interface.update_attributes(params[:interface])
        format.html { redirect_to(@interface, :notice => 'Interface was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interface.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interfaces/1
  # DELETE /interfaces/1.xml
  def destroy
    @interface = Interface.find(params[:id])
    @interface.destroy

    respond_to do |format|
      format.html { redirect_to(interfaces_url) }
      format.xml  { head :ok }
    end
  end
end

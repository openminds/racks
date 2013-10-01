class DatacentersController < ApplicationController
  respond_to :iphone, :html
  before_filter :authorize
  def index
    respond_to do |format|
      format.html {
        if Datacenter.all.empty?
          redirect_to new_datacenter_path

        else
          redirect_to [current_datacenter, :server_racks]
        end
      }
      format.iphone
    end
  end

  def new
    @datacenter = Datacenter.new
  end

  def edit
    @datacenter = Datacenter.find(params[:id])
  end

  def create
    @datacenter = Datacenter.new(params[:datacenter])
    @datacenter.save
    respond_with @datacenter, :location => [@datacenter, :server_racks] do |format|
      format.html
      format.iphone do
        if @datacenter.errors.any?
          redirect_to [:new, @datacenter]
        else
          redirect_to [@datacenter, :server_racks]
        end
      end
    end
  end

  def update
    @datacenter = Datacenter.find(params[:id])

    @datacenter.update_attributes(params[:datacenter])

    respond_with @datacenter, :location => [@datacenter, :server_racks] do |format|
      format.html
      format.iphone do
        if @datacenter.errors.any?
          redirect_to [:edit, @datacenter]
        else
          redirect_to [@datacenter, :server_racks]
        end
      end
    end

  end

  def destroy
    @datacenter = Datacenter.find(params[:id])
    @datacenter.destroy

    respond_with @datacenter, :location => [current_datacenter, :server_racks] do |format|
      format.html
      format.iphone { redirect_to :action => "index"}
    end
  end
end

class ListingsController < ApplicationController

  def show
    id = params[:id] # retrieve listing ID from URI route
    @listing = Listing.find(id) # look up listing by unique ID
    # will render app/views/Listings/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'name'
      ordering, @name_header_css = { :name => :asc }, 'bg-warning hilite'
    when 'purchase_date'
      ordering, @date_header_css = { :purchase_date => :asc }, 'bg-warning hilite'
    end

    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort and return
    end

    if sort
      @listings = Listing.all.order(ordering)
    else
      @listings = Listing.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @listing = Listing.create!(listing_params)
    flash[:notice] = "#{@listing.name} was successfully created."
    redirect_to listings_path
  end

  def edit
    @listing = Listing.find params[:id]
  end

  def update
    @listing = Listing.find params[:id]
    @listing.update_attributes!(listing_params)
    flash[:notice] = "#{@listing.name} was successfully updated."
    redirect_to listing_path(@listing)
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    flash[:notice] = "Listing '#{@listing.name}' deleted."
    redirect_to listings_path
  end

  private
  def listing_params
    # https://api.rubyonrails.org/v6.1.4/classes/ActionController/StrongParameters.html
    params.require(:listing).permit(:name, :description, :elevator_building, :pickup_only, :purchase_date)
  end
end

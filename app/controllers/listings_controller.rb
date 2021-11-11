class ListingsController < ApplicationController

  def show
    id = params[:id] # retrieve listing ID from URI route
    @listing = Listing.find(id) # look up listing by unique ID
    # will render app/views/Listings/show.<extension> by default
  end

  def index
    @listings = Listing.all

    # Preference pickup / deliver
    unless params.has_key?('filter_pick_up') && params.has_key?('filter_deliver')
      if params.has_key?('filter_pick_up') # Pick up only
        @listings = @listings.where(pickup_only: true)
      elsif params.has_key?('filter_deliver')
        @listings = @listings.where.not(pickup_only: true)
      end
    end

    # Elevator building
    if params.has_key?('filter_elevator')
      @listings = @listings.where(elevator_building: true)
    end

    # Search keyword
    if params.has_key?('query') && !params[:query].blank?
      input = params[:query]
      search_words = input.split(' ')
      result = []

      search_words.each do |word|
        result.concat(@listings.where("name LIKE ?", "%#{word}%").to_a)
      end
      @listings = result
    end

    @no_results = @listings.empty?

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

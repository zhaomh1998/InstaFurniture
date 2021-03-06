class ListingsController < ApplicationController

  def get_user_info
    if session.has_key?(:uid)
      # User logged in
      uid = session[:uid]
      User.get_user_info(uid)
    else
      # User not logged in
      nil
    end
  end

  def show
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
      return
    end
    id = params[:id] # retrieve listing ID from URI route
    @listing = Listing.find(id) # look up listing by unique ID
    @owner_email = User.get_email(@listing[:uid])
    @owns_listing = @listing[:uid] == @user[:uid]
    # will render app/views/Listings/show.<extension> by default
  end

  def index
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
      return
    end
    @listings = Listing.all
    @last_query = {
      :pickup => true,
      :deliver => true,
      :elevator => false
    }

    # Preference pickup / deliver
    unless params.has_key?('filter_pick_up') && params.has_key?('filter_deliver')
      if params.has_key?('filter_pick_up') # Pick up only
        @listings = @listings.where(pickup_only: true)
        @last_query[:pickup] = true
        @last_query[:deliver] = false
      elsif params.has_key?('filter_deliver')
        @listings = @listings.where.not(pickup_only: true)
        @last_query[:pickup] = false
        @last_query[:deliver] = true
      end
    end

    # Elevator building
    if params.has_key?('filter_elevator')
      @listings = @listings.where(elevator_building: true)
      @last_query[:elevator] = true
    end

    @show_my_listings = false
    # My listings
    if params.has_key?('filter_my_listings')
      @listings = @listings.where(uid: @user[:uid])
      @show_my_listings = true
    end

    # Search keyword
    if params.has_key?('query') && !params[:query].blank?
      input = params[:query]
      @last_query[:search] = input
      search_words = input.split(' ')
      result = []

      search_words.each do |word|
        result.concat(@listings.where("LOWER(name) LIKE ?", "%#{word.downcase}%").to_a)
      end
      @listings = result
    end

    @no_results = @listings.empty?

  end

  def new
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
      return
    end
    # default: render 'new' template
  end

  def create
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
      return
    end
    new_listing_info = listing_params
    new_listing_info[:uid] = @user[:uid]
    @listing = Listing.create!(new_listing_info)
    flash[:success] = "#{@listing.name} was successfully created."
    redirect_to listings_path
  end

  def edit
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
      return
    end
    @listing = Listing.find params[:id]
    if @listing[:uid] != @user[:uid]
      flash[:notice] = "Error: You are not allowed to edit someone else's listing!"
      redirect_to listings_path
    end
  end

  def update
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
      return
    end
    @listing = Listing.find params[:id]
    if @listing[:uid] != @user[:uid]
      flash[:notice] = "Error: You are not allowed to edit someone else's listing!"
      redirect_to listings_path
      return
    end
    @listing.update_attributes!(listing_params)
    flash[:success] = "#{@listing.name} was successfully updated."
    redirect_to listing_path(@listing)
  end

  def destroy
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
      return
    end
    @listing = Listing.find(params[:id])
    if @listing[:uid] != @user[:uid]
      flash[:notice] = "Error: You are not allowed to delete someone else's listing!"
      redirect_to listings_path
      return
    end
    @listing.destroy
    flash[:success] = "Listing '#{@listing.name}' deleted."
    redirect_to listings_path
  end

  private

  def listing_params
    # https://api.rubyonrails.org/v6.1.4/classes/ActionController/StrongParameters.html
    params.require(:listing).permit(:name, :description, :elevator_building, :pickup_only, :purchase_date, :photo,
                                    :location, :uid, :email, :phone, :price)
  end
end

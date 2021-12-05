class ListingsController < ApplicationController

  def get_user_info
    if not ENV['CUCUMBER_TESTING'].nil? and ENV['CUCUMBER_TESTING'] == "ENABLED"
      # Automatically log in for cucumber testing
      uid = session.has_key?(:uid)? session[:uid] : "1"
      User.get_mock_user(uid)
    elsif not ENV['RSPEC_TESTING'].nil? and ENV['RSPEC_TESTING'] == "ENABLED"
      # Automatically log in for rspec testing
      uid = session.has_key?(:uid)? session[:uid] : "1"
      User.get_mock_user(uid)
    elsif session.has_key?(:uid)
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
    end
    id = params[:id] # retrieve listing ID from URI route
    @listing = Listing.find(id) # look up listing by unique ID
    # will render app/views/Listings/show.<extension> by default
  end

  def index
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
    end
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
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
    end
    # default: render 'new' template
  end

  def create
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
    end
    @listing = Listing.create!(listing_params)
    flash[:success] = "#{@listing.name} was successfully created."
    redirect_to listings_path
  end

  def edit
    # TODO: Check user is the owner of this item
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
    end
    @listing = Listing.find params[:id]
  end

  def update
    # TODO: Check user is the owner of this item
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
    end
    @listing = Listing.find params[:id]
    @listing.update_attributes!(listing_params)
    flash[:success] = "#{@listing.name} was successfully updated."
    redirect_to listing_path(@listing)
  end

  def destroy
    # TODO: Check user is the owner of this item
    @user = get_user_info
    if @user.nil?
      flash[:notice] = 'Please log in with columbia.edu email'
      redirect_to "/users"
    end
    @listing = Listing.find(params[:id])
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

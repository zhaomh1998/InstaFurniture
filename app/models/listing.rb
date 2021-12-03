class Listing < ActiveRecord::Base
    has_one_attached :photo
    # attr_accessor :title, :price, :label, :post_date
end

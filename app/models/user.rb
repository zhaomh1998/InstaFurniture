class User < ActiveRecord::Base
    # attr_accessor :title, :price, :label, :post_date
    def self.from_omniauth(auth)
      User.find_or_create_by!(uid: auth[:uid]) do |u|
        u.provider = auth[:provider]
        u.uid = auth[:uid]
        u.oauth_token = auth[:credentials][:token]
        u.oauth_expires_at = Time.at(auth[:credentials][:expires_at])
      end
    end
end

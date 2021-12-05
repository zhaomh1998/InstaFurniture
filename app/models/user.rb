class User < ActiveRecord::Base
  # attr_accessor :title, :price, :label, :post_date
  def self.from_omniauth(auth)
    User.find_or_create_by!(uid: auth[:uid]) do |u|
      u.provider = auth[:provider]
      u.uid = auth[:uid]
      u.oauth_token = auth[:credentials][:token]
      u.oauth_expires_at = Time.at(auth[:credentials][:expires_at])
      u.email = auth[:info][:email]
      u.first_name = auth[:info][:first_name]
      u.last_name = auth[:info][:last_name]
      u.profile_pic = auth[:info][:image]
    end
  end

  def self.get_user_info(uid)
    # Active Record will take care of building the query to avoid injection attacks
    user = User.where(uid: uid).first
    if user.nil?
      nil
    else
      {
        :uid => user[:uid],
        :email => user[:email],
        :first_name => user[:first_name],
        :last_name => user[:last_name],
        :profile_pic => user[:profile_pic]
      }
    end
  end

  def self.get_mock_user(desired_uid)
    {
      :uid => desired_uid.to_s,
      :email => "test_user@columbia.edu",
      :first_name => "Test",
      :last_name => "User",
      :profile_pic => "https://www.focusedu.org/wp-content/uploads/2018/12/circled-user-male-skin-type-1-2.png"
    }
  end

  def self.get_email(uid)
    user = User.where(uid: uid).first
    if user.nil?
      nil
    end
    user[:email]
  end
end

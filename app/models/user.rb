class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  has_many :showrooms

  def full_name
    [first_name, last_name].join(" ")
  end

  def current_showroom
    showrooms.last
  end

  def self.find_for_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password.
      self.create(:email => data.email, :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_google_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password.
      self.create(:email => data.email, :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_linkedin_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_first_name_and_last_name(data.first_name,data.last_name)
      user
    else # Create a user with a stub password.
      self.create(:first_name => data.firstName, :last_name => data.lastName, :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_first_name(data.screen_name)
      user
    else # Create a user with a stub password.
      self.create(:email => "example@gmail.com", :first_name => data.screen_name, :password => Devise.friendly_token[0,20])
    end
  end
end

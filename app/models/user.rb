class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  #DEVISE PART
  devise :database_authenticatable, 
  			 :registerable,
  			 :recoverable, 
  			 :rememberable, 
  			 :trackable, 
  			 :validatable, 
  			 :omniauthable, 
  			 :omniauth_providers => [:facebook],
  			 :authentication_keys => [:username]

  #VALIDATIONS
  	#Username Validation
	validates :username, presence: true, 
											 length: {minimum: 5, maximum: 50}, 
											 uniqueness: {case_sensitive: false}

	  #Email Validation			 
  before_save {self.email = self.email.downcase}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
									  length: {minimum: 12, maximum: 255},
									  format: {with: VALID_EMAIL_REGEX },
									  uniqueness: {case_sensitive: false}
	
	  #Password Validation
	VALID_PASSWORD_REGEX = /(?=\w*[a-z])(?=\w*[0-9])\w+/
	validates :password, presence: true, 
											 length: {minimum: 6},
											 format: {with: VALID_PASSWORD_REGEX}, 
											 allow_nil: true

	#ASSOCIATIONS
	has_many :places
	has_many :comments

  before_save {self.username = self.username.downcase}

  default_scope -> {order(username: :asc)}

  #FB OMNIAUTH
	def self.new_with_session(params, session)
	  super.tap do |user|
	    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	      user.email = data["email"] if user.email.blank?
	    end
	  end
	end

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.username = auth.info.name   # assuming the user model has a name
	    #user.image = auth.info.image # assuming the user model has an image
	  end
	end
end

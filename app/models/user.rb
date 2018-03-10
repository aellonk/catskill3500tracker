class User < ActiveRecord::Base
	has_many :peaks

  	has_secure_password

  	validates :username, :presence => true, 
                       :uniqueness => true
  validates :email,    :presence => true,
                       :uniqueness => true
                       
  	# validates_uniqueness_of :username, message: "has already been taken."
  	# validates_uniqueness_of :email, message: "That email address has already been used."

  	def slug
  	  username.downcase.gsub(" ", "-")
  	end

  	def self.find_by_slug(slug)
   	  User.all.find { |user| user.slug == slug }
  	end

end
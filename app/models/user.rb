class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  include Average
  has_secure_password
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 15}
  validates :password, :format => {:with => /\A(?=.*[A-Z].*).{6,}\z/,
                                   message: "must be at least 6 characters and include at least one capital letter"}

  def to_s
    "#{username}"
  end

end

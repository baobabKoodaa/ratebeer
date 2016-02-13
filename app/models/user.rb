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

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return findFav(:style)
  end

  def favorite_brewery
    return findFav(:brewery)
  end

  def findFav(property)
    return nil if ratings.empty?
    sums = {}
    counts = {}
    ratings.each do |r|
      p = r.beer.send(property)
      counts[p] = 0 if counts[p].nil?
      sums[p] = 0 if sums[p].nil?
      counts[p] += 1
      sums[p] += r.score
    end

    bestValue = 0
    bestName = ""
    sums.each do |key, value|
      average = sums[key] / counts[key]
      if (bestValue < average)
        bestValue = average
        bestName = key
      end

    end
    return bestName
  end

end
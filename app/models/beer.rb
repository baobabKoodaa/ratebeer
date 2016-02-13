class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :rates, -> { uniq }, through: :ratings, source: :user
  include Average
  validates :name, :presence => {:message => "must not be empty"}
  validates :style, presence: true

  def getRatingCount
    ratings.count
  end

  def to_s
    "#{self.name} by #{brewery.name}"
  end
end

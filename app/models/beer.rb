class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :rates, -> { uniq }, through: :ratings, source: :user
  include Average
  validates :name, presence: true

  def getRatingCount
    ratings.count
  end

  def to_s
    "#{self.name} by #{brewery.name}"
  end
end

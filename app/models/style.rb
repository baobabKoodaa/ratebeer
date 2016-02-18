class Style < ActiveRecord::Base
  has_many :beer

  def to_s
    "#{self.name}"
  end
end
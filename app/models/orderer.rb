class Orderer < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 100 }
  validates :color_index, presence: true
end

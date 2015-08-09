module HotDrinks
  class DrinkType < ActiveRecord::Base
    has_many :machines
    has_many :drinks, through: :machines
  end
end

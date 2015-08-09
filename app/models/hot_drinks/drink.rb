module HotDrinks
  class Drink < ActiveRecord::Base
    belongs_to :machine
  end
end

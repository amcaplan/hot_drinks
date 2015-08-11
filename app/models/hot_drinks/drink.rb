module HotDrinks
  class Drink < ActiveRecord::Base
    belongs_to :machine
    has_one :drink_type, through: :machine

    def name
      drink_type.name
    end
  end
end

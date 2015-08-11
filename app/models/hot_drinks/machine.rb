module HotDrinks
  class Machine < ActiveRecord::Base
    belongs_to :drink_type
    has_many :drinks

    def brew
      self.drinks << Drink.new
    end
  end
end

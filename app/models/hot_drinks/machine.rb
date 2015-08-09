module HotDrinks
  class Machine < ActiveRecord::Base
    belongs_to :drink_type
  end
end

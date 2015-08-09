module HotDrinks
  class Machine < ActiveRecord::Base
    belongs_to :drink_type
    has_many :drinks
  end
end

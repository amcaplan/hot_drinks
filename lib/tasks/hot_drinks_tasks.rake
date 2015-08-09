desc "seed the database with tea and coffee DrinkTypes"
namespace :hot_drinks do
  namespace :db do
    task :seed do
      HotDrinks::DrinkType.create!(name: "tea")
      HotDrinks::DrinkType.create!(name: "coffee")
    end
  end
end

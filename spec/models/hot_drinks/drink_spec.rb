require 'rails_helper'

module HotDrinks
  RSpec.describe Drink, type: :model do
    subject {
      FactoryGirl.create(:hot_drinks_drink, machine: machine)
    }

    let(:machine) {
      FactoryGirl.create(:hot_drinks_machine, drink_type: drink_type)
    }

    let(:drink_type) {
      FactoryGirl.create(:hot_drinks_drink_type, name: drink_name)
    }

    let(:drink_name) { 'coffee' }

    describe 'getting the name of a drink' do
      it 'pulls the name from the drink type' do
        expect(subject.name).to eq(drink_name)
      end
    end
  end
end

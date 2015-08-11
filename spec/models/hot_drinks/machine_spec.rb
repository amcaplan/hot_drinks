require 'rails_helper'

module HotDrinks
  RSpec.describe Machine, type: :model do
    subject {
      FactoryGirl.create(:hot_drinks_machine, drink_type: drink_type)
    }

    let(:drink_type) {
      FactoryGirl.create(:hot_drinks_drink_type, name: drink_name)
    }

    def brewed_drink
      subject.drinks.first
    end

    context 'a coffee machine' do
      let(:drink_name) { 'coffee' }

      before do
        expect(subject.drinks).to be_empty
      end

      it 'brews a cup of coffee' do
        subject.brew
        expect(brewed_drink.name).to eq(drink_name)
      end

      it 'persists the drinks' do
        expect { subject.brew }.to change{ Drink.count }.by(1)
      end
    end

    context 'a tea machine' do
      let(:drink_name) { 'tea' }

      before do
        expect(subject.drinks).to be_empty
      end

      it 'brews a cup of tea' do
        subject.brew
        expect(brewed_drink.name).to eq(drink_name)
      end
    end
  end
end

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

module HotDrinks
  RSpec.describe MachinesController, type: :controller do

    # This should return the minimal set of attributes required to create a valid
    # Machine. As you add validations to Machine, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      skip("Add a hash of attributes valid for your model")
    }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # MachinesController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all machines as @machines" do
        machine = Machine.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:machines)).to eq([machine])
      end
    end

    describe "GET #show" do
      it "assigns the requested machine as @machine" do
        machine = Machine.create! valid_attributes
        get :show, {:id => machine.to_param}, valid_session
        expect(assigns(:machine)).to eq(machine)
      end
    end

    describe "GET #new" do
      it "assigns a new machine as @machine" do
        get :new, {}, valid_session
        expect(assigns(:machine)).to be_a_new(Machine)
      end
    end

    describe "GET #edit" do
      it "assigns the requested machine as @machine" do
        machine = Machine.create! valid_attributes
        get :edit, {:id => machine.to_param}, valid_session
        expect(assigns(:machine)).to eq(machine)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Machine" do
          expect {
            post :create, {:machine => valid_attributes}, valid_session
          }.to change(Machine, :count).by(1)
        end

        it "assigns a newly created machine as @machine" do
          post :create, {:machine => valid_attributes}, valid_session
          expect(assigns(:machine)).to be_a(Machine)
          expect(assigns(:machine)).to be_persisted
        end

        it "redirects to the created machine" do
          post :create, {:machine => valid_attributes}, valid_session
          expect(response).to redirect_to(Machine.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved machine as @machine" do
          post :create, {:machine => invalid_attributes}, valid_session
          expect(assigns(:machine)).to be_a_new(Machine)
        end

        it "re-renders the 'new' template" do
          post :create, {:machine => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested machine" do
          machine = Machine.create! valid_attributes
          put :update, {:id => machine.to_param, :machine => new_attributes}, valid_session
          machine.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested machine as @machine" do
          machine = Machine.create! valid_attributes
          put :update, {:id => machine.to_param, :machine => valid_attributes}, valid_session
          expect(assigns(:machine)).to eq(machine)
        end

        it "redirects to the machine" do
          machine = Machine.create! valid_attributes
          put :update, {:id => machine.to_param, :machine => valid_attributes}, valid_session
          expect(response).to redirect_to(machine)
        end
      end

      context "with invalid params" do
        it "assigns the machine as @machine" do
          machine = Machine.create! valid_attributes
          put :update, {:id => machine.to_param, :machine => invalid_attributes}, valid_session
          expect(assigns(:machine)).to eq(machine)
        end

        it "re-renders the 'edit' template" do
          machine = Machine.create! valid_attributes
          put :update, {:id => machine.to_param, :machine => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested machine" do
        machine = Machine.create! valid_attributes
        expect {
          delete :destroy, {:id => machine.to_param}, valid_session
        }.to change(Machine, :count).by(-1)
      end

      it "redirects to the machines list" do
        machine = Machine.create! valid_attributes
        delete :destroy, {:id => machine.to_param}, valid_session
        expect(response).to redirect_to(machines_url)
      end
    end

  end
end

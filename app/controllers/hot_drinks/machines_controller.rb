require_dependency "hot_drinks/application_controller"

module HotDrinks
  class MachinesController < ApplicationController
    before_action :set_machine, only: [:show, :edit, :update, :destroy]

    # GET /machines
    def index
      @machines = Machine.all
    end

    # GET /machines/1
    def show
    end

    # GET /machines/new
    def new
      @machine = Machine.new
    end

    # GET /machines/1/edit
    def edit
    end

    # POST /machines
    def create
      @machine = Machine.new(machine_params)

      if @machine.save
        redirect_to @machine, notice: 'Machine was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /machines/1
    def update
      if @machine.update(machine_params)
        redirect_to @machine, notice: 'Machine was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /machines/1
    def destroy
      @machine.destroy
      redirect_to machines_url, notice: 'Machine was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_machine
        @machine = Machine.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def machine_params
        params.require(:machine).permit(:name, :drink_type_id)
      end
  end
end

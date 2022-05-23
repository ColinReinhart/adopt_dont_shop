class ApplicationsController < ApplicationController

  def show
    @applications = Application.find(params[:id])
    # require "pry"; binding.pry
    @applications.pets << Pet.find(params[:pet]) if params[:pet]

    if params[:pet_select].present?
      @result = Pet.search(params[:pet_select])
    else
      @result
    end
  end

  def index
    @applications = Application.all
  end

  def new

  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private

    def application_params
      params.permit(:name, :street_address, :city, :state, :zip)
    end
end

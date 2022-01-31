class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_res

  def index
    render json: Spice.all
  end

  def create
    spice = Spice.create(create_spice)
    render json: spice, status: :created
  end

  def update
    spice = find_spice
    spice.update(create_spice)
    render json: spice
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :no_content
  end

  private

  def create_spice
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def find_spice
    Spice.find(params[:id])
  end

  def not_found_res
    render json: {error: "Spice not found"}, status: :not_found
  end
end

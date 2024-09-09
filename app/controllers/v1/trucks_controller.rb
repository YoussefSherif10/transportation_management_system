# frozen_string_literal: true

class V1::TrucksController < ApplicationController
  before_action :authenticate_request
  before_action :set_truck, only: [:assign_driver]

  # GET /v1/trucks
  def index
    @pagy, @trucks = pagy(Truck.sorted, items: params[:per_page] || 10)
    render_jsonapi @trucks, meta: pagy_metadata(@pagy)
  end

  # POST /v1/trucks/:id/assign
  def assign_driver
    assignment = @truck.assignments.build(driver: @current_driver)
    if assignment.save
      render_jsonapi @truck, status: :created
    else
      render json: { errors: assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /v1/trucks/assigned
  def assigned_trucks
    @pagy, @trucks = pagy(@current_driver.trucks.sorted, items: params[:per_page] || 10)
    render_jsonapi @trucks, meta: pagy_metadata(@pagy)
  end

  private

  def set_truck
    @truck = Truck.find(params[:id])
  end

  def pagy_metadata(pagy)
    {
      current_page: pagy.page,
      total_pages: pagy.pages,
      total_count: pagy.count,
      per_page: pagy.items
    }
  end
end

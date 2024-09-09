# frozen_string_literal: true

class V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]

  # POST v1/register
  def register
    @driver = Driver.new(driver_params)
    if @driver.save
      token = jwt_encode(driver_id: @driver.id)
      render json: { token: }, status: :created
    else
      render json: { errors: @driver.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST v1/login
  def login
    @driver = Driver.find_by_email(params[:email])
    if @driver&.authenticate(params[:password])
      token = jwt_encode(driver_id: @driver.id)
      render json: { token: }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def driver_params
    params.permit(:email, :password)
  end
end

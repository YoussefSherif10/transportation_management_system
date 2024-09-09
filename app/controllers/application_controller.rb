# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_driver = Driver.find(decoded[:driver_id])
  end
end

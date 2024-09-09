# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken
  include Pagy::Backend

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_driver = Driver.find(decoded[:driver_id])
  end

  def render_jsonapi(resource, options = {})
    options[:is_collection] = true if resource.respond_to?(:size)
    serialized_resource = JSONAPI::Serializer.serialize(resource, options)
    render json: serialized_resource
  end
end

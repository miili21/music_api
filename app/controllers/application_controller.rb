class ApplicationController < ActionController::API
  # Hacemos  que cuando no se encuentre un modelo se ejecute el modelo.

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found
    render json: { error: "Resource not found" }, status: :not_found
  end
end

class ApplicationController < ActionController::API
  
  def not_found
    render json: {error: "not found"}  
  end

  def current_user
  	header = auth_header
  	header = header.split(' ').last if header
    begin
  	  decoded = JsonWebToken.decode(header)
  	  User.find(decoded[:user_id])
  	rescue ActiveRecord::RecordNotFound => e
      render json: {errors: e.message}, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: {errors: e.message, message: "invalid token"}, status: :unauthorized
  	end
  end

  
  def authorize_request
  	if current_user
  		return true
  	else
      render json: {errors: "please login"}, status: :unauthorized
  	end
  end

  def auth_header
    request.headers['Authorization']
  end



end

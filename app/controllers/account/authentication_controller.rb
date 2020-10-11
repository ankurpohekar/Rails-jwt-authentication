class Account::AuthenticationController < ApplicationController

	def login
		data = params[:account]
		@user = User.find_by(email: data[:email])
		if @user&.authenticate(data[:password])
			token = JsonWebToken.encode(user_id: @user.id)
			time = Time.current + 24.hours.to_i
			render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: :ok
		else
			render json: { error: 'unauthorized' }, status: :unauthorized
	  end 
	end

end
class UsersController < ApplicationController
  before_action :authorize_request, except: [:create]
  before_action :set_user, except: %i[create index]

  def index
  	@users = User.all
  	render json: {id: @users}, status: 'ok'
  end

  def show
  	render json: @user, status: 'ok'
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  	  render json: @user, status: 'ok'
  	else
  		render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
  	end
  end

  def update
  	if @user.update(user_params)
  		render json: {message: "user updated successfully"}, status: 'ok'
  	else
  		render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
  	end
  end

  def destroy
    @user.destroy
  end

  private
  def set_user
  	@user = Uesr.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    	render json: {errors: "user not found"}, status: :not_found
  end

  def user_params
  	params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end

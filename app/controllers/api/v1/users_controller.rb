class Api::V1::UsersController < ApplicationController

  def index
    user = User.all
    render json: user
  end

  def show

    @user = User.find_by(id: params[:id])

    if authorized?(@user)
      render json: {
            user_id: @user.id,
            username: @user.username,
            password: @user.password,
            email: @user.email,
            exploded: @user.exploded,
            defused: @user.defused,
          }

    else
      render json: { go_away: true }, status: :unauthorized
    end

  end


  def create
    @user = User.new(user_params)

    if (@user.save)
      render json: {
        username: @user.username,
        token: token_json(@user)
      }
    else
      render json: {errors: @user.errors.full_messages},
      status: :unprocessible_entity
    end

  end

  def update
    @user.update(user_params)
    if @user.save
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_id,:username, :password, :email)
  end

end

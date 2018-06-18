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
    @user = User.create(username: params["username"], password: params["password"], email: params["email"])

    if (@user.save)
      render json: token_json(@user),
      status: :accepted
    else
      render json: {errors: @user.errors.full_messages},
      status: :unprocessible_entity
    end

  end

  def update
    @user = User.find_by(id: params[:id])
    if authorized?(@user)

      if @user.update(exploded: params["exploded"], defused: params["defused"])
          render json: {
            exploded: @user.exploded,
            defused: @user.defused,
          },
          status: :accepted
        else
          render json: {
            errors: "Must be logged in!"
          }, status: :unauthorized
        end

    end

  end

  private

  def user_params
    params.require(:user).permit(:user_id,:username, :password, :email, :exploded, :defused)
  end

end

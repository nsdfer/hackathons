# frozen_string_literal: true

class V0::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create!(require_params)

    VerifyUserService.send_code(@user)
  end

  def update
    @user = User.find(params[:id])
    @user.update!(accept_params)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!(accept_params)

    head :no_content
  end

  def verify
    @user = User.find(params[:id])

    return head :unauthorized unless VerifyUserService.verify(user: @user, code: params[:code])

    head :ok
  end

  private

  def accept_params
    params.permit(
      :first_name,
      :last_name,
      :language,
      :phone_number
    )
  end

  def require_params
    params.permit(
      :first_name,
      :last_name,
      :language,
      :phone_number
    )
  end
end

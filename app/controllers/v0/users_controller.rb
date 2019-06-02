# frozen_string_literal: true

class V0::UsersController < ApplicationController
  def index
    @users = User.all

    render
  end

  def show
    @user = User.find(params[:id])

    render
  end

  def create
    @user = User.create!(require_params)

    render
  end

  def update
    @user = User.find(params[:id])
    @user.update!(accept_params)

    render
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!(accept_params)

    head :no_content
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

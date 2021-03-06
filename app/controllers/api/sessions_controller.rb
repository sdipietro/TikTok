class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password],
      # params[:user][:email]
    )

    if @user
      login(@user)
      render "api/users/show"
    else
      render json: ["Incorrect account or password"], status: 401
    end
  end

  def destroy
    @user = current_user
    if @user
      logout
      # render "api/users/show"
      render json: {}
    else
      render json: ["Nobody is signed in"], status: 404
    end
  end
end
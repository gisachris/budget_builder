class UsersController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show
    return unless params[:id] == 'sign_out'

    sign_out current_user
    redirect_to new_user_session_path
  end
end

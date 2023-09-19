class StaticPagesController < ApplicationController
  def splash
    @user = current_user

    if user_signed_in?
      redirect_to user_categories_path(@user)
    end
  end
end

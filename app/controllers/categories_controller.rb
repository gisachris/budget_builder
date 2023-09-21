class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @categories = @user.categories.all
  end

  def show
    @user = User.find(params[:user_id])
    @category = Category.find(params[:id])
    @deals = @category.deals
    @total = total_amount(@category)
  end

  def new
    @user = User.find(params[:user_id])
    @category = @user.categories.build
  end

  def create
    @user = current_user
    @category = @user.categories.build(category_params)

    if @category.save
      redirect_to user_categories_path(@user), notice: 'Category created successfully'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def total_amount(category)
    all_deals = category.deals
    all_deals.sum(:amount)
  end
end

class DealsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])
    @deal = Deal.find(params[:id])
    @category = @deal.categories.first
  end

  def new
    @user = current_user
    @deal = @user.deals.build
    @categorydeal = CategoryDeal.new
    @categories = @user.categories.all
  end

  def create
    @user = current_user
    @deal = @user.deals.build(deal_params)
    @categorydeal = CategoryDeal.new
    @category = Category.find(category_deal_params[:category_id])
    @categorydeal.category = @category

    if @deal.save
      @categorydeal.deal = @deal
      redirect_to user_category_path(@user, @category), notice: 'Transaction created successfully' if @categorydeal.save
    else
      @categories = @user.categories.all
      render :new
    end
  end

  def edit
    @user = current_user
    @deal = Deal.find(params[:id])
  end

  def update
    @user = current_user
    @deal = Deal.find(params[:id])

    if @deal.update(deal_params)
      redirect_to user_deal_path(@user, @deal), notice: 'Deal updated successfully'
    else
      render :edit
    end
  end

  private

  def deal_params
    params.require(:transaction).permit(:name, :amount)
  end

  def category_deal_params
    params.require(:transaction).permit(:category_id)
  end
end

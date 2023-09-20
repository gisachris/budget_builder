class DealsController < ApplicationController
  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private
  def deal_params
    params.require(:deal).permit(:name, :amount, :category_id)
  end
end

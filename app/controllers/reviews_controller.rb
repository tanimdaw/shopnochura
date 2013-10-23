class ReviewsController < ApplicationController
  def new
    @company = Company.find(params[:company_id])
    @review = @company.reviews.build
  end

  def create
    @review = current_user.reviews.new(params[:review])
    @review.company_id = params[:company_id]
    if @review.save
      flash[:notice] = "Review saved"
    else
      render :new
    end  
  end

  def edit
  end

  def update
  end

  def index
    @reviews = Review.all
  end

  def show
    @company = Company.find(params[:company_id])
    @review = Review.find(params[:id])
  end
end

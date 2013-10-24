class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  before_filter :require_login, :only => [:new, :create]

  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def show
  	@company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end
  
  def create
    @company = Company.new(params[:company])
    if @company.save
      flash[:notice] = "Congrets. Now write down the review of your company"
      redirect_to new_company_review_path(@company)
    else
      render :new
    end 

  end  



  
end

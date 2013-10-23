class PublicController < ApplicationController
  def home
  	@reviews = Review.all
  end
end

class PublicController < ApplicationController
  def home
  	fetch = FetchJobs.new
  	@reviews = Review.all
  end
end

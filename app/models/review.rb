class Review < ActiveRecord::Base
  attr_accessible :company_id, :content, :title, :user_id,
  :positive_sides, :negative_sides

  belongs_to :user
  belongs_to :company 


end

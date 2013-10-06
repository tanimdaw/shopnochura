class AddPositiveSideAndNegativeSideToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :positive_sides, :text
  	add_column :reviews, :negative_sides, :text
  end
end

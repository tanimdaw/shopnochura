class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :company_id
      t.string :user_id
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end

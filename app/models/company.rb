class Company < ActiveRecord::Base
  attr_accessible :address, :title

  has_many :reviews

end

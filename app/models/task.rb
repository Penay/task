class Task < ActiveRecord::Base
  attr_accessible :name, :shared_by

  has_many :appointments
  has_many :users, :through => :appointments
  
  validates :name, presence: true, uniqueness: true

end

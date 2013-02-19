class Appointment < ActiveRecord::Base
  attr_accessible :task_id, :user_id

    attr_accessible :user_id, :task_id, :task


  belongs_to :task
  belongs_to :user

end

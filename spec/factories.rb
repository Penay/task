FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :task do
    sequence(:name) { |n| "task#{n}"}   
  end

  factory :appointment do
  	task = Task.create(id: 1, name: "lol")
  	user = User.create(email: "lol@mail.com", password: "123456")
  	Appointment.create(user_id: user.id,task_id: task.id,)
  end


end
require 'spec_helper'

describe "Tasks" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  before { visit new_task_path }

  describe "visiting new task page" do
    before { visit new_task_path }
    it { should have_selector('h2', text: 'New task') }
  end

  describe "task creation" do

    describe "with invalid information" do

   
      
      it "should not create a task" do
        expect { click_button "Create Task" }.not_to change(Task, :count)
      end

      describe "error messages" do
        before { click_button "Create Task" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'task_name', with: "Lorem ipsum" }
      it "should create a task" do
        expect { click_button "Create Task" }.to change(Task, :count).by(1)
      end
    end
  end

  describe "visit tasks page" do
    before {visit tasks_path}
  	describe "visit page with no owned tasks" do
	  	it { should have_selector('p', text: 'You have no tasks yet. You can create them using link below.') }
	 end

    let(:task) { FactoryGirl.create(:task) }
    before { Appointment.create(task_id: task.id, user_id: user.id)}
  	describe "visit page with owned tasks" do
  	  	before {visit tasks_path}
  	  	it { should have_selector('h2', text: 'Listing tasks') }
  	end
  end

  describe "visit task page" do
    let(:task) { FactoryGirl.create(:task) }
    before {visit task_path(task)}
    describe "visit page not his task" do
       it { should have_selector('div.alert.alert-error', text: 'You are not allowed to be here!') }
   end
   
   # before {visit tasks_path}
   #  before { FactoryGirl.create(:appointment) }
      
   #   describe "visit page with owned tasks" do
      
   #     before { click_link "Show" }

   #    it { should have_selector('h2', text: 'Listing tasks') }
   #   end
  end




 





end

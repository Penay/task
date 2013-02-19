require 'spec_helper'

describe Task do
   before do
    @task = Task.new(name: "new_name")
  end

  subject { @task }

  it { should respond_to(:name) }

  describe "when name is not present" do
    before { @task.name = " " }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      task_with_same_name = @task.dup
      task_with_same_name.name = @task.name
      task_with_same_name.save
    end

    it { should_not be_valid }
  end

end

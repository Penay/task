require 'spec_helper'

describe "tasks/show" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :name => "Name",
      :shared_by => "Shared By"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Shared By/)
  end
end

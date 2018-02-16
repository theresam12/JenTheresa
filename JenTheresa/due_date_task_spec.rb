require 'rspec'
require_relative 'due_date_task'

describe "Due Date Task" do
  before (:each) do
    @shop = DueDateTask.new "Shop", "Buy milk", "2018-02-16"
  end

  it "can create a task with due date" do
    expect(@shop).to be_a DueDateTask
  end

  it "has a deadline" do
    expect(@shop.deadline).to eq "2018-02-16"
  end

  it "can show task details" do
    expect(@shop.show_task)
    .to eq "Title: Shop Description: Buy milk Deadline: 2018-02-16"
  end
end

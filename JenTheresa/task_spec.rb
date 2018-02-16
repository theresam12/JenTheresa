require 'rspec'
require_relative 'task'
require_relative 'tasklist'
require 'byebug'

describe "Task" do
  before (:each) do
    @doLaundry = Task.new "Laundry","Brown is such a nice color."
    @theresasList = Tasklist.new
  end

  it "can create a task" do
    expect(@doLaundry).to be_a Task
  end

  it "can have a title" do
    expect(@doLaundry.title).to eq ("Laundry")
  end

  it "can have a description and be retreived" do
    expect(@doLaundry.description).to eq("Brown is such a nice color.")
  end

  it "can be marked as done" do
    expect(@doLaundry.show_done).to be false
    @doLaundry.mark_done
    expect(@doLaundry.show_done).to be true
  end

  it "can be printed as done" do
    @doLaundry.mark_done
    expect(@doLaundry.show_done).to be true
    expect(@doLaundry.get_status).to eq "Laundry is done"
  end

  it "can be printed as not done" do
    expect(@doLaundry.show_done).to be false
    expect(@doLaundry.get_status).to eq "Laundry needs to be done"
  end
end

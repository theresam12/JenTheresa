require 'rspec'
require_relative 'tasklist'
require_relative 'task'
require_relative 'due_date_task'

=begin
Story: As a developer with a TaskList, I can list all the not completed items in order of due date.

Story: As a developer with a TaskList with and without due dates, I can list all the not completed items in order of due date, and then the items without due dates.
=end

describe "Tasklist" do
  before (:each) do
    @tasklist = Tasklist.new

    @doLaundry = Task.new "Laundry","Brown is such a nice color."
    @study = Task.new "Study","Read js stuff"
    @clean = Task.new "Clean","Clean kitchen and bathroom"

    @shop = DueDateTask.new "Shop", "Buy milk", "2018-02-25"
    @bills = DueDateTask.new "Bills", "Pay credit card and water bills", "2018-02-21"
    @bake = DueDateTask.new "Bake", "Bake birthday cake", "2018-02-16"
    @exercise = DueDateTask.new "exercise", "Go to Yoga", "2018-03-29"
  end

  it "should add tasks to correct list depending on if it has deadline" do
    @tasklist.add_to_list @doLaundry
    @tasklist.add_to_list @study
    @tasklist.add_to_list @clean

    @tasklist.add_to_list @shop
    @tasklist.add_to_list @bills
    @tasklist.add_to_list @bake

    expect(@tasklist.tasksWithoutDeadlines).to eq [@doLaundry, @study, @clean]
    expect(@tasklist.tasksWithDeadlines).to eq [@shop, @bills, @bake]
  end

  it "can show done tasks" do
    @tasklist.add_to_list @doLaundry
    @tasklist.add_to_list @study
    @doLaundry.mark_done
    expect(@doLaundry.show_done).to be true
    @study.mark_done
    expect(@study.show_done).to be true
    @tasklist.add_to_completed
    expect(@tasklist.show_completed).to eq [@doLaundry, @study]
  end

  it "can show incomplete tasks" do
    @tasklist.add_to_list @doLaundry
    @tasklist.add_to_list @study
    @tasklist.add_to_list @clean
    @doLaundry.mark_done
    expect(@doLaundry.show_done).to be true
    expect(@study.show_done).to be false
    expect(@clean.show_done).to be false
    @tasklist.add_to_incomplete
    expect(@tasklist.show_incomplete).to eq [@study, @clean]
  end

  it "can print tasks due today" do
    @tasklist.add_to_list @bills
    @tasklist.add_to_list @bake
    @tasklist.find_due_today
    expect(@tasklist.show_due_today).to eq [@bake]
    p @tasklist.show_due_today
  end

  it "can print tasks in order of due date" do
    @tasklist.add_to_list @shop
    @tasklist.add_to_list @bills
    @tasklist.add_to_list @bake
    @tasklist.add_to_list @exercise
    @bake.mark_done
    @tasklist.add_to_incomplete
    # @tasklist.find_due_soon
    expect(@tasklist.find_due_soon).to eq [@bills, @shop, @exercise]
    # p @tasklist.find_due_soon
  end

  it "can print the entire list, first by due date, then tasks without dates" do
    @tasklist.add_to_list @doLaundry
    @tasklist.add_to_list @study
    @tasklist.add_to_list @clean
    @tasklist.add_to_list @shop
    @tasklist.add_to_list @bills
    @tasklist.add_to_list @bake
    @tasklist.add_to_list @exercise
    @tasklist.make_master_list
    expect(@tasklist.show_master_list).to eq [@bake, @bills, @shop, @exercise, @doLaundry, @study, @clean]
    p @tasklist.show_master_list
  end
end

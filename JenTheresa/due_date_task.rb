require 'date'
require_relative 'task'

class DueDateTask < Task
  def initialize title, description, deadline
    super title, description
    @deadline = deadline
  end

  def deadline
    @deadline
  end

  def show_task
    "Title: #{@title} Description: #{@description} Deadline: #{@deadline}"
  end
end

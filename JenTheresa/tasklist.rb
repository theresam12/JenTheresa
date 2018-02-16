require 'date'

class Tasklist
  def initialize
    @tasksWithoutDeadlines = []
    @tasksWithDeadlines = []
    @completed = []
    @incomplete = []
    @dueToday = []
    @dueSoon = []
    @master_list = []
  end

  def tasksWithoutDeadlines
    @tasksWithoutDeadlines
  end

  def tasksWithDeadlines
    @tasksWithDeadlines
  end

  def add_to_list task
    if task.respond_to?('deadline')
      @tasksWithDeadlines << task
    else
      @tasksWithoutDeadlines << task
    end
  end

  def add_to_completed
    for task in @tasksWithoutDeadlines
      if task.show_done
        @completed.push(task)
      end
    end
    for task in @tasksWithDeadlines
      if task.show_done
        @completed.push(task)
      end
    end
  end

  def show_completed
    @completed
  end

  def add_to_incomplete
    for task in @tasksWithoutDeadlines
      if !task.show_done
        @incomplete.push(task)
      end
    end
    for task in @tasksWithDeadlines
      if !task.show_done
        @incomplete.push(task)
      end
    end
  end

  def show_incomplete
    @incomplete
  end

  def find_due_today
    today = Time.now.strftime("%Y-%m-%d")
    for task in @tasksWithDeadlines
      if task.deadline == today
        @dueToday.push(task)
      end
    end
  end

  def show_due_today
    @dueToday
  end

  def find_due_soon
    for task in @incomplete
      if task.respond_to?('deadline')
        @dueSoon << task
      end
    end

    # p 'not sorted'
    # p @dueSoon
    # p 'sorted'
    return @dueSoon.sort_by {|task| task.deadline}
  end

  def make_master_list
    for task in @tasksWithDeadlines
      @master_list << task
    end
    # p @master_list

    for task in @tasksWithoutDeadlines
      @master_list << task
    end
  end

  def show_master_list
    deadlines = []
    no_deadlines = []

    for task in @master_list
      if task.respond_to?('deadline')
        deadlines << task
      else
        no_deadlines << task
      end
    end

    return deadlines.sort_by {|task| task.deadline}.concat(no_deadlines)
  end
end

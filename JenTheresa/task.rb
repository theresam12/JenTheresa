require_relative 'tasklist'

class Task
  def initialize title, description
    @title= title
    @description= description
    @done = false
  end

  def title
    @title
  end

  def description
    @description
  end

  def mark_done
    @done = !@done
  end

  def show_done
    @done
  end

  def get_status
    if @done
      p @title + " is done"
    else
      p @title + " needs to be done"
    end
  end
end

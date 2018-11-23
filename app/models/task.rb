require 'sqlite3'

class Task
  def initialize(task_params)
    @description = task_params["description"]
    @title       = task_params["title"]
    @database = SQLite3::Database.new('db/task_manager_development.db')
    @database.results_as_hash = true
  end

  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES (?, ?);", @title, @description)
  end
end

require 'sqlite3'

class Task
  attr_reader :id, :title, :description

  def initialize(task_params)
    @id = task_params["id"] if task_params["id"]
    @title       = task_params["title"]
    @description = task_params["description"]
    @database = SQLite3::Database.new('db/task_manager_development.db')
    @database.results_as_hash = true
  end

  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES (?, ?);", @title, @description)
  end

  def self.database
    database = SQLite3::Database.new('db/task_manager_development.db')
    database.results_as_hash = true
    database
  end

  def self.all
    tasks = database.execute("SELECT * FROM tasks")
    tasks.map do |task|
      Task.new(task)
    end
  end

  def self.find(id)
    task = database.execute("SELECT * FROM tasks WHERE id = ?", id.to_i).first
    Task.new(task)
  end

  def self.update(id, task_params)
    database.execute(
      "UPDATE tasks
      SET title = ?,
      description = ?
      WHERE id = ?;",
      task_params[:title],
      task_params[:description],
      id
    )

    Task.find(id)
  end
end

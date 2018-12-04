require'pg'
require('pry')
# require'./spec/spec_helper'

DB = PG.connect({:dbname => 'to_do_test'})


class Task
  attr_reader(:id, :name, :description, :due_date, :set_up_date, :finished, :list_id)

  def initialize(attributes)
    @id = attributes.fetch(:id).to_i
    @name = attributes.fetch(:name)
    @description = attributes.fetch(:description)
    @due_date = attributes.fetch(:due_date)
    @list_id = attributes.fetch(:list_id).to_i
    @set_up_date = Time.now
    @finished = false
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      name = task.fetch("name")
      description = task.fetch("description")
      due_date = task.fetch("due_date")
      set_up_date = task.fetch("set_up_date")
      finished = task.fetch("finished")
      id = task.fetch('id')
      list_id = task.fetch('list_id').to_i
      tasks.push(Task.new({:name => name, :description => description, :due_date => due_date, :set_up_date => set_up_date, :finished => finished, :id => id, :list_id => list_id}))
    end
    tasks
  end

  def self.sort
    returned_tasks = DB.exec("SELECT * FROM tasks ORDER BY due_date;")
    tasks = []
    returned_tasks.each() do |task|
      name = task.fetch("name")
      description = task.fetch("description")
      due_date = task.fetch("due_date")
      set_up_date = task.fetch("set_up_date")
      finished = task.fetch("finished")
      id = task.fetch('id')
      list_id = task.fetch('list_id').to_i
      tasks.push(Task.new({:name => name, :description => description, :due_date => due_date, :set_up_date => set_up_date, :finished => finished, :id => id, :list_id => list_id}))
    end
    tasks
  end

  def self.find(id)
    returned_tasks = DB.exec("SELECT * FROM tasks WHERE id = #{id};")
    returned_tasks.each() do |task|
      name = task.fetch("name")
      description = task.fetch("description")
      due_date = task.fetch("due_date")
      set_up_date = task.fetch("set_up_date")
      finished = task.fetch("finished")
      id = task.fetch('id').to_i
      list_id = task.fetch('list_id').to_i
      return Task.new({:name => name, :description => description, :due_date => due_date, :set_up_date => set_up_date, :finished => finished, :id => id, :list_id => list_id})
    end
  end

  # def self.find_by_list(list_id)
  #   returned_tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{list_id};")
  #   tasks = []
  #   returned_tasks.each() do |task|
  #     name = task.fetch("name")
  #     description = task.fetch("description")
  #     due_date = task.fetch("due_date")
  #     set_up_date = task.fetch("set_up_date")
  #     finished = task.fetch("finished")
  #     id = task.fetch('id').to_i
  #     list_id = task.fetch('list_id').to_i
  #     tasks.push(Task.new({:name => name, :description => description, :due_date => due_date, :set_up_date => set_up_date, :finished => finished, :id => id, :list_id => list_id}))
  #   end
  #   tasks
  # end

  def save
    result = DB.exec("INSERT INTO tasks (name, description, due_date, set_up_date, finished, list_id) VALUES ('#{@name}', '#{@description}', '#{@due_date}', '#{@set_up_date}', '#{@finished}', #{@list_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_list)
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end

end

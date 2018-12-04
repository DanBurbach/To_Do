
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pry')

get('/') do
  @lists = List.all
  erb(:input)
end

post('/add_list') do
  name = params.fetch('name')
  list = List.new({:name => name, :id => nil})
  list.save
  @name = list.name
  @lists = List.all
  erb(:input)
end

get('/list/:id') do
  @list_id = params[:id].to_i
  list = List.find(@list_id)
  @name = list.name
  @tasks = Task.all
  erb(:list)
end

post('/add_item/:id') do
  @list_id = params[:id].to_i
  list = List.find(@list_id)
  @name = list.name
  @task_name = params.fetch('name')
  @description = params.fetch('description')
  @due_date = params.fetch('due_date')
  task = Task.new({:name => @task_name, :description =>  @description, :due_date => @due_date, :id => nil, :list_id => @list_id})
  task.save
  @tasks = Task.all
  erb(:list)
end

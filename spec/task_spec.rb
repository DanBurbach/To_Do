require 'spec_helper'

  describe('Task') do
    describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe('#initialize') do
    it('will create a new instance of Task') do
      task = Task.new({:name => 'Mow lawn', :description => 'Mow the front lawn soon!', :due_date => 6, :id => nil, :list_id => 1})
      task.save
      expect(task.name).to(eq('Mow lawn'))
      expect(task.description).to(eq('Mow the front lawn soon!'))
      expect(task.due_date).to(eq(6))
      #expect(task.set_up_date).to(eq(Time.now)) was returning in error due to computer processing time
      expect(task.finished).to(eq(false))
      expect(task.id).to(be_an_instance_of(Integer))
      expect(task.list_id).to(be_an_instance_of(Integer))
    end
  end

  describe('#save') do
    it('save the task to the list of tasks') do
      task = Task.new({:name => 'Mow lawn', :description => 'Mow the front lawn soon!', :due_date => 6, :id => nil, :list_id => 1})
      task.save
      expect(Task.all).to(eq([task]))
    end
  end

  describe("#==") do
    it("is the same task if it has the same name and list ID") do
      task1 = Task.new({:name => 'Mow lawn', :description => 'Mow the front lawn soon!', :due_date => 6, :id => 1, :list_id => 1})
      task2 = Task.new({:name => 'Mow lawn', :description => 'Mow the front lawn soon!', :due_date => 6, :id => 1, :list_id => 1})
      expect(task1).to(eq(task2))
    end
  end

  describe(".sort") do
    it("will sort the tasks by due date") do
      task1 = Task.new({:name => 'Do homework', :description => 'Finish math and science assignment!', :due_date => 6, :id => 1, :list_id => 1})
      task1.save
      task2 = Task.new({:name => 'Mow lawn', :description => 'Mow the front lawn soon!', :due_date => 4, :id => 1, :list_id => 1})
      task2.save
      task3 = Task.new({:name => 'Fix roof', :description => 'Fix leaky roof!', :due_date => 1, :id => 1, :list_id => 1})
      task3.save
      expect(Task.sort).to(eq([task3, task2, task1]))
    end
  end

  describe(".find") do
    it("find a task based on id") do
      task1 = Task.new({:name => 'Do homework', :description => 'Finish math and science assignment!', :due_date => 6, :id => nil, :list_id => 1})
      task1.save
      task2 = Task.new({:name => 'Mow lawn', :description => 'Mow the front lawn soon!', :due_date => 4, :id => nil, :list_id => 1})
      task2.save
      id = task1.id
      expect(Task.find(id)).to(eq(task1))
    end
  end

  describe(".find_by_list") do
    it("find a task based on list id") do
      task1 = Task.new({:name => 'Do homework', :description => 'Finish math and science assignment!', :due_date => 6, :id => nil, :list_id => 1})
      task1.save
      task2 = Task.new({:name => 'Mow lawn', :description => 'Mow the front lawn soon!', :due_date => 4, :id => nil, :list_id => 2})
      task2.save
      expect(Task.find_by_list(2)).to(eq([task2]))
    end
  end
end

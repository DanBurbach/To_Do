require'pg'
# require'./spec/spec_helper'

DB = PG.connect({:dbname => 'to_do_test'})

class List
  attr_reader(:name, :id)


  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  def self.find(id)
    returned_lists = DB.exec("SELECT * FROM lists WHERE id = #{id};")
    returned_lists.each() do |list|
      name = list.fetch("name")
      return List.new({:name => name, :id => id})
    end
  end

  def save
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_list)
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end
end

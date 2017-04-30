class SetAllTodosDoneJobJob < ApplicationJob

  queue_as :default

  def perform(*args)
    Todo.where(done: false).each do |p|
      p.visible = true
      p.save
    end
  end
end

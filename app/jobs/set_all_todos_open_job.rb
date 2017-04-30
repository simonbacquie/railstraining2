class SetAllTodosOpenJob < ApplicationJob

  queue_as :default

  def perform(*args)
    Todo.where(done: true).each do |p|
      p.visible = false
      p.save
    end
  end
end

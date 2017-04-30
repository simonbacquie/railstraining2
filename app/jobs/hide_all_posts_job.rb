class HideAllPostsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Post.where(visible: true).each do |p|
      p.visible = false
      p.save
    end
  end
end

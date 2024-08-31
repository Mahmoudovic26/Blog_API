class PostDeletionJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    Post.find_by(id: post_id)&.destroy
  end
end

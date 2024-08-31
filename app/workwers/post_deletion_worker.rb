# app/workers/post_deletion_worker.rb

class PostDeletionWorker
    include Sidekiq::Worker
  
    def perform(post_id)
      # Logic to delete the post
      post = Post.find_by(id: post_id)
      post.destroy if post.present?
    end
  end
  
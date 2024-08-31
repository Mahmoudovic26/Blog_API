class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  validates :title, :body, presence: true
  validates :tag_ids, presence: true  # Note: If you use tag_ids instead of tags

  after_create :schedule_deletion

  private

  def schedule_deletion
    PostDeletionJob.set(wait_until: 24.hours.from_now).perform_later(self.id)
  end
end

class Tag < ApplicationRecord
  has_and_belongs_to_many :posts
end

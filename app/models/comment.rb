class Comment < ApplicationRecord
  belongs_to :feature
  validates :body, uniqueness: true
end

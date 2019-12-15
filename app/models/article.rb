class Article < ApplicationRecord
  
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 60 }
end

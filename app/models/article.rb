class Article < ApplicationRecord
  
  belongs_to :user
  
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 255 }
end

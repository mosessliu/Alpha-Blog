class Category < ApplicationRecord 

  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true, uniqueness: true, length: {minimum: 3, maximum: 10}

end
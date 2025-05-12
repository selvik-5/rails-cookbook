class Category < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :recipe, through: :bookmarks
end

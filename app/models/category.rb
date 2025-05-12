class Category < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :recipe, through: :bookmarks

  validates :name, uniqueness: true

end

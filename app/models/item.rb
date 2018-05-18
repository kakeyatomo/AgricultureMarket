class Item < ApplicationRecord
  mount_uploader :item_image, ImageUploader

  belongs_to :saler, class_name: 'User', optional: true
  belongs_to :buyer, class_name: 'User', optional: true

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end

class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { minimum: 2}   
  validates :name, length: { maximum: 20} 
  validates :introduction, length: { maximum: 50} 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :books, dependent: :destroy
end

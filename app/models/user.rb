class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # belongs_to :books
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction,  length: { maximum: 50 }
  
  has_many :books,  dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # validates :name,  presence: true, length: { minimum: 2, maximum: 20 }
  
  # validates :introduction,  length: { maximum: 50 }
  
  # validates :email, presence: true
  
end

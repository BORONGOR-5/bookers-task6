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
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  
  has_many :relationships
  # ↑と同じ意味has_many :relationships, foreign_key: 'user_id'
  # 架空のfolloweruserクラス（モデル）作り出す。
  has_many :followeruser, through: :relationships, source: :follower
  # has_many :followeduser, through: :relationships, source: :followed
  # 架空の中間テーブル(reverse_of_relationships)を作り出す。
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  # 架空のfolloweduserクラス（モデル）作り出す。
  has_many :followeduser, through: :reverse_of_relationships, source: :user
  
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follower_id: other_user.id)
    end
  end
  
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follower_id: other_user.id)
    relationship.destroy if relationship
  end

  def followeruser?(other_user)
    self.followeruser.include?(other_user)
  end
  
  # def self.search(search)
  #   return User.all unless search
  #   User.where(['content LIKE ?', "%#{search}%"])
  # end
  
  #   # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  # has_many :xxx, class_name: "モデル名", foreign_key: "○○_id", dependent: :destroy
  # # @user.booksのように、@user.yyyで、
  # # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  # has_many :yyy, through: :xxx, source: :zzz
  
  
  
  
  
  # def favorited_by?(book_id)
  #   	favorites.where(book_id: book.id).exists?
  # end
  
  # def already_favorited?(book)
  #   self.favorites.exsits?(book_id: book.id)
  # end

end

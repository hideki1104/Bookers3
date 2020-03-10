class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :books, dependent: :destroy
  has_many :post_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  validates :introduction, length:{maximum: 50}
  validates :name,presence: true,length:{in:2..20}

  has_many :follower, class_name: "Relationshop", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :followed, class_name: "Relationshop", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

    # フォローしていればtrueを返す
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
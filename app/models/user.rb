class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  # バリデーションの設定
  validates :name, presence: true
  validates :age, presence: true
  # Paintingsモデルとのアソシエーション
  has_many :paintings, dependent: :destroy
  # Paintingsモデルとのアソシエーション
  has_many :painting_comments, dependent: :destroy
  # favoriteモデルをたくさん持っている
  has_many :favorites, dependent: :destroy
  has_one_attached :header_image
  has_one_attached :icon_image
  #ヘッダー画像とアイコン画像を取得するためのメソッド
  def get_header_image(width, height)
    unless header_image.attached?
      file_path = Rails.root.join('app/assets/images/no_header_image.jpg')
      header_image.attach(io: File.open(file_path), filename: 'default-header.jpg', content_type: 'image/jpeg')
    end
    header_image.variant(resize: "#{width}x#{height}!").processed
  end

  def get_icon_image(width, height)
    unless icon_image.attached?
      file_path = Rails.root.join('app/assets/images/no_icon_image.jpg')
      icon_image.attach(io: File.open(file_path), filename: 'icon-image.jpg', content_type: 'image/jpeg')
    end
    icon_image.variant(resize_to_limit: [width, height]).processed
  end
  # 検索メソッド
  def self.looks(word)
      @user = User.where("name LIKE?","%#{word}%")
  end







end


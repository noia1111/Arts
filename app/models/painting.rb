class Painting < ApplicationRecord
    has_one_attached :image
    # userモデルに所有されている
    belongs_to :user
    # painting_commentsモデルをたくさん持っている
    has_many :painting_comments, dependent: :destroy
    # favoriteモデルをたくさん持っている
    has_many :favorites, dependent: :destroy
    
    # バリデーションの設定
    validates :title, presence: true
    validates :image, presence: true
    
    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end
    
    has_one_attached :image
    
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_header_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize: "#{width}x#{height}!").processed
  end
  def get_image2
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_header_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  # 検索オプション
  def self.looks(word)
      @painting = Painting.where("title LIKE?","%#{word}%")
  end
end

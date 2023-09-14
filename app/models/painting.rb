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
  has_many :notifications, dependent: :destroy
  
  
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end

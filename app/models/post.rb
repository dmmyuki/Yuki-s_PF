class Post < ApplicationRecord

  has_one_attached :image

  has_many :favorites
  has_many :comments
  has_many :tag_managers

  # addressカラムを基準に緯度経度を算出する。
  geocoded_by :address
  # 住所変更時に緯度経度も変更する。
  after_validation :geocode

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
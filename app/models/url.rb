class Url < ApplicationRecord
  validates :original_url, presence: true, uniqueness: true, format: URI::regexp(%w(http https))
  validates :slug, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :hits, presence: true

  before_validation :generate_slug

  # Можно сделать рекурсивный метод, который будет увеличивать или просто генерировать новый slug при коллизиях
  def generate_slug
    self.slug = SecureRandom.alphanumeric(7) if slug.blank?
    true
  end

  def short
    Rails.application.routes.url_helpers.url_url(slug: slug)
  end
end

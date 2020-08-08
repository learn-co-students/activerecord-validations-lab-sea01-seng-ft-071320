class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :must_be_clickbait

  private

  # Custom validations
  def must_be_clickbait
    if !!title
      clickbait = [ "Won't Believe", 'secret', 'top', 'guess' ].none? do |clickbait|
        title.include?(clickbait)
        title.include?(clickbait.upcase)
        title.include?(clickbait.downcase)
        title.include?(clickbait.titleize)
      end

      if clickbait
        errors.add(:title, "Top ten errors raised when title isn't clickbait.")
      end
    end
  end
end

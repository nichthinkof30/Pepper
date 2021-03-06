class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  has_many :card_suggestions
  has_many :cards

  validates :title, length: { minimum: 5, maximum: 65 }
  validates :user_id, presence: :true

  # There has gotta be an AR scope for this. No?
  scope :saved, lambda { where('id > 0') }   

  def any_card_suggestions?
    @any_card_suggestions ||= card_suggestions.count > 0
  end

  def card_suggestions_count
    card_suggestions.count
  end
end

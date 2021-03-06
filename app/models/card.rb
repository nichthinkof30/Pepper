class Card < ActiveRecord::Base
  belongs_to :deck
  belongs_to :user
  validates :question, :answer, presence: :true, length: { maximum: 140, minimum: 1 }
  validates :deck_id, presence: :true

  scope :saved, -> { where('id > 0') }


  def user
    deck.user
  end
end
class CardsController < ApplicationController
  before_action :set_deck, only: [:create, :destroy, :edit]

  def create
    @card = set_deck.cards.new(card_params)

    respond_to do |format|
      format.js { create_card_js } 
    end
  end

  def edit
    @card = card
  end

  def destroy
    @card = card
    @card.destroy
    redirect_to edit_deck_path(@card.deck),
      notice: 'Card deleted.'
  end

private

  def card_params
    params.require(:card).permit(:id, :question, :answer).merge(deck_params)
  end

  def deck_params
    params.permit(:deck_id)
  end

  def card
    @card ||= Card.find(card_params[:id])
  end

  def set_deck
    @deck ||= Deck.find(card_params[:deck_id])
  end

  def create_card_js
    if @card.save
      render :create
    else
      puts "there are some errors."
      render :errors
    end
  end
end

# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home impressum]

  def impressum; end

  def home
    redirect_to controller: :pages, action: :portfolio if user_signed_in?
  end

  def portfolio
    @portfolio_table = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 20, title: true)
    @total_gain_absolut = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 21, title: false)
    @total_gain_percentage = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 22, title: false)
    @product_split = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 23, title: true)
    @sector_split = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 24, title: true)
    @type_split = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 25, title: true)
    @product_performance = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 26, title: true)
    @sector_performance = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 27, title: true)
    @geo_split = MetabaseUrlCreator.call(user_id: current_user.id, question_id: 28, title: true)
  end
end



# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home impressum]

  def impressum; end

  def home
    redirect_to controller: :pages, action: :portfolio if user_signed_in?
  end

  def portfolio; end
end

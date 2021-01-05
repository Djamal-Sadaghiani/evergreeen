# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home impressum]

  def impressum; end

  def home; end
end

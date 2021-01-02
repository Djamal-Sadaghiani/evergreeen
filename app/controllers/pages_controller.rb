class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :impressum]

  def impressum
  end


  def home
  end

end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end

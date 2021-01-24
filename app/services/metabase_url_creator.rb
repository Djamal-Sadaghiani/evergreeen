# frozen_string_literal: true

require 'jwt'

METABASE_SITE_URL = 'https://evergreeenreporting.herokuapp.com'

class MetabaseUrlCreator < ApplicationService
  def initialize(params)
    @product_id = params[:product_id]
    @user_id = params[:user_id]
    @question_id = params[:question_id]
    @options = { 'product_id' => @product_id.to_s,
                 'user_id' => @user_id.to_s }
    @title = params[:title]
  end

  def call
    payload = {
      resource: { question: @question_id },
      params: @options,
      exp: Time.now.to_i + (60 * 10) # 10 minute expiration
    }
    token = JWT.encode payload, ENV['METABASE_SECRET_KEY']

    METABASE_SITE_URL + '/embed/question/' + token + '#bordered=true&titled=' + @title.to_s
  end
end

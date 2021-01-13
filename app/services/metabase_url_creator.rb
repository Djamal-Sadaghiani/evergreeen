require 'jwt'

METABASE_SITE_URL = 'http://evergreeenreporting.herokuapp.com'

class MetabaseUrlCreator < ApplicationService
  def initialize(params)
    @product_id = params[:product_id]
  end

  def call
    payload = {
      resource: { question: 12 },
      params: {
        'product_id' => @product_id.to_s
      },
      exp: Time.now.to_i + (60 * 10) # 10 minute expiration
    }
    token = JWT.encode payload, ENV['METABASE_SECRET_KEY']

    METABASE_SITE_URL + '/embed/question/' + token + '#bordered=true&titled=true'
  end
end

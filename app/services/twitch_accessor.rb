class ClassName
  def initialize(game)
    @game = game
  end

  def get_streams
    twitch_client = Twitch::Client.new(
      client_id: ENV['TWITCH_CLIENT_ID'],
      client_secret: ENV['TWITCH_CLIENT_SECRET'],

      ## this is default
      # token_type: :application,

      ## this can be required by some Twitch end-points
      # scopes: scopes,

      ## if you already have one
      access_token: ENV['TWITCH_TOKEN']
    )
  end
end

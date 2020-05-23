require_relative 'config.rb'
require 'telegram/bot'
require 'redis'

redis = Redis.new

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/me@TbI_molodec_bot'
      counter = redis.incr(message.from.id)
      bot.api.send_message(chat_id: message.chat.id, text: "Ты молодец, #{message.from.first_name}! Уже #{counter} раз!")
    end
  end
end

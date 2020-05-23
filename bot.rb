require_relative 'config.rb'
require 'telegram/bot'
require 'redis'

redis = Redis.new

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/me@TbI_molodec_bot'
      counter = redis.incr(message.from.id)
      name = message.from.username || message.from.first_name
      bot.api.send_message(chat_id: message.chat.id, text: "Ты молодец, #{name}! Уже #{counter} раз!")
    when %r{^/you@TbI_molodec_bot}
      name = message.text.split(' ').select { |word| word[0] == '@' }.first
      counter = redis.incr(message.from.id)
      bot.api.send_message(chat_id: message.chat.id, text: "Ты молодец, #{name}! Уже #{counter} раз!")
    end
  end
end

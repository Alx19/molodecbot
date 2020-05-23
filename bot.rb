require_relative 'config.rb'
require 'telegram/bot'
require 'redis'

redis = Redis.new

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/me', %r{^/me@TbI_molodec_bot}
      if message.from.username
        counter = redis.incr(message.from.username)
        name = message.from.username
        bot.api.send_message(chat_id: message.chat.id, text: "Ты молодец, #{name}! Уже #{counter} раз!")
      else
        name = message.from.first_name
        bot.api.send_message(chat_id: message.chat.id, text: "Ты молодец, #{name}! Создай себе telegram username, чтобы я смог посчитать, сколько раз ты был молодцом!")
      end
    when %r{^/you}, %r{^/you@TbI_molodec_bot}
      name = message.text.split(' ').select { |word| word[0] == '@' }.first
      if name
        counter = redis.incr(name)
        bot.api.send_message(chat_id: message.chat.id, text: "Ты молодец, #{name}! Уже #{counter} раз!")
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Не понять, кто же молодец. Используй @username!")
      end
    end
  end
end

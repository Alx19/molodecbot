require_relative 'config.rb'
require 'telegram/bot'
require 'redis'

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/тымолодец@TbI_molodec_bot'
      puts message.text
      #bot.api.send_message(chat_id: message.chat.id, text: "Сиди дома бля, #{message.from.first_name}")
    end
  end
end

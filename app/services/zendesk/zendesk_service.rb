require 'zendesk_api'

module Zendesk
  class ZendeskService

    def initialize(source, destiny, object_id, source_type, destiny_type)
      @source = source
      @destiny = destiny
      @object_id = object_id
      @source_type = source_type
    end

    def get
      last_date = Package.find_by(source: @source)

      tickets = client.search(query: "created>#{last_date} type:#{source_type}")

      tickets.each do |t|
        Package.create(source: @source, destiny: @destiny, source_external_id: t.id, type: destiny_type)
      end
      response_format(destiny_type, tickets)
    end

    private

    def response_format(format, objects)
      if format == "card"
        Converters::Zendesk.ticket_to_card.new(objects).convert # [array de cards]
      end
    end

    def client
      ZendeskAPI::Client.new do |config|
        config.url = ENV['ZENDESK_URL']
        config.username = ENV['ZENDESK_USERNAME']
        config.token = ENV['ZENDESK_TOKEN']
        config.retry = true
        config.logger = Rails.logger
      end
    end
  end
end

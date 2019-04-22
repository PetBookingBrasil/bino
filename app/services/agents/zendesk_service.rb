# frozen_string_literal: true

require 'zendesk_api'

module Agents
  # Aggregate functions to the Zendesk Agent
  class ZendeskService < Base
    def get
      response_format(destiny_type, client.search(query: get_query))
    end

    private

    def response_format(format, objects)
      return unless format == 'card'
      Converters::TicketToTask.convert(objects)
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

    def get_query
      if object_id.nil?
        "created>#{last_date_for_source_and_package_type('zendesk', destiny_type)} type:#{source_type}"
      else
        object_id.to_s
      end
    end
  end
end

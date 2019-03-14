require 'zendesk_api'

module Zendesk
  class ZendeskImporter

    def initialize
      @agent = Agent.find_by(name: "zendesk")
    end

    def import
      last_date = @agent.last_sync.try(:strftime, "%Y-%m-%d") || 1.year.ago.strftime("%Y-%m-%d")

      tickets = client.search(query: "created>#{last_date} type:ticket")
      tickets.each do |ticket|
        Task.create(source: @agent, external_source_id: ticket.id, status: :imported)
        Runrunit::RunrunitExporter.new(ticket).export
      end
    end

    private

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

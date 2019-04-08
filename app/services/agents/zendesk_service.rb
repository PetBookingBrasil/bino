require 'zendesk_api'

class Agents::ZendeskService

  def self.get(destiny, object_id = nil, source_type, destiny_type)
    last_date = BinoPackage.where(source: "zendesk", package_type: destiny_type, status: :sent)
                           .first
                           .try(:updated_at)
                           .try(:strftime, "%Y-%m-%d") ||
                1.years.ago.try(:strftime, "%Y-%m-%d")

    query = object_id == nil ? "created>#{last_date} type:#{source_type}" : "#{object_id}"
    tickets = client.search(query: query)
    tickets.each do |t|
      BinoPackage.create(source: "zendesk",
                         destiny: destiny,
                         external_source_id: t.id,
                         package_type: destiny_type,
                         status: :waiting)
    end
    response_format(destiny_type, tickets)
  end

  def self.response_format(format, objects)
    if format == "card"
      Converters::TicketToTask.convert(objects)
    end
  end

  def self.client
    ZendeskAPI::Client.new do |config|
      config.url = ENV['ZENDESK_URL']
      config.username = ENV['ZENDESK_USERNAME']
      config.token = ENV['ZENDESK_TOKEN']
      config.retry = true
      config.logger = Rails.logger
    end
  end
end

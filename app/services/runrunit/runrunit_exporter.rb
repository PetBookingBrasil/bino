module Runrunit
  class RunrunitExporter
    def initialize(ticket)
      @ticket = ticket
    end

    def export
      body = { task: Converters::TicketToTask.new(@ticket).convert }
      resource = 'api/v1.0/tasks'
      response = Runrunit::Resources.new().perform_request(body: body, resource: resource, method: :post)
      Agent.find_by(name: 'zendesk').update(last_sync: DateTime.now)
    end
  end
end

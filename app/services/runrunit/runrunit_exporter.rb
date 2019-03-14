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

    private

    def change_status(response)
      body = { task_status_id: 777343 }
      resource = "api/v1.0/tasks/#{JSON.parse(response)['id']}/change_status"
      Runrunit::Resources.new().perform_request(body: body, resource: resource, method: :post)
    end
  end
end

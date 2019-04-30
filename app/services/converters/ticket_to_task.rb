module Converters
  class TicketToTask

    def self.convert(tickets)
      tickets.map do |ticket|
        {
          id: ticket.id,
          body: {
            title: "[ZENDESK] - #{ticket.subject ||
              (ticket.description.slice(0, 50) + '...')}",
            on_going: false,
            scheduled_start_time: nil,
            desired_date_with_time: nil,
            description: ticket.description,
            project_id: ENV['RUNRUNIT_PROJECT_ID'],
            type_id: ENV['RUNRUNIT_TASK_TYPE_ID'],
            assignments: [
              {
                'assignee_id': 'sem-atribuicao'
              }
            ]
          }
        }
      end
    end
  end
end

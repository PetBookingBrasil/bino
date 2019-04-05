module Converters
  class TicketToTask

    def initialize(tickets)
      @tickets = tickets
    end

    def convert
      @tickets.map do |ticket|
        {
          title: "[ZENDESK] - #{ticket.subject}",
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
      end
    end
  end
end

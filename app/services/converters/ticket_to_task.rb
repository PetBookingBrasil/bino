module Converters
  class TicketToTask

    def initialize(ticket)
      @ticket = ticket
    end

    def convert
      {
        title: @ticket.subject,
        on_going: false,
        scheduled_start_time: nil,
        desired_date_with_time: nil,
        description: @ticket.comment.body
      }
    end
  end
end
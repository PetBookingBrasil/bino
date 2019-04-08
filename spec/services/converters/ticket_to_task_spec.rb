require 'rails_helper'

RSpec.describe Converters::TicketToTask do
  let(:ticket) { OpenStruct.new({ id: 1, subject: 'subject', description: 'description' }) }
  let(:converted) {
    [
      {
        id: 1,
        body: {
          title: "[ZENDESK] - subject",
          on_going: false,
          scheduled_start_time: nil,
          desired_date_with_time: nil,
          description: "description",
          project_id: "2046421",
          type_id: "1663341",
          assignments: [
            {
              'assignee_id': 'sem-atribuicao'
            }
          ]
        }
      }
    ]
  }

  describe ".convert" do
    it "converts ticket to card" do
      expect(described_class.convert([ticket])).to eq(converted)
    end
  end
end

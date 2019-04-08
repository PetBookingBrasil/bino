require 'rails_helper'

RSpec.describe Agents::RunrunitService do
  let!(:response_id) { "1" }
  before do
    Resources::Runrunit.any_instance.stub(:perform_request).and_return("{ \"id\": \"#{response_id}\" }")
  end
  let!(:package) {
    BinoPackage.create(source: "zendesk", destiny: "runrunit", external_source_id: 1)
  }
  let(:object) {
    [
      {
        id: 1,
        body: {
          title: "[ZENDESK] - 1",
          on_going: false,
          scheduled_start_time: nil,
          desired_date_with_time: nil,
          description: "1",
          project_id: 1,
          type_id: 1,
          assignments: [
            {
              'assignee_id': 'sem-atribuicao'
            }
          ]
        }
      }
    ]
  }

  describe ".post" do
    it "updates BinoPackage with response id" do
      described_class.post(object, "card")
      expect(BinoPackage.find_by(external_source_id: "1").external_destiny_id).to eq(response_id)
    end
  end
end

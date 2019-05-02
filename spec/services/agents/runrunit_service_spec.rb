require 'rails_helper'

RSpec.describe Agents::RunrunitService do

  let(:object_to_post) {{
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
  }}
  subject { described_class.new(formatted_objects: object_to_post,
    destiny_type: 'tasks') }

  describe '#post_item' do
    it "posts an item to runrunit" do
      expected_response = { id: '2' }
      params = {
        body: {task: object_to_post[:body]},
        resource: 'api/v1.0/tasks',
        method: :post
      }
      Resources::Runrunit.any_instance.stub(:perform_request).with(params).and_return(expected_response)
      expect(subject.post_item(object_to_post)).to eq(expected_response)
    end
  end
end

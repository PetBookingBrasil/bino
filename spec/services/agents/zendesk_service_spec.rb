require 'rails_helper'

RSpec.describe Agents::ZendeskService do

  subject { described_class.new(
    destiny: 'Runrunit',
    source_type: 'ticket',
    destiny_type: 'tasks') }

  describe '#get' do
    it 'returns a formatted response' do
      expected_response = 'formatted_response'
      subject.stub(:query) { 'created > 2018-10-10' }
      stubbed_client = double('A Zendesk API Client')
      stubbed_client.stub(:search).with(query: 'created > 2018-10-10') { 'results' }
      subject.stub(:client) { stubbed_client }
      subject.stub(:format_response).with('tasks', 'results') { expected_response }
      expect(subject.get).to eq(expected_response)
    end
  end
end

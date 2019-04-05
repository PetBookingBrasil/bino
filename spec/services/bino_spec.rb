require 'rails_helper'

RSpec.describe Bino do
  subject { described_class.new("zendesk", "destiny", source_type, destiny_type, object_id = nil) }

  describe '#transport' do
    context 'when arguments are valid' do
      it 'calls source get method' do
        expect(subject.transport().to eq()
      end
    end

end

require 'rails_helper'

RSpec.describe Bino do
  subject { described_class.new("zendesk", "destiny", source_type, destiny_type, object_id = nil) }

  describe '#transport' do
    context 'when arguments are valid' do
      it 'calls transport method' do
        expect(subject).to receive(:transport)
      end
    end

    context 'when arguments are invalid' do
      subject { described_class.new("wrong", "wrong", source_type, destiny_type, object_id = nil) }

      it 'raises an exception' do
        expect(subject).to raise_exception
      end
    end
end

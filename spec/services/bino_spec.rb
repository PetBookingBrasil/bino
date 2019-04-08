require 'rails_helper'

RSpec.describe BinoService do
  context 'when arguments are valid' do
    subject { described_class.new("zendesk", "runrunit", "ticket", "card", nil) }

    it 'assigns source variable' do
      expect(subject.instance_variable_get(:@source)).not_to be_nil
    end
    it 'assigns destiny variable' do
      expect(subject.instance_variable_get(:@destiny)).not_to be_nil
    end
    it 'assigns source_type variable' do
      expect(subject.instance_variable_get(:@source_type)).not_to be_nil
    end
    it 'assigns destiny_type variable' do
      expect(subject.instance_variable_get(:@destiny_type)).not_to be_nil
    end
  end

  context 'when source or destiny is invalid' do
    subject { described_class.new("wrong", "wrong", "ticket", "card") }

    it 'raises an exception' do
      expect { subject.transport }.to raise_error(NameError)
    end
  end

  context 'when types are invalid' do
    subject { described_class.new("zendesk", "runrunit", "wrong", "wrong") }

    it 'raises an exception' do
      expect { subject.transport }.to raise_error("Rejected type")
    end
  end
end

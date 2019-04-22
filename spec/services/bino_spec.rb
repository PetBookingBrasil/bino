require 'rails_helper'

RSpec.describe BinoService do
  describe 'arguments' do
    context 'when valid' do
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
  end

  describe '#transport' do
    describe 'validations' do
      context 'when source or destiny are invalid' do
        subject { described_class.new("wrong", "wrong", "ticket", "cards") }

        it 'raises an exception' do
          expect { subject.transport }.to raise_error("Invalid Agent")
        end
      end

      context 'when types are invalid' do
        subject { described_class.new("zendesk", "runrunit", "wrong", "wrong") }

        it 'raises an exception' do
          expect { subject.transport }.to raise_error("Rejected type")
        end
      end

      context 'when params are valid' do
        subject { described_class.new("zendesk", "runrunit", "ticket", "cards") }

        it 'gets the list of objects from the source' do
          subject.transport
          expect(Agents::Zendesk).to receive(:new).with("zendesk", "runrunit", "ticket", "cards")
        end

        it 'transports the objects to the destinty' do

        end
      end
    end
  end
end

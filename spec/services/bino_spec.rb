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
      context 'when the type of source or destiny are invalid' do
        subject { described_class.new('wrong', 'wrong', 'ticket', 'tasks') }

        it 'raises an exception' do
          expect { subject.transport }.to raise_error('Invalid Agent for destiny or source')
        end
      end

      context 'when types are invalid' do
        subject { described_class.new('Zendesk', 'Runrunit', 'wrong', 'wrong') }

        it 'raises an exception' do
          expect { subject.transport }.to raise_error('Invalid type for source or destiny')
        end
      end

      context 'when params are valid' do
        subject { described_class.new('Zendesk', 'Runrunit', 'ticket', 'tasks') }

        it 'gets the list of objects from the source' do
          zendesk = double('Zendesk Class')
          zendesk.stub(:get) { [{id: 10}] }
          expect(Agents::ZendeskService).to receive(:new).with(
            destiny: 'Runrunit', object_id: nil, source_type: 'ticket', destiny_type: 'tasks').and_return(zendesk)
          subject.transport
        end

        context 'when there is no data on source to be transported' do
          it 'raises a "No data to transport"' do
            BinoService.any_instance.stub(:get_objects_from_source).and_return(nil)
            expect{ subject.transport }.to raise_error('No data to transport')
          end
        end

        it 'creates packages for each object of the source' do
          start_count = BinoPackage.count
          BinoService.any_instance.stub(:get_objects_from_source).and_return([{id: 10}, {id: 11}, {id: 12}])
          subject.transport
          expect(BinoPackage.count).to eq(start_count + 3)
        end

        it 'posts the object to the destiny' do
          runrunit = double('Runrunit Class')
          runrunit.stub(:post) { true }
          objects = [{id: 10}, {id: 11}, {id: 12}]
          BinoService.any_instance.stub(:get_objects_from_source).and_return(objects)
          expect(Agents::RunrunitService).to receive(:new).with(formatted_objects: objects, destiny_type: 'tasks').and_return(runrunit)
          subject.transport
        end
      end
    end
  end
end

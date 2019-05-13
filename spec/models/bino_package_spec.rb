require 'rails_helper'

RSpec.describe BinoPackage, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:bino_package) }
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:destiny) }
    it { should validate_uniqueness_of(:external_source_id)
      .scoped_to(:source, :destiny, :package_type).case_insensitive }
  end

  describe 'enums' do
    it { should define_enum_for(:status)
        .with_values([:sent, :waiting, :failed])}
    it { should define_enum_for(:package_type)
        .with_values([:ticket, :tasks])}
  end
end

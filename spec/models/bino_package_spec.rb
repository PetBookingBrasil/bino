require 'rails_helper'

RSpec.describe BinoPackage, type: :model do
  it { should validate_presence_of(:source) }
  it { should validate_presence_of(:destiny) }

  describe 'enums' do
    it { should define_enum_for(:status)
        .with_values([:sent, :waiting, :failed])}
    it { should define_enum_for(:package_type)
        .with_values([:ticket, :tasks])}
  end
end

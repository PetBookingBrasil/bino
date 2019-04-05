require 'rails_helper'

RSpec.describe BinoPackage, type: :model do

  describe 'Validations' do
    it { is_expected.to validate_presence_of :source }
    it { is_expected.to validate_presence_of :destiny }
  end

end

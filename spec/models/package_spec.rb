require 'rails_helper'

RSpec.describe BinoPackage, type: :model do

  it { should validate_presence_of(:source) }
  it { should validate_presence_of(:destiny) }

end

require 'rails_helper'

RSpec.describe Agents::ZendeskService do

  describe ".get" do
    it "calls response_format" do
      expect(described_class).to receive(:response_format)
      described_class.get("runrunit", "ticket", "card")
    end
  end
end

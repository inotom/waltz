require 'spec_helper'

describe Orderer do
  before do
    @orderer = Orderer.new(name: "New Orderer")
  end

  subject { @orderer }

  it { should respond_to(:name) }
  it { should respond_to(:color_index) }

  it { should be_valid }

  describe "when name is not present" do
    before { @orderer.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @orderer.name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "when color_index is not present" do
    before { @orderer.color_index = nil }
    it { should_not be_valid }
  end
end

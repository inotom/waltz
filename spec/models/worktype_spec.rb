require 'spec_helper'

describe Worktype do
  before do
    @worktype = Worktype.new(name: 'New Worktype')
  end

  subject { @worktype }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "when name is not present" do
    before { @worktype.name = " " }
    it { should_not be_valid }
  end

  describe "when name that is too long" do
    before { @worktype.name = "a" * 101 }
    it { should_not be_valid }
  end
end

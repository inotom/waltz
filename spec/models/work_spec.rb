require 'spec_helper'

describe Work do

  let(:year) { FactoryGirl.create(:year) }
  before { @work = year.works.build(year: year, title: 'New Work') }

  subject { @work }

  it { should respond_to(:start_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:claim_date) }
  it { should respond_to(:receipt_date) }
  it { should respond_to(:memo) }
  it { should respond_to(:orderer_id) }
  it { should respond_to(:worktype_id) }
  it { should respond_to(:quote_amount) }
  it { should respond_to(:receipt_amount) }
  it { should respond_to(:title) }
  it { should respond_to(:year_id) }
  it { should respond_to(:year) }
  its(:year) { should eq year }

  it { should be_valid }

  describe "when year_id is not present" do
    before { @work.year_id = nil }
    it { should_not be_valid }
  end

  describe "when start_date is not present" do
    before { @work.start_date = nil }
    it { should_not be_valid }
  end

  describe "when title is not present" do
    before { @work.title = " " }
    it { should_not be_valid }
  end

  describe "when title is too long" do
    before { @work.title = "a" * 256 }
    it { should_not be_valid }
  end
end

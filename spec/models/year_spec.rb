require 'spec_helper'

describe Year do

  before do
    @year = Year.new(year: 2010)
  end

  subject { @year }

  it { should respond_to(:year) }
  it { should respond_to(:works) }

  describe "when year is not present" do
    before { @year.year = nil }

    it { should_not be_valid }
  end

  describe "when year is already exist" do
    before do
      same_year = @year.dup
      same_year.save
    end

    it { should_not be_valid }
  end

  describe "year is" do

    describe "under 1999" do
      before { @year.year = 1999 }
      it { should_not be_valid }
    end

    describe "over 2000" do
      before { @year.year = 2000 }
      it { should be_valid }
    end

    describe "over 2101" do
      before { @year.year = 2101 }
      it { should_not be_valid }
    end

    describe "under 2100" do
      before { @year.year = 2100 }
      it { should be_valid }
    end
  end

  describe "create year" do
    let!(:older_year) do
      FactoryGirl.create(:year,
                         year: 2013)
    end
    let!(:newer_year) do
      FactoryGirl.create(:year,
                         year: 2014)
    end

    it "should have the right years in the right order" do
      expect(Year.all.to_a).to eq [newer_year, older_year]
    end
  end

  describe "work associations" do
    before { @year.save }
    let!(:older_work) do
      FactoryGirl.create(:work, year: @year, start_date: 1.day.ago)
    end
    let!(:newer_work) do
      FactoryGirl.create(:work, year: @year, start_date: 1.hour.ago)
    end

    it "should have the right works in the right order" do
      expect(@year.works.to_a).to eq [newer_work, older_work]
    end
  end

  describe "calc amount" do
    before { @year.save }
    let!(:w1) { FactoryGirl.create(:work,
                                   year: @year,
                                   quote_amount: 100,
                                   receipt_amount: 150) }
    let!(:w2) { FactoryGirl.create(:work,
                                   year: @year,
                                   quote_amount: 180,
                                   receipt_amount: 230) }
    let!(:w3) { FactoryGirl.create(:work,
                                   year: @year) }

    it "should have the correct total quote amount" do
      expect(@year.total_quote).to eq(w1.quote_amount +
                                      w2.quote_amount)
    end

    it "should have the correct total receipt amount" do
      expect(@year.total_receipt).to eq(w1.receipt_amount +
                                        w2.receipt_amount)
    end
  end
end

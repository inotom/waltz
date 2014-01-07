require 'spec_helper'

describe "Work Pages" do

  before { create_logged_in_user }

  subject { page }

  describe "new page" do
    before { visit new_work_path }

    it { should have_title('Create Work') }
    it { should have_button('Create') }

    describe "work creation" do

      describe "with invaid information" do

        it "should not create a work" do
          expect { click_button "Create" }.not_to change(Work, :count)
        end

        describe "error messages" do
          before { click_button "Create" }
          it { should have_content("error") }
        end
      end

      describe "with valid information" do

        before { fill_in "work_title", with: "New Work" }
        it "should create a work" do
          expect { click_button "Create" }.to change(Work, :count).by(1)
        end

        describe "full input" do
          let!(:orderer) { FactoryGirl.create(:orderer, name: 'New Orderer') }
          let!(:worktype) { FactoryGirl.create(:worktype, name: 'New Worktype') }

          before do
            visit new_work_path
            fill_in "work_title", with: "New Work"
            fill_in "work_quote_amount", with: 15000
            select "New Orderer", from: 'work[orderer_id]'
            select "New Worktype", from: 'work[worktype_id]'
            fill_in "work_memo", with: "This is a new work."
            click_button "Create"
          end

          it { should have_content("New Work") }
          it { should have_content("15,000") }
          it { should have_content("New Orderer") }
          it { should have_content("New Worktype") }
          it { should have_content("This is a new work.") }
          it { should have_button('End work') }
          it { should have_button('Claimed') }
          it { should have_button('Receipted') }

          describe "work finished" do
            before { click_button 'End work' }
            it { should_not have_button('End work') }
          end

          describe "work claimed" do
            before { click_button 'Claimed' }
            it { should_not have_button('Claimed') }
          end

          describe "work receipted" do
            before { click_button 'Receipted' }
            it { should_not have_button('Receipted') }
          end
        end
      end
    end
  end

  describe "edit page" do
    let!(:year) { FactoryGirl.create(:year, year: 2011) }
    let!(:year_old) { FactoryGirl.create(:year, year: 2010) }
    let!(:work) { FactoryGirl.create(:work,
                                     year: year,
                                     title: 'Old Work',
                                     start_date: 10.days.ago,
                                     end_date: 8.days.ago,
                                     claim_date: 6.days.ago,
                                     receipt_date: 4.days.ago,
                                     quote_amount: 5000,
                                     receipt_amount: 5000,
                                     memo: 'This is a old work.') }
    before { visit edit_work_path(work) }

    it { should have_selector('input[type="text"][value="Old Work"]') }
    it { should have_selector('select[id="work_start_date_1i"]') }
    it { should have_selector('select[id="work_end_date_1i"]') }
    it { should have_selector('select[id="work_claim_date_1i"]') }
    it { should have_selector('select[id="work_receipt_date_1i"]') }
    it { should have_selector('input[type="text"][id="work_quote_amount"][value="5000"]') }
    it { should have_selector('input[type="text"][id="work_receipt_amount"][value="5000"]') }
    it { should have_content('This is a old work.') }
    it { should have_selector('select[id="work_year_id"]') }
    it { should have_button('Update') }

    describe "change title" do
      before do
        fill_in "work_title", with: 'New Work'
        click_button 'Update'
      end

      it { should_not have_content('Old Work') }
      it { should have_content('New Work') }
    end

    describe "change year_id" do
      before do
        fill_in "work_title", with: 'Change Year Work'
        select year_old.year, from: 'work[year_id]'
        click_button 'Update'
      end

      it { should have_content('Change Year Work') }
      it { should have_selector('.year-name', text: "#{year_old.year}年") }
      it { should_not have_selector('.year-name', text: "#{year.year}年") }
    end
  end

  describe "sorting" do
    let!(:year) { FactoryGirl.create(:year) }
    let!(:older_work) { FactoryGirl.create(:work,
                                           year: year,
                                           title: 'Older Work',
                                           start_date: 10.days.ago) }
    let!(:newer_work) { FactoryGirl.create(:work,
                                           year: year,
                                           title: 'Newer Work',
                                           start_date: 5.days.ago) }

    before { visit year_path(year) }

    it { should have_selector('.table tbody tr.row-1 td', text: newer_work.title) }

    describe "sort" do
      before { click_link '開始日', match: :first }
      it { should have_selector('.table tbody tr.row-1 td', text: older_work.title) }
    end
  end

  describe "work destruction" do
    let!(:year) { FactoryGirl.create(:year) }
    let!(:work) { FactoryGirl.create(:work,
                                     year: year) }

    before { visit edit_work_path(work) }

    it "should delete a work" do
      expect { click_link "Delete" }.to change(Work, :count).by(-1)
    end
  end
end

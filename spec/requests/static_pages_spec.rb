require 'spec_helper'

describe "StaticPages" do
  let!(:year) { FactoryGirl.create(:year) }

  subject { page }

  describe "Home page" do

    describe "with invalid user" do
      before { visit root_path }

      it { should_not have_link('Create Work', new_work_path) }
      it { should have_content('Sign in') }
      it { should have_link('Sign in', new_user_session_path) }
      it { should_not have_link('Sign out', destroy_user_session_path) }
    end

    describe "with valid signed_in user" do
      before do
        create_logged_in_user
        visit root_path
      end

      it { should have_content('Waltz') }
      it { should have_title(full_title()) }
      it { should_not have_title('- Waltz') }
      it { should have_link('Config', configs_path) }
      it { should have_link(year.year) }
      it { should have_link('Create Work', new_work_path) }
      it { should_not have_content('Sign in') }
      it { should_not have_link('Sign in', new_user_session_path) }
      it { should have_link('Sign out', destroy_user_session_path) }
    end
  end

  describe "Configs page" do
    let!(:orderer) { FactoryGirl.create(:orderer, name: 'New Orderer') }
    let!(:worktype) { FactoryGirl.create(:worktype, name: 'New Worktype') }

    before do
      create_logged_in_user
      visit configs_path
    end

    it { should have_content('Configs') }
    it { should have_title(full_title('Configs')) }
    it { should have_content(year.year) }
    it { should have_selector('input[type="submit"].create-year-btn') }

    it { should have_content(orderer.name) }
    it { should have_link('Create Orderer', new_orderer_path) }

    it { should have_content(worktype.name) }
    it { should have_link('Create Worktype', new_worktype_path) }

    describe "Create year" do
      it "should create a year" do
        expect { find('.config-year').click_button 'Create Year' }.to change(Year, :count).by(1)
      end

      describe "already created year" do
        before { click_button 'Create Year' }

        it "should not create same year" do
          expect { find('.config-year').click_button 'Create Year' }.to change(Year, :count).by(0)
        end

        describe "create year second times" do
          before { click_button 'Create Year' }
          it { should have_content('error') }
        end
      end
    end
  end
end

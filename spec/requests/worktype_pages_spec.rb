require 'spec_helper'

describe "Worktype Pages" do

  before { create_logged_in_user }

  subject { page }

  describe "new page" do
    before { visit new_worktype_path }

    it { should have_title('Create Worktype') }
    it { should have_button('Create') }

    describe "worktype creation" do

      describe "with invalid information" do

        it "should not create a worktype" do
          expect { click_button 'Create' }.not_to change(Worktype, :count)
        end

        describe "error messages" do
          before { click_button 'Create' }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do
        before { fill_in 'worktype_name', with: 'New Worktype' }
        it "should create a worktype" do
          expect { click_button 'Create' }.to change(Worktype, :count).by(1)
        end
      end
    end
  end

  describe "edit page" do
    let(:worktype) { FactoryGirl.create(:worktype, name: 'Old Worktype') }
    before { visit edit_worktype_path(worktype) }

    it { should have_title("Edit #{worktype.name}") }
    it { should have_selector("input[type=\"text\"][value=\"#{worktype.name}\"]") }

    describe "worktype update" do

      describe "with invalid information" do
        before { fill_in 'worktype_name', with: ' ' }

        describe "error messages" do
          before { click_button 'Update' }
          it { should have_content('error') }
        end
      end

      describe "with valid informaiton" do
        before do
          fill_in 'worktype_name', with: 'New Worktype'
          click_button 'Update'
        end

        it { should have_content('Worktype updated!') }
      end
    end
  end

  describe "worktype destruction" do
    let!(:worktype) { FactoryGirl.create(:worktype, name: 'Old Worktype') }

    describe "at edit page" do
      before { visit edit_worktype_path(worktype) }

      it "should delete a worktype" do
        expect { click_link 'Delete' }.to change(Worktype, :count).by(-1)
      end
    end
  end
end

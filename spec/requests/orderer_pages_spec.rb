require 'spec_helper'

describe "Orderer Pages" do

  before { create_logged_in_user }

  subject { page }

  describe "new page" do
    before { visit new_orderer_path }

    it { should have_title('Create Orderer') }
    it { should have_button('Create') }

    describe "orderer creation" do

      describe "with invalid information" do

        it "should not create a orderer" do
          expect { click_button 'Create' }.not_to change(Orderer, :count)
        end

        describe "error messages" do
          before { click_button 'Create' }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do

        before { fill_in 'orderer_name', with: 'New Orderer' }
        it "should create a orderer" do
          expect { click_button 'Create' }.to change(Orderer, :count).by(1)
        end
      end
    end
  end

  describe "edit page" do
    let(:orderer) { FactoryGirl.create(:orderer, name: 'Old Orderer') }
    before { visit edit_orderer_path(orderer) }

    it { should have_title("Edit #{orderer.name}") }
    it { should have_selector("input[type=\"text\"][value=\"#{orderer.name}\"]") }

    describe "orderer update" do

      describe "with invalid information" do
        before { fill_in 'orderer_name', with: ' ' }

        describe "error messages" do
          before { click_button 'Update' }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do

        before do
          fill_in 'orderer_name', with: 'New Orderer'
          click_button 'Update'
        end

        it { should have_content('Orderer updated!') }
      end
    end
  end

  describe "orderer destoruction" do
    let!(:orderer) { FactoryGirl.create(:orderer, name: 'Old Orderer') }

    describe "at edit page" do
      before { visit edit_orderer_path(orderer) }

      it "should delete a orderer" do
        expect { click_link "Delete" }.to change(Orderer, :count).by(-1)
      end
    end
  end
end

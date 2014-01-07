module ControllerMacros
  def login_user
    before(:each) do
      @request.env["device.mapping"] = Device.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
  end
end

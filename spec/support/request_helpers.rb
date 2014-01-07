include Warden::Test::Helpers

module RequestHelpers
  def create_logged_in_user
    user = FactoryGirl.build :user
    user.save!
    login(user)
    user
  end

  def login(user)
    login_as user, scope: :user, run_callbacks: false
  end
end

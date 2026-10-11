require "application_system_test_case"

class UserRegistrationTest < ApplicationSystemTestCase
  test "visiting the sign-up page" do
    visit new_user_registration_path

    assert_text "Sign up"
  end
end

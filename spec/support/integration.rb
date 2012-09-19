def fill_in_email(email)
  find("input[name*='email']").set(email)
end

def sign_in_as(user)
  visit sign_in_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_button 'Sign in'
end

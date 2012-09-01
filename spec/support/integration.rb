def fill_in_email(email)
  all('form input.email').last.set(email)
end

def sign_in_as(user)
  visit sign_in_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_button 'Sign in'
end

class SignInExperience < Experience
  def initialize(you)
    @you = you
  end

  def sign_in
    visit sign_in_url
    fill_in 'Email', with: @you.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  def welcomed?
    page.has_content?('Welcome to Thrively!')
  end

  def has_activities?
    page.has_content?('Stream')
  end
end

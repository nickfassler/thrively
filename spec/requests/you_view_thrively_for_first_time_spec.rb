require 'spec_helper'

feature 'you view the marketing page' do
  scenario 'and learn about Thrively for the first time' do
    visit sign_up_path
    page.status_code.should == 200
  end
end

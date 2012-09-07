require 'spec_helper'

feature 'Static Pages' do
  %w(marketing).each do |name|
    scenario "A visitor can access the #{name} page" do
      visit "/pages/#{name}"
      page.status_code.should == 200
    end
  end
end

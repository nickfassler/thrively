require 'spec_helper'

feature 'admin views metrics' do
  scenario 'with two weeks of data' do
    you = create(:admin)
    ux = AdminExperience.new(you)
    ux.view_admin

    ux.should have_metrics
  end
end

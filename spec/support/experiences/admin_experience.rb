class AdminExperience < Experience
  def initialize(you)
    @you = you
  end

  def view_admin
    visit admin_path(as: @you)
  end

  def has_metrics?
    page.has_css?('.metrics')
  end
end

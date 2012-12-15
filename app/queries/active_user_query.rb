class ActiveUserQuery
  def initialize(scope = User.active)
    @scope = scope
  end

  def count_by_week(*weeks)
    weeks.map { |week| find_by_week(week) }.flatten.uniq
  end

  private

  def find_by_week(week)
    @scope.reject do |user|
      user.full_week?(week)
    end
  end
end

class ActivityExperience < Experience
  def initialize(you, options = {})
    @you = you
    @friend = create(:user)
    HistoryEvent.per_page = options[:per_page] || 10
  end

  def you_request_feedback_from_friend
    @request_from_you = create(:request, user: @you, emails: [@friend.email])
  end

  def friend_requests_feedback_from_you
    @request_to_you = create(:request, user: @friend, emails: [@you.email])
  end

  def friend_gives_you_feedback
    @received_feedback = create(:feedback, receiver: @you, giver: @friend)
  end

  def you_give_feedback_to_friend
    @given_feedback = create(
      :feedback, receiver: @friend, giver: @you, request: @request_to_you
    )
  end

  def you_view_activity_stream
    visit root_path(as: @you)
  end

  def you_view_page(number)
    click_link(number.to_s)
  end

  def has_no_pending_requests?
    page.has_no_css?('.request.received')
  end

  def has_pending_request_from_you?
    within '.request.sent' do
      page.has_content?("You requested feedback from #{@friend.name}") &&
        page.has_content?(@request_from_you.topic) &&
        page.has_content?(@request_from_you.message)
    end
  end

  def has_pending_request_to_you?
    within '.request.received' do
      page.has_content?("#{@friend.name} requested feedback from you") &&
        page.has_content?(@request_to_you.topic) &&
        page.has_content?(@request_to_you.message)
    end
  end

  def has_feedback_from_you_to_friend?
    within '.feedback.sent' do
      page.has_content?("You gave feedback to #{@friend.name}") &&
        page.has_content?(@given_feedback.topic) &&
        page.has_content?(@given_feedback.plus) &&
        page.has_content?(@given_feedback.delta)
    end
  end

  def has_feedback_from_friend_to_you?
    within '.feedback.received' do
      page.has_content?("#{@friend.name} gave feedback to you") &&
        page.has_content?(@received_feedback.topic) &&
        page.has_content?(@received_feedback.plus) &&
        page.has_content?(@received_feedback.delta)
    end
  end
end

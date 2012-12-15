namespace :thrively do
  namespace :active_user do
    desc 'Aggegrate feedbacks into active users'
    task aggregate: :environment do
      Feedback.update_all 'aggregated_at = NULL'
      ActiveUser.reset

      Feedback.aggregatable(Time.now).find_each do |order|
        AggregateFeedbackJob.enqueue order
      end
    end
  end
end

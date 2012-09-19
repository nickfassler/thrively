class RequestObserver < ActiveRecord::Observer
  observe Request

  def after_create(request)
    RequestCreatedJob.enqueue(request)
  end
end

class MyWorker
  include Sidekiq::Worker

  def perform
    p "This is the current time: #{DateTime.now}"
  end
end

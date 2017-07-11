class UserNotificationJob < ApplicationJob
  queue_as :default

  def perform(notifications)
    # Do something later
  end
end

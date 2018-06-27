class NotificationBroadcastJob < ApplicationJob
  queue_as :default
 
  def perform notification 
    ActionCable.server.broadcast "notification_channel#{notification.user_id}", notification: render_notification(notification)
  end
 
  private
 
  def render_notification notification
    ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: notification })
  end
end

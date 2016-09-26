class ActivitiesController < ApplicationController
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  def index
    event_ids = current_user.events_as_participant.map do |event|
      event.id
    end
    @activities = PublicActivity::Activity.order("created_at desc").where(trackable_id: event_ids)
    @activities.where(read_at: nil).each do |activity|
      activity.read_at = DateTime.now
      activity.save
    end
  end

  def mark_as_read
    activity = PublicActivity::Activity.find(params[:id])
    activity.read_at = DateTime.now
    activity.save
    respond_to do |format|
      format.js
      format.html {redirect_to root_path}
    end
  end
end

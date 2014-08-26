class Duties::ActivityJob
  include Sidekiq::Worker

  sidekiq_options :retry => true

  def perform(activity_id)
    activity = Duties::ActivityRecord.find_by_id activity_id
    return if activity.nil?
    klass    = activity_class activity.name.classify

    klass.call activity
  end

  private

  def activity_class(name)
    Duties.activity_namespace.const_get name
  end
end

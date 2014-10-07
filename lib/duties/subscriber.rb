class Duties::Subscriber < ActiveSupport::LogSubscriber
  def activity(event)
    identifier = color 'Duties (%.1fms)' % event.duration, GREEN, true
    debug "  #{identifier}  Running #{activity_message event}"
  end

  def starting_activity(event)
    identifier = color 'Duties', GREEN, true
    debug "  #{identifier}  Starting #{activity_message event}"
  end

  def finished_activity(event)
    identifier = color 'Duties', GREEN, true
    activity   = event.payload[:activity]
    debug ["  #{identifier}  ",
      "Finished #{activity_message event} (#{activity.status})"].join('')
  end

  private

  def activity_message(event)
    activity = event.payload[:activity]
    [activity.duty_record, activity].collect { |object|
      "#{object.name} (#{object.id})"
    }.join(' / ')
  end
end

Duties::Subscriber.attach_to :duties

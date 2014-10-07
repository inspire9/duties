class Duties::Activity
  def self.call(record)
    instrument 'activity', activity: record do
      instrument 'starting_activity', activity: record

      new(record).call
    end

    record.status = record.failures.any? ? 'failure' : 'success'
    record.save!

    instrument 'finished_activity', activity: record

    Duties::Next.call record.duty_record, record.position
  end

  def self.instrument(event, options, &block)
    ActiveSupport::Notifications.instrument "#{event}.duties", options, &block
  end

  def initialize(activity)
    @activity = activity
  end

  private

  attr_reader :activity

  delegate :duty_record, to: :activity
  delegate :data,        to: :duty_record
end

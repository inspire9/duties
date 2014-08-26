class Duties::Activity
  def self.call(record)
    activity = new(record)
    begin
      activity.call
      record.update_attributes status: 'success'

      Duties::Next.call record.duty_record, record.position
    rescue => error
      record.update_attributes status: 'failure'
    end
  end

  def initialize(activity)
    @activity = activity
  end

  private

  attr_reader :activity

  delegate :duty, to: :activity
  delegate :data, to: :duty
end

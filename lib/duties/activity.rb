class Duties::Activity
  def self.call(record)
    new(record).call

    record.status = record.failures.any? ? 'failure' : 'success'
    record.save!

    Duties::Next.call record.duty_record, record.position
  end

  def initialize(activity)
    @activity = activity
  end

  private

  attr_reader :activity

  delegate :duty_record, to: :activity
  delegate :data,        to: :duty_record
end

class Duties::Duty
  def self.call(record)
    new(record).call
  end

  def self.enqueue(name, data = {})
    duty = Duties::DutyRecord.create! name: name, data: data

    Duties::DutyJob.perform_async duty.id

    duty.id
  end

  def initialize(record)
    @record = record
  end

  def enqueue_activities
    # Hook for subclasses to implement
  end

  def call
    enqueue_activities
    start_activities
  end

  private

  attr_reader :record

  def enqueue_activity(name, options)
    record.activity_records.create! name: name, position: options[:at]
  end

  def start_activities
    record.activity_records.by_position(1).each do |activity|
      Duties::ActivityJob.perform_async activity.id
    end
  end
end

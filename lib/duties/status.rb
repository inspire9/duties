class Duties::Status
  def initialize(id)
    @record = Duties::DutyRecord.find id
  end

  def status
    return 'failure' if statuses.include?('failure')
    return 'pending' if statuses.include?('pending')
    return 'pending' if record.activity_records.length.zero?

    'success'
  end

  def failure?
    status == 'failure'
  end

  def failures
    record.activity_records.pluck(:failures).flatten
  end

  def pending?
    status == 'pending'
  end

  def success?
    status == 'success'
  end

  private

  attr_reader :record

  def statuses
    @statuses ||= record.activity_records.pluck :status
  end
end

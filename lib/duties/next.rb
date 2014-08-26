class Duties::Next
  def self.call(record, position)
    new(record, position).call
  end

  def initialize(record, position)
    @record, @position = record, position
  end

  def call
    # We're done here. Stop.
    return if any_failures?
    return unless finished_current? && more_to_come?

    activity_records.by_position(position + 1).each do |activity|
      Duties::ActivityJob.perform_async activity.id
    end
  end

  private

  attr_reader :record, :position

  delegate :activity_records, to: :record

  def any_failures?
    activity_records.by_position(position).failures.any?
  end

  def finished_current?
    activity_records.by_position(position).all? &:success?
  end

  def more_to_come?
    activity_records.by_position(position + 1).any?
  end
end

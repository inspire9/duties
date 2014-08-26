class Duties::ActivityRecord < ActiveRecord::Base
  self.table_name = 'duties_activity_records'

  belongs_to :duty_record, class_name: 'Duties::DutyRecord'

  validates :name,        presence: true
  validates :duty_record, presence: true
  validates :position,    presence: true

  scope :by_position, lambda { |position| where(position: position) }
  scope :failures,    lambda { where status: 'failure' }

  def success?
    status == 'success'
  end
end

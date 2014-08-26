class Duties::DutyRecord < ActiveRecord::Base
  self.table_name = 'duties_duty_records'

  has_many :activity_records, class_name: 'Duties::ActivityRecord'
  serialize :data, JSON

  validates :name, presence: true
end

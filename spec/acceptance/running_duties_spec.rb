require 'spec_helper'

module Running
  module Duties
    class ExampleOne < ::Duties::Duty
      def enqueue_activities
        enqueue_activity 'success_one', at: 1
        enqueue_activity 'success_two', at: 2
      end
    end
  end

  module Activities
    class SuccessOne < ::Duties::Activity
      def call
        #
      end
    end

    class SuccessTwo < ::Duties::Activity
      def call
        #
      end
    end
  end
end

describe 'Running duties' do
  before :each do
    Duties.duty_namespace     = Running::Duties
    Duties.activity_namespace = Running::Activities
  end

  it 'processes each activity for the duty' do
    id = Duties::Duty.enqueue 'example_one'

    duty = Duties::DutyRecord.find(id)
    expect(duty.activity_records.length).to eq(2)
    expect(duty.activity_records.pluck(:status)).to eq(['success', 'success'])
  end
end

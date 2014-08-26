require 'spec_helper'

module Running
  module Duties
    class ExampleOne < ::Duties::Duty
      def enqueue_activities
        enqueue_activity 'success_one', at: 1
        enqueue_activity 'success_two', at: 2
      end
    end

    class ExampleTwo < ::Duties::Duty
      def enqueue_activities
        enqueue_activity 'fail_one',    at: 1
        enqueue_activity 'success_one', at: 2
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

    class FailOne < ::Duties::Activity
      def call
        activity.failures << 'nope'
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

  it 'stores errors' do
    id     = Duties::Duty.enqueue 'example_two'
    status = Duties::Status.new id

    expect(status).to be_failure
    expect(status.failures).to eq(['nope'])
  end
end

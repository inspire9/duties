class Duties::DutyJob
  include Sidekiq::Worker

  sidekiq_options retry: true

  def perform(duty_id)
    duty  = Duties::DutyRecord.find duty_id
    klass = duty_class duty.name.classify

    klass.call duty
  end

  private

  def duty_class(name)
    Duties.duty_namespace.const_get name
  end
end

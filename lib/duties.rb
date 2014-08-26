require 'sidekiq'

module Duties
  mattr_accessor :duty_namespace, :activity_namespace
end

require 'duties/activity'
require 'duties/activity_job'
require 'duties/duty'
require 'duties/duty_job'
require 'duties/engine'
require 'duties/next'
require 'duties/status'

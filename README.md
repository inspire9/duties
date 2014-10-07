# Duties

A Rails engine that runs activities related to a duty in a specific order, via Sidekiq.

Duties are composed of one or more activities. These activities have positions, and they can share positions, which allows for parallel processing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'duties', '0.0.3'
```

## Usage

```ruby
# config/initializers/duties.rb
Duties.duty_namespace     = MyDuties
Duties.activity_namespace = MyActivities

# app/lib/my_duties/compile.rb
class MyDuties::Compile < Duties::Duty
  def enqueue_activities
    enqueue_activity 'clean',     at: 1
    enqueue_activity 'configure', at: 2
    enqueue_activity 'make',      at: 3
  end
end

# app/lib/my_activities/clean.rb
class MyActivities::Clean < Duties::Activity
  def clean
    # can use data to access duty information provided when queued.
  end
end

# Wherever you want to queue up the compile duty
Duties::Duty.enqueue 'compile', 'foo' => 'bar'
```

## Contributing

1. Fork it ( https://github.com/inspire9/duties/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credits

Copyright (c) 2014, Duties is developed and maintained by Pat Allan and [Inspire9](http://inspire9.com), and is released under the open MIT Licence.

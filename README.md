= DateRangeScopes

Automatically add scopes for day, week, month and year ranges to Active Record models. See [date_range_scopes.rb](https://github.com/nragaz/date_range_scopes/blob/master/lib/date_range_scopes.rb) for a full example.

== Usage

    class User < ActiveRecord::Base
      include DateRangeScopes
    end
    
    # => User.created_on
    # => User.created_in_week(5.weeks.ago)
    # => User.created_in_year
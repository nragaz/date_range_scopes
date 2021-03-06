module DateRangeScopes
  extend ActiveSupport::Concern

  # Include this module in an Active Record class to add the following scopes
  # for every column ending in _at or _on (e.g. updated_at):
  #
  #   > #{updated}_on
  #   > #{updated}_in_week
  #   > #{updated}_in_month
  #   > #{updated}_in_year
  #
  # These scopes accept a date or time to define the period. e.g. if you pass a
  # date on a Wednesday, `#{updated}_in_week` will return records with dates
  # between the beginning and end of that week.
  #
  # The default is always today / now.
  #
  # Convenience aliases:
  #   > #{updated}_today -> same as #{updated}_on(Date.today)
  #   > today(date) -> same as created_on(date)
  included do
    begin
      date_columns = column_names.select { |col| col =~ /((_at)|(_on))\z/ }

      date_columns.each do |col|
        key = col.slice(0..-4)
        full_name = "#{table_name}.#{col}"
        date_column = col =~ /_on\z/

        scope "#{key}_on", lambda { |time=nil|
          time ||= Time.zone.now
          time = time.respond_to?(:to_time_in_current_zone) ?
            time.to_time_in_current_zone : time

          starts_at = time.beginning_of_day
          ends_at = time.end_of_day
          if date_column
            starts_at = starts_at.to_date
            ends_at = ends_at.to_date
          end

          where "#{full_name} >= ? AND #{full_name} <= ?", starts_at, ends_at
        }

        scope "#{key}_today", send("#{key}_on")

        %w( week month year ).each do |period|
          scope "#{key}_in_#{period}", lambda { |time=nil|
            time ||= Time.zone.now
            time = time.respond_to?(:to_time_in_current_zone) ?
              time.to_time_in_current_zone : time

            starts_at = time.send("beginning_of_#{period}")
            ends_at = time.send("end_of_#{period}")
            if date_column
              starts_at = starts_at.to_date
              ends_at = ends_at.to_date
            end

            where "#{full_name} >= ? AND #{full_name} <= ?", starts_at, ends_at
          }

          scope "#{key}_this_#{period}", send("#{key}_in_#{period}")
        end
      end

    rescue
      puts "Columns not available for date_range_scopes" unless abstract_class?
    end
  end

  module ClassMethods
    def today(date=nil)
      created_on(date)
    end
  end
end

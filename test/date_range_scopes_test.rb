require 'test_helper'

class DateRangeScopesTest < ActiveSupport::TestCase
  test "defines created_on scope" do
    assert User.respond_to?(:created_on)
    assert_kind_of ActiveRecord::Relation, User.created_on
  end
  
  test "defines updated_today scope" do
    assert User.respond_to?(:updated_today)
    assert_kind_of ActiveRecord::Relation, User.updated_today
  end
  
  test "defines created_in_week scope" do
    assert User.respond_to?(:created_in_week)
    assert_kind_of ActiveRecord::Relation, User.created_in_week
  end
  
  test "defines locked_this_week scope" do
    assert User.respond_to?(:locked_this_week)
    assert_kind_of ActiveRecord::Relation, User.locked_this_week
  end
  
  test "defines born_this_year scope" do
    assert User.respond_to?(:born_this_year)
    assert_kind_of ActiveRecord::Relation, User.born_this_year
  end
  
  test "defines today scope" do
    assert User.respond_to?(:today)
    assert_kind_of ActiveRecord::Relation, User.today
  end
  
  test "born_in_year accepts a date" do
    assert_kind_of ActiveRecord::Relation,
                   User.born_in_year(2.years.ago.to_date)
  end
  
  test "created_on accepts a time" do
    assert_kind_of ActiveRecord::Relation, User.created_on(1.week.ago)
  end
end

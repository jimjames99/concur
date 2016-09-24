require_relative '../test_helper'

class GroupTest < ActiveSupport::TestCase

  test 'threadsafe Arel.count' do

    group_count = Group.count

    group_counts = ThreadSafe::Array.new
    threads = []

    1000.times do |i|
      threads[i] = Thread.new(i) do
        group_counts[i] = Group.count
      end
    end

    threads.each { |thread| thread.join }

    1000.times { |i| assert_equal group_count, group_counts[i], "actual count: #{group_count}, unexpected value: #{group_counts[i]}" }

  end

end

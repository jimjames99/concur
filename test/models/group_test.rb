require_relative '../test_helper'

class GroupTest < ActiveSupport::TestCase

  test 'threadsafe Arel.count' do

    Group.destroy_all
    Group.create(name: 'New Name')
    assert_equal 1, Group.count

    group_counts = ThreadSafe::Array.new
    threads = []
    10.times do |i|
      threads[i] = Thread.new(i) do
        c = Group.count
        puts c
        group_counts[i] = c
      end
    end
    threads.each { |thread| thread.join }
    puts group_counts.inspect
    10.times { |i| assert_equal 1, group_counts[i] }

  end

end

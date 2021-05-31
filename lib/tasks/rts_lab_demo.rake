# frozen_string_literal: true

require 'rake_objects/rts_lab_helper'

namespace :rts_labs do
  include RtsLabHelper

  desc 'Prints out integers above and below as given integer'
  task :integers_above_and_below do |_t, args|
    # usage 1: rake 'rts_labs:integers_above_and_below[6, 3, 4, 5, 6, 7, 8, 9]'
    # usage 2: rake 'rts_labs:integers_above_and_below[6]'
    # notes
    ### Please note the way single (simple) quotes are used
    ### First arg will be the number to compare (elements in array are above or below the first arg)
    ### All args must convert to integers
    ### usage 2 will use a default array of ints to compare: (default comparison array: [8, 13, 6, 21, 30, 5, 7, 9, 3])
    before_and_after = before_and_after_position_in_string(args)
    abort(before_and_after[:error]) if before_and_after.key?(:error)
    puts "The numbers in this array #{before_and_after[:numbers]} are compared with #{before_and_after[:compare]}:"
    puts "Total above: #{before_and_after[:after]}, Total below: #{before_and_after[:before]}"
  end

  desc 'Prints all the characters after a given position at the beginning of the string'
  task :character_rotation, [:original, :num_chars] do |_t, args|
    # usage: rake 'rts_labs:character_rotation[MyString, 2]'
    # notes
    ### Please note the way single (simple) quotes are used
    ### first arg will remain a string
    ### second arg must be integer between and not including 0 and the length of the string
    results = rotate_characters_in_string(args)
    abort(results[:error]) if results.key?(:error)
    puts "#{results[:original]} rotated by #{results[:num_chars]} is #{results[:new_string]}"
  end

  desc 'What I would change in Rails'
  task dream_changes_in_rails: :environment do
    # usage: rake rts_labs:dream_changes_in_rails
    puts 'I love rails, but really wish that the Rails ActiveRecord did not silently create inefficient SQL. '\
      'It would be nice if it automatically used joins and includes, and never created multiple queries '\
      'unnecessarily (the n+1 problem).  If there was a use_case for something that acted like n+1, the programmer '\
      'could ask explicitly.'
    puts 'Along the same vein, it would be great if the SQL created by ActiveRecord magic was automatically optimized '\
      'Some of this could be done by giving suggestions, such as remind the programmer to add an index on given field.'
  end
end

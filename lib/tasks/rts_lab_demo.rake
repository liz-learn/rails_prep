# frozen_string_literal: true

require 'rake_objects/rtl_lab_helper'

namespace :rts_labs do
  include RtlLabHelper

  desc 'Prints out integers above and below as given integer'
  task :integers_above_and_below do |_t, args|
    before_and_after = before_and_after_position_in_string(args)
    abort(before_and_after[:error]) if before_and_after.key?(:error)
    puts "above: #{before_and_after[:after]}, below: #{before_and_after[:before]}"
  end

  desc 'Prints all the characters after a given position at the beginning of the string'
  task :string_rotation do |_t, args|
    puts ''
  end

  desc 'What I would change in Rails'
  task dream_changes_in_rails: :environment do
    puts 'I would love it Rails Active Record did not ever create n+1.'
    puts 'Along the same vein, it would be great if the SQL created by Active Record magic was automatically optimized'
  end
end

# frozen_string_literal: true

# use in RtlLab Demo, for form could move to mixin folder
module RtlLabHelper
  def before_and_after_position_in_string(args)
    # usage >>>rake 'rts_labs:integers_above_and_below[6, 3, 4, 5, 6, 7, 8, 9]'
    # or  >>>rake 'rts_labs:integers_above_and_below[6]' (default comparison array: [8, 13, 6, 21, 30, 5, 7, 9, 3])
    # notes
    ### First arg will be the position to compare (above or below)
    ### All args must be integers
    before_and_after = { before: 0, after: 0 }
    in_args = parse_args(args)
    return in_args if in_args.key?(:error)

    pos = in_args[:ints].shift
    numbers = in_args[:ints].empty? ? [8, 13, 6, 21, 30, 5, 7, 9, 3] : in_args[:ints]
    numbers.each do |num|
      before_and_after = accumulate_before_or_after(num, pos, before_and_after)
    end
    before_and_after
  end

  def parse_args(args)
    input_array = args.extras.map(&:to_str)
    return { error: 'You need at least one input parameter.  The first one will be the position' } if input_array.empty?

    integers_from_args(input_array)
  end

  def integers_from_args(input_array)
    ints = []
    input_array.each do |str_num|
      ints << 0 && next if str_num.strip == '0'

      num = str_num.to_i
      return { error: 'All input parameters must represent an integer' } if num.zero?

      ints << num
    end
    { ints: ints }
  end

  def accumulate_before_or_after(num, pos, before_and_after)
    return before_and_after if num == pos

    before_and_after[:before] += 1 if num < pos
    before_and_after[:after] += 1  if num > pos
    before_and_after
  end
end

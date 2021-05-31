# frozen_string_literal: true

# use in RtsLab Demo, for form could move to mixin folder
module RtsLabHelper
  DEFAULT_ARG = [8, 13, 6, 21, 30, 5, 7, 9, 3].freeze
  BEFORE_AFTER_NUM_PARAMS = 'You need at least one input parameter.  The first one will be the comparison integer.'
  BEFORE_AFTER_REPRESENT_INT = 'All input parameters must represent an integer.'
  ROTATE_NUM_PARAMS = 'Need both number of characters and the string to rotate.'
  ROTATE_NUM_CHARS = 'The second argument must be a positive integer'
  ROTATE_NUM_CHARS_LENGTH = 'The original string length must be greater than the number of characters to rotate.'

  def before_and_after_position_in_string(args)
    before_and_after = { before: 0, after: 0 }
    in_args = parse_args(args)
    return in_args if in_args.key?(:error)

    before_and_after[:compare] = in_args[:ints].shift
    before_and_after[:numbers] = in_args[:ints].empty? ? DEFAULT_ARG : in_args[:ints]
    before_and_after[:numbers].each do |num|
      before_and_after = accumulate_before_or_after(num, before_and_after[:compare], before_and_after)
    end
    before_and_after
  end

  def parse_args(args)
    input_array = args.extras.map(&:to_str)
    return { error: BEFORE_AFTER_NUM_PARAMS } if input_array.empty?

    integers_from_args(input_array)
  end

  def integers_from_args(input_array)
    ints = []
    input_array.each do |str_num|
      ints << 0 && next if str_num.strip == '0'

      num = str_num.to_i
      return { error: BEFORE_AFTER_REPRESENT_INT } if num.zero?

      ints << num
    end
    { ints: ints }
  end

  def accumulate_before_or_after(num, compare, before_and_after)
    return before_and_after if num == compare

    before_and_after[:before] += 1 if num < compare
    before_and_after[:after] += 1  if num > compare
    before_and_after
  end

  def rotate_characters_in_string(args)
    result = validate_rotate_args(args)
    return result if result.key?(:error)

    result[:new_string] = rotate_by_num_chars(result[:original], result[:num_chars])
    result
  end

  def validate_rotate_args(args)
    return { error: ROTATE_NUM_PARAMS } unless args[:original] && args[:num_chars]

    num_chars = args[:num_chars].to_i
    return { error: ROTATE_NUM_CHARS } unless num_chars.positive?

    original = args[:original]
    return { error: ROTATE_NUM_CHARS_LENGTH } unless num_chars < original.length

    { original: original, num_chars: num_chars }
  end

  def rotate_by_num_chars(original, num_chars)
    end1 = (num_chars + 1) * -1
    beg2 = num_chars * -1
    temp = [original[0..end1], original[beg2..]]
    temp[1] + temp[0]
  end
end

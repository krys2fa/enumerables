module Enumerable
  # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Style/For, Lint/AmbiguousBlockAssociation
  def my_each
    return unless block_given?

    for element in self
      yield(element)
    end
  end

  def my_each_with_index
    return unless block_given?

    index = 0
    for element in self
      yield(element, index)
      index += 1
    end
  end

  def my_select
    return unless block_given?

    if is_a? Array
      output = []
      my_each { |element| output << element if yield(element) }
    else
      output = {}
      my_each { |element, value| output[element] = value if yield(element, value) }
    end
    output
  end

  def my_all?(arg = nil)
    falsey = 0

    if block_given?
      my_each { |element| falsey += 1 if yield(element) == false || yield(element).nil? }
    elsif !arg.nil? && arg.class == Class
      my_each { |element| falsey += 1 unless element.is_a? arg }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |element| falsey += 1 unless element.match(arg) }
    else
      my_each { |element| falsey += 1 if element == false || element.nil? }
    end
    falsey.positive? ? false : true
  end

  def my_any?(arg = nil)
    truthy = 0
    return false if empty?

    if block_given?
      my_each { |element| truthy += 1 if yield(element) != false || !yield(element).nil? }
    elsif !arg.nil? && arg.class == Class
      my_each { |element| truthy += 1 if element.is_a? arg }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |element| truthy += 1 if element.match(arg) }
    else
      my_each { |element| truthy += 1 if element != false || !element.nil? }
    end

    truthy.positive? ? true : false
  end

  def my_none?(arg = nil)
    truthy = 0

    if block_given?
      my_each { |element| truthy += 1 if yield(element) == true }
    elsif !arg.nil? && arg.class == Class
      my_each { |element| truthy += 1 if element.is_a? arg }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |element| truthy += 1 if element.match(arg) }
    else
      my_each { |element| truthy += 1 if element == true }
    end

    truthy.positive? ? false : true
  end

  def my_count(arg = nil)
    counter = 0
    if block_given?
      my_each { |element| counter += 1 if yield(element) == true }
    elsif !arg.nil?
      my_each { |element| counter += 1 if element == arg }
    else
      my_each { counter += 1 }
    end
    counter
  end

  def my_map
    output = []
    if block_given?
      my_each { |element| output << element if yield(element) }
    else
      my_each { |element| output << proc.call(element) }
    end
    output
  end

  def my_inject(arg = nil)
    if arg.is_a? Symbol
      pp reduce { |memo, element| memo.send(arg, element) }
    else
      memo = arg
      memo = my_each { |element| memo.nil? ? element : yield(memo, element) } if block_given?
      pp memo
    end
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

# rubocop:enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Style/For, Lint/AmbiguousBlockAssociation

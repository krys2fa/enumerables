# rubocop:disable Style/CaseEquality

# rubocop:enable Style/CaseEquality

module Enumerable
  def my_each
    if block_given?
      for element in self
        yield(element)
      end
    end
  end

  def my_each_with_index
    if block_given?
      index = 0
      for element in self
        yield(element, index)
        index += 1
      end
    end
  end





end


arr = [5, 4, 3]

ha = {"one" => 1, "two" => 2}



# arr.each_with_index { |el, index| puts el, index}
# arr.each_with_index { |el, index| puts "#{el}, #{index}"}
#  arr.each_with_index { |el, index| puts "#{self}, #{index}"}
# (1..5).each_with_index { |el, index| puts "#{el}, #{index}"}

# ha.each
# ha.each_with_index { |el| puts el}
# ha.each_with_index { |el| puts "#{el}"}
# ha.each_with_index { |(k, v), index| puts "answer: #{k} and #{v} and #{index}"}

puts "=========="

# arr.my_each_with_index { |el, index| puts el, index}
# arr.my_each_with_index { |el, index| puts "#{el}, #{index}"}
#  arr.my_each_with_index { |el, index| puts "#{self}, #{index}"}
# (1..5).my_each_with_index { |el, index| puts "#{el}, #{index}"}

# ha.my_each_with_index
# ha.my_each_with_index { |el| puts el}
# ha.my_each_with_index { |(k, v), index| puts "answer: #{k} and #{v} and #{index}"}



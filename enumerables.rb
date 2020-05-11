# rubocop:disable Style/CaseEquality

# rubocop:enable Style/CaseEquality

module Enumerable
  def my_each
    # your code here
    if block_given?
      for element in self
        # puts "#{element}"
        yield(element)
      end
    end
  end
end


arr = [5, 4, 3]

ha = {"one" => 1, "two" => 2}

# arr.my_each

# arr.each {|k, v| puts "answer: #{k}, #{v}"}

# arr.each { |el| puts el}
# arr.each { |el| puts "#{el}"}
#  arr.each { |el| puts "#{self}"}

# ha.each
# ha.each { |el| puts el}
# ha.each { |el| puts "#{el}"}
ha.each { |k, v| puts "answer: #{k} and #{v}"}

puts "=========="

# arr.my_each { |el| puts el}
# arr.my_each { |el| puts "#{el}"}
#  arr.my_each { |el| puts "#{self}"}

# ha.my_each
# ha.my_each { |el| puts el}
ha.my_each { |k, v| puts "answer: #{k} and #{v}"}



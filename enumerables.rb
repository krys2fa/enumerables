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

  def my_select
    if block_given?
      if self.is_a? Array
        output = []
        self.my_each { |element| output << element if yield(element) }
      else
        output = {}
        self.my_each { |element, value| output[element] = value if yield(element, value) }
      end
      output
    end
  end



end





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

    def my_all?(arg = nil)
      falsey = 0

      if block_given?
        self.my_each { |element| falsey += 1 if yield(element) == false || yield(element) == nil }
      elsif arg != nil && arg.class == Class
        self.my_each { |element| falsey += 1 if !element.is_a? arg }
      elsif arg != nil && arg.class == Regexp
        self.my_each { |element| falsey += 1 if !element.match(arg) }
      else
        self.my_each { |element| falsey += 1 if element == false || element == nil }
      end
      falsey > 0 ? false : true

    end
    
    def my_any?(arg=nil)
      truthy = 0
      return false if self.empty?

      if block_given?
        self.my_each { |element| truthy += 1 if yield(element) != false || yield(element) != nil }
      elsif arg != nil && arg.class == Class
        self.my_each { |element| truthy += 1 if element.is_a? arg }
      elsif arg != nil && arg.class == Regexp
        self.my_each { |element| truthy += 1 if element.match(arg) }
      else
        self.my_each { |element| truthy += 1 if element != false || element != nil }
      end
      
      truthy > 0 ? true : false

    end

    def my_none?(arg=nil)
      truthy = 0

      if block_given?
        self.my_each { |element| truthy += 1 if yield(element) == true }
      elsif arg != nil && arg.class == Class
        self.my_each { |element| truthy += 1 if element.is_a? arg }
      elsif arg != nil && arg.class == Regexp
        self.my_each { |element| truthy += 1 if element.match(arg) }
      else
        self.my_each { |element| truthy += 1 if element == true  }
      end
      
      truthy > 0 ? false : true
    end

    def my_count(arg=nil)
      counter = 0

      if block_given?
        self.my_each { |element| counter += 1 if yield(element) == true }
      elsif arg != nil
        self.my_each { |element| counter += 1 if element == arg  }
      else
        self.my_each { counter +=1  }
      end
      counter
    end

    def my_map
      if block_given?
        output = []
        self.my_each { |element| output << element if yield(element) }
      end
      output
    end

    def my_inject(arg=nil)

      if arg.is_a? Symbol
        pp reduce { |memo, element| memo.send(arg, element) }
      else
        memo = arg
        self.my_each { |element| memo.nil? ? memo = element : memo = yield(memo, element) } if block_given?
        pp memo
      end

    end

    

  end

  def multiply_els(arr)
    output = arr.my_inject(:*)
  end


  multiply_els([2,4,5]) #=> 40


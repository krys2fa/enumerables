require_relative '../enumerables'

describe Enumerable do
  let(:test_array) { [1, 2, 3, 4, 5] }
  let(:test_range) { (1..5) }
  let(:test_hash) { { 'one' => 1, 'two' => 2 } }

  describe '#my_each' do
    it 'should return an enumerator when no block is passed' do
      expect(test_array.my_each.class).to eql(Enumerator)
    end

    it 'should list all elements in an array' do
      expect(test_array.my_each { |i| }).to eql(test_array.each { |i| })
    end

    it 'should work with ranges the same as Ruby each enumerable ' do
      expect(test_range.my_each { |i| }).to eql(test_range.each { |i| })
    end

    it 'should work with hashes the same as Ruby each enumerable' do
      expect(test_hash.my_each { |i| }).to eql(test_hash.each { |i| })
    end
  end

  describe '#my_each_with_index' do
    it 'should return an enumerator when no block is passed' do
      expect(test_array.my_each_with_index.class).to eql(Enumerator)
    end

    it 'should work with arrays the same as Ruby each_with_index enumerable' do
      expect(test_array.my_each_with_index { |i, j| "#{i} => #{j}" })
        .to eql(test_array.each_with_index { |i, j| "#{i} => #{j}" })
    end

    it 'should work with ranges the same as Ruby each_with_index enumerable' do
      expect(test_range.my_each_with_index { |i, j| "#{i} => #{j}" })
        .to eql(test_range.each_with_index { |i, j| "#{i} => #{j}" })
    end

    it 'should work with hashes the same as Ruby each_with_index enumerable' do
      expect(test_hash.my_each_with_index { |i, j| "#{i} => #{j}" })
        .to eql(test_hash.each_with_index { |i, j| "#{i} => #{j}" })
    end
  end

  describe '#my_select' do
    it 'should return an enumerator when no block is passed' do
      expect(test_array.my_select.class).to eql(Enumerator)
    end

    it 'should return an array of elements that passes the test in the block' do
      expect(test_array.my_select(&:even?)).to eql(test_array.my_select(&:even?))
    end
  end

  describe '#my_all' do
    it 'should return true if there is no block and argument passed and the array
      elements never return false or nil' do
      expect(test_array.my_all?).to eql(test_array.all?)
    end

    it 'should return true if there is no block but an argument is passed and the array
      elements never return false or nil' do
      expect(test_array.my_all?(Numeric)).to eql(test_array.all?(Numeric))
    end

    it 'should return false if there is no block but argument passed is a regex and the array
      elements never return false or nil' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(%w[ant bear cat].all?(/t/))
    end

    it 'should return true if there a block is passed without an argument and the array elements
      never return false or nil' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 })
        .to eql(%w[ant bear cat].all? { |word| word.length >= 4 })
    end

    it 'should return true if array is empty and no block or argument passed and the array
      elements never return false or nil' do
      expect([].my_all?).to eql([].all?)
    end
  end

  describe '#my_any' do
    it 'should return true if there is no block and argument passed and the array elements
      return a value other than false or nil' do
      expect(test_array.my_any?).to eql(test_array.any?)
    end

    it 'should return true if there is no block but an argument is passed and the array elements return
      a value other than false or nil' do
      expect(test_array.my_any?(Integer)).to eql(test_array.any?(Integer))
    end

    it 'should return false if there is no block but argument passed is a regex and the array elements
      return a value other than false or nil' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(%w[ant bear cat].any?(/d/))
    end

    it 'should return true if there a block is passed without an argument and the
      array elements return a value other than false or nil' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 })
        .to eql(%w[ant bear cat].any? { |word| word.length >= 4 })
    end

    it 'should return true if array is empty and no block or argument passed and
      the array elements return a value other than false or nil' do
      expect([].my_any?).to eql([].any?)
    end
  end

  describe '#my_none' do
    it 'should return true if there is no block and argument passed and the method
      returns true if the block never returns true for all elements' do
      expect([nil].my_none?).to eql([nil].none?)
    end

    it 'should return true if there is no block but an argument is passed and the
      method returns true if the block never returns true for all elements' do
      expect(test_array.my_none?(Float)).to eql(test_array.none?(Float))
    end

    it 'should return false if there is no block but argument passed is a regex and
      the method returns true if the block never returns true for all elements' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(%w[ant bear cat].none?(/d/))
    end

    it 'should return true if there a block is passed without an argument and the
      method returns true if the block never returns true for all elements' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 })
        .to eql(%w[ant bear cat].none? { |word| word.length >= 4 })
    end

    it 'should return true if array is empty and no block or argument passed and
      the method returns true if the block never returns true for all elements' do
      expect([].my_none?).to eql([].none?)
    end
  end

  describe '#my_count' do
    it 'should count the number of elements yielding a true value if a block is given.' do
      expect(test_array.my_count(&:even?)).to eql(test_array.count(&:even?))
    end

    it 'should count the number of elements yielding a true value if a block is
      not given but an argument is given.' do
      expect(test_array.my_count(2)).to eql(test_array.count(2))
    end

    it 'should count the number of elements yielding a true value if no block or
      argument is given.' do
      expect(test_array.my_count).to eql(test_array.count)
    end
  end

  describe '#my_map' do
    it 'should return an enumerator when no block is passed' do
      expect(test_array.my_map.class).to eql(Enumerator)
    end

    it 'should return a new array with the results of running block once for every element in enum' do
      expect(test_range.my_map { |i| i * i }).to eql(test_range.map { |i| i * i })
    end
  end

  describe '#my_inject' do
    it 'should return value for method if argument is passed and no block is given' do
      expect(test_range.my_inject(:+)).to eql(test_range.inject(:+))
    end

    it 'should return value for method if block is passed and no argument passed' do
      expect(test_range.my_inject { |sum, n| sum + n })
        .to eql(test_range.inject { |sum, n| sum + n })
    end

    it 'should return value for method if arguments are passed' do
      expect(test_range.my_inject(1, :*)).to eql(test_range.inject(1, :*))
    end

    it 'should return a value for method if arguments and block is passed' do
      expect(test_range.my_inject(1) { |product, n| product * n })
        .to eql(test_range.inject(1) { |product, n| product * n })
    end
  end
end

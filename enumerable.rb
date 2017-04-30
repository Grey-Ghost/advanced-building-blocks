module Enumerable

  def my_each
    return self.to_enum(:my_each) unless block_given?
    for x in 0...length
      yield(self[x])
    end
    return self
  end

  def my_each_with_index
    return self.to_enum(:my_each_with_index) unless block_given?
    for x in 0...length
      yield(self[x], x)
    end
    return self
  end

  def my_select
    return self.to_enum(:my_select) unless block_given?
    new_arr = []
    self.my_each { |x| new_arr << x if yield(x)}
    return new_arr
  end

  def my_all?
    result = true
    if !block_given?
      self.my_each {|x| result = false if !x}
    else
      self.my_each {|x|  result = false if !yield(x)}
    end
    return result
  end

  def my_any?
    count = 0
    if !block_given?
      self.my_each {|x| count += 1 if x}
    else
      self.my_each {|x|  count += 1 if yield(x)}
    end
    count == 0 ? answer = false : answer = true
  end

  def my_none?
    result = true
    if !block_given?
      self.my_each {|x| result = false if x}
    else
      self.my_each {|x|  result = false if yield(x)}
    end
    return result
  end

  def my_count *args
    count = 0
    return size if args.empty? && !block_given?
     warn ("warning: given block not used") if !args.empty? && block_given?
     if !args.empty?
        self.my_each {|x| count+=1 if x == args[0]}
     else
       self.my_each {|x|  count += 1 if yield(x)}
     end
     return count
  end

  def my_map proc = nil
    new_arr =[]
    return self.to_enum(:my_select) unless block_given? || proc
    if proc
      self.my_each {|x| new_arr << proc.call(x)}
    else
      self.my_each { |x| new_arr << yield(x)}
    end
    return new_arr
  end

  def my_inject *args
  	if !args.empty?
      total = args[0]
      n = 0
		else
      total = self[0]
      n = 1
    end
		self[n..self.length].my_each {|i| total = yield(total, i)}
		return total
  end

end

def multiply_els arr
  arr.my_inject{|x, y| x * y }
end


test_data = ["Hope", "is", "a", "four",  "letter", "word"]
new_arr = [1, 2, 3, 4, 5]
proc = Proc.new {|x| x*2}
puts "my_each"
test_data.my_each {|v| puts "value: #{v}"}
puts "-------------------------"
puts
puts "my_each_with_index"
test_data.my_each_with_index {|v, i| puts "value: #{v} index: #{i}"}
test_data1 = [1, 2, 3, 4, 5, 6]
puts "-------------------------"
puts
puts "my_select"
puts test_data1.my_select {|item| item%2==0 }
puts "-------------------------"
puts
puts "my_all?"
puts test_data1.my_all? {|item| item > 0}
puts "-------------------------"
puts
puts "my_any?"
puts test_data1.my_any? {|item| item > 2}
puts "-------------------------"
puts
puts "my_none?"
puts test_data.my_none?
puts "-------------------------"
puts
puts "my_count"
puts new_arr.my_count(3)
puts new_arr.count(3){|x| x>2}
puts "-------------------------"
puts
puts "my_map"
puts new_arr.my_map {|x| x*2}
puts
puts new_arr.my_map(proc)
puts "-------------------------"
puts
puts "my_inject"
puts multiply_els([2,4,5])

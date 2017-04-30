
def bubble_sort to_sort
  loop do
    swapped = false
    for i in 1...to_sort.length do
      if to_sort[i-1] > to_sort[i]
        swap = to_sort[i-1]
        to_sort[i-1] = to_sort[i]
        to_sort[i] = swap
        swapped = true
      end
    end
    break if swapped == false
   end
   return to_sort
end

def bubble_sort_by to_sort
  loop do
    swapped = false
    for i in 1...to_sort.length do
      if yield(to_sort[i],to_sort[i-1]) < 0
        swap = to_sort[i-1]
        to_sort[i-1] = to_sort[i]
        to_sort[i] = swap
        swapped = true
      end
    end
    break if swapped == false
  end
  return to_sort
end

puts "#{bubble_sort([4,3,78,2,0,2])}"

puts "#{print(bubble_sort_by(["hi","hello","hey"]) do |left, right|
    left.length - right.length
end)}"

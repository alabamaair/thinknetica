arr = [ 1, 1 ]
fib_next = arr[0] + arr[1]

while fib_next < 100
  arr << fib_next
  fib_next = arr[-2] + arr[-1]
end

puts arr
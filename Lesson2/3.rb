array = []
fib1 = 1
fib2 = 1
fib_next = fib1 + fib2
array << fib1 << fib2
while fib_next < 100
  fib1 = fib2
  fib2 = fib_next
  array << fib_next
  fib_next = fib1 + fib2
end
puts array
require_relative 'accessors'

class Test
  extend Accessors

  attr_accessor_with_history :a
  strong_attr_accessor :b, Fixnum

end

t = Test.new
t.a = 1
t.a = 'smth'
t.a_history # => [1, "smth"]

t.b = 'smthng' # => RuntimeError: Неправильный тип переменной, значение не будет присвоено.
t.b = 1 # => 1


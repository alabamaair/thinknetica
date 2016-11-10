puts "Введите a:"
a = gets.chomp.to_f
puts "Введите b:"
b = gets.chomp.to_f
puts "Введите c:"
c = gets.chomp.to_f

d = (b**2) - (4*a*c)

if d < 0
	puts "нет корней, дискриминант #{d}"
elsif d == 0
	x = (b*(-1))/(2*a)
	puts "дискриминант #{d}, оба корня равны #{x}"
else
	c = Math.sqrt(d)
	x1 = ((b*(-1)) + c) / (2 * a)
	x2 = ((b*(-1)) - c) / (2 * a)
	puts "дискриминант #{d}, первый корень #{x1}, второй корень #{x2}"
end

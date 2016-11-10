puts "Введите первую сторону треугольника:"
first = gets.chomp.to_f
puts "Введите вторую сторону треугольника:"
second = gets.chomp.to_f
puts "Введите третью сторону треугольника:"
third = gets.chomp.to_f

triangle = [first, second, third].sort!

if triangle[2]**2 == triangle[1]**2 + triangle[0]**2
	puts "Треугольник прямоугольный! "
	if triangle[0] == triangle[1] || triangle[1] == triangle[2] || triangle [0] == triangle[2]
		print "и равнобедренный!"
	end
else
	puts "Треугольник не прямоугольный!"
end
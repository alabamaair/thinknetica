puts "Введите ваше имя: "
name = gets.chomp

puts "Введите ваш рост (в см.): "
hight = gets.chomp

ideal_weight = hight.to_i - 110

if ideal_weight <= 0
	puts "#{name}, ваш вес уже оптимальный."
else
	puts "#{name}, ваш оптимальный вес #{ideal_weight} кг."
end
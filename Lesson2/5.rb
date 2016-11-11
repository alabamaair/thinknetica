puts "Введите день:"
day = gets.chomp.to_i

puts "Введите месяц:"
month = gets.chomp.to_i

puts "Введите год:"
year = gets.chomp.to_i

if day > 31 || month > 12
  puts "Неправильный формат даты."
  exit
end

months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }

if year % 4 == 0 && !(year % 100 == 0) || year % 400 == 0
  months[2] = 29
end

count = 0
unless month == 1
  (month - 1).downto(1) do |i|
    count = count + months[i]
  end
end

number = day + count

puts "Порядковый номер введенной даты: #{number}"

cart = {}
loop do
  puts "Введите название товара:"
  name = gets.chomp

  break if name == 'стоп'

  puts "Введите цену:"
  price = gets.chomp.to_f

  puts "Введите количество:"
  quantity = gets.chomp.to_f

  cart[name] = { price => quantity }
end

puts "Ваша корзина: #{cart}"

total_item = 0
total_sum = 0
cart.each do |item_name, item|
  item.each do |p,q|
    total_item = p * q
  end
  puts "Товар: #{item_name}, итоговая цена: #{total_item}"
  total_sum += total_item
end

puts "Общая сумма покупок: #{total_sum}"
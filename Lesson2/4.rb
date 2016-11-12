vowels = ["a", "e", "i", "o", "u"]
hash = {}
('a'..'z').each_with_index do |letter, index|
  hash[letter] = index + 1 if vowels.include?(letter)
end
puts hash

vowels = ["a", "e", "i", "o", "u"]
hash = {}
i = 1
('a'..'z').each do |letter|
  if vowels.include? letter
    hash[letter] = i
  end
  i += 1
end
puts hash

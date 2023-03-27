# define variables
secret_code = []
guess = []
guess_count = 0
max_guesses = 12
colors = ['red', 'green', 'blue', 'yellow', 'orange', 'purple']

# generate secret code
4.times do
  secret_code << colors.sample
end

# define helper methods
def get_guess
  print "Enter your guess (e.g. red green blue yellow): "
  gets.chomp.split(' ')
end

def compare_codes(secret_code, guess)
  exact_matches = 0
  color_matches = 0
  secret_code_copy = secret_code.dup
  guess_copy = guess.dup

  # count exact matches
  guess_copy.each_with_index do |color, index|
    if color == secret_code_copy[index]
      exact_matches += 1
      guess_copy.delete_at(index)
      secret_code_copy.delete_at(index)
    end
  end

  # count color matches
  guess_copy.each do |color|
    if secret_code_copy.include?(color)
      color_matches += 1
      secret_code_copy.delete_at(secret_code_copy.index(color))
    end
  end

  return exact_matches, color_matches
end

# game loop
puts "Welcome to Mastermind!"
puts "The secret code contains 4 colors from: #{colors.join(', ')}"

while guess_count < max_guesses
  guess = get_guess

  if guess.size != 4
    puts "Invalid guess. Please enter 4 colors."
    next
  end

  # check if guess matches secret code
  exact_matches, color_matches = compare_codes(secret_code, guess)

  if exact_matches == 4
    puts "You win!"
    break
  else
    guess_count += 1
    puts "You have #{max_guesses - guess_count} guesses left."
    puts "Exact matches: #{exact_matches}. Color matches: #{color_matches}"
  end
end

if guess_count == max_guesses
  puts "Game over. The secret code was: #{secret_code.join(' ')}"
end

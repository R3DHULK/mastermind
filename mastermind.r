# Define the available colors and the length of the code
colors <- c("R", "G", "B", "Y", "O", "P")
code_length <- 4

# Generate a random code
set.seed(123)
code <- sample(colors, code_length, replace=TRUE)

# Function to evaluate a guess and return the number of correct colors and positions
evaluate_guess <- function(guess, code) {
  correct_positions <- sum(guess == code)
  correct_colors <- sum(guess %in% code) - correct_positions
  return(c(correct_positions, correct_colors))
}

# Game loop
attempts <- 0
while (TRUE) {
  # Get the user's guess
  cat("\n")
  guess <- readline(prompt=paste("Enter your guess (", paste(colors, collapse=", "), "): "))
  guess <- strsplit(guess, "")[[1]]
  
  # Check the guess and print the result
  result <- evaluate_guess(guess, code)
  cat("Result: ", result[1], " correct position and color, ", result[2], " correct color but wrong position.\n")
  
  # Increment the number of attempts
  attempts <- attempts + 1
  
  # Check if the game is over
  if (result[1] == code_length) {
    cat("\n")
    cat("Congratulations! You guessed the code in ", attempts, " attempts.\n")
    break
  } else if (attempts >= 10) {
    cat("\n")
    cat("Game over! You ran out of attempts. The code was: ", paste(code, collapse=""), "\n")
    break
  }
}

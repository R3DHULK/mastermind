package main

import (
    "fmt"
    "math/rand"
    "strconv"
    "time"
)

const (
    codeLength = 4
    maxTries   = 10
)

func main() {
    rand.Seed(time.Now().UnixNano())

    // Generate the secret code
    code := generateCode()

    // Initialize the number of tries
    tries := 0

    // Keep playing until the player guesses the code or runs out of tries
    for tries < maxTries {
        fmt.Println("Guess the 4-digit code (0-9):")

        // Read the player's guess from the command line
        guess := readGuess()

        // Check the guess against the code and print the results
        correct, misplaced := checkGuess(guess, code)
        fmt.Printf("Correct: %d, Misplaced: %d\n", correct, misplaced)

        // Check if the player guessed the code
        if correct == codeLength {
            fmt.Println("Congratulations! You guessed the code!")
            return
        }

        // Increment the number of tries
        tries++
    }

    fmt.Println("You ran out of tries. The code was:", code)
}

// generateCode generates a random 4-digit code.
func generateCode() [codeLength]int {
    var code [codeLength]int

    for i := 0; i < codeLength; i++ {
        code[i] = rand.Intn(10)
    }

    return code
}

// readGuess reads the player's guess from the command line.
func readGuess() [codeLength]int {
    var guess [codeLength]int

    for i := 0; i < codeLength; i++ {
        var input string
        fmt.Scan(&input)

        // Convert the input string to an integer
        num, err := strconv.Atoi(input)
        if err != nil {
            fmt.Println("Invalid input. Please enter a number between 0 and 9.")
            i--
            continue
        }

        // Check if the input number is valid
        if num < 0 || num > 9 {
            fmt.Println("Invalid input. Please enter a number between 0 and 9.")
            i--
            continue
        }

        guess[i] = num
    }

    return guess
}

// checkGuess checks the player's guess against the code and returns the number of correct and misplaced digits.
func checkGuess(guess, code [codeLength]int) (int, int) {
    var correct, misplaced int

    // Check for correct digits in the correct position
    for i := 0; i < codeLength; i++ {
        if guess[i] == code[i] {
            correct++
        }
    }

    // Check for correct digits in the wrong position
    for i := 0; i < codeLength; i++ {
        for j := 0; j < codeLength; j++ {
            if i != j && guess[i] == code[j] {
                misplaced++
            }
        }
    }

    return correct, misplaced
}

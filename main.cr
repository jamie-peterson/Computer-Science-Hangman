wordbank = File.read("wordbank.txt").split("\n")
secret_word = wordbank[Random.rand(wordbank.size)]
hangman_art = ["
 +---+
 |   |
     |
     |
     |
     |
=========
", "
 +---+
 |   |
 O   |
     |
     |
     |
=========", "
 +---+
 |   |
 O   |
 |   |
     |
     |
=========", "
 +---+
 |   |
 O   |
/|   |
     |
     |
=========", "
 +---+
 |   |
 O   |
/|\\  |
     |
     |
=========", "
 +---+
 |   |
 O   |
/|\\  |
/    |
     |
=========", "
 +---+
 |   |
 O   |
/|\\  |
/ \\  |
     |
========="]

key = secret_word.split(//)

display = [] of String
i = 0
while i < key.size
    if key[i] == " " || key[i] == "-" #special characters
        display << key[i]
    else
        display << "_"
    end
    
    i+=1
end

playing = true
incorrect = 0
guesses = "";
previousGuess = true

while playing
    
    system "clear"
    puts hangman_art[incorrect]
    if guesses != ""
        print "Previous guesses: ", guesses, "\n"
    end
    puts display
    if previousGuess
        puts "Please enter a letter: "
    else
        puts "Letter has already been entered, please enter a different letter."
    end
    guess = gets.not_nil!
    
    if !guesses.includes?(guess)
        guesses += guess
        previousGuess = true
        if key.index(guess) == nil
            incorrect += 1
            if incorrect == 6
                playing = false
                system "clear"
                puts hangman_art[incorrect]
                puts display
                print "Game Over... The word was ", secret_word, "\n"
            end
        else
            j = 0
            while j < key.size
                if key[j] == guess
                    display[j] = guess
                end
                j += 1
            end
            if key == display
                playing = false
                system "clear"
                puts hangman_art[incorrect]
                puts display
                puts "Winner!"
            end
        end
    else 
        previousGuess = false
    end
end
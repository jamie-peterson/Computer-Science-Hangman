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
    if key[i] == " " || key[i] == "-"
        display << key[i]
    else
        display << "_"
    end
    
    i+=1
end

playing = true
incorrect = 0
while playing
    system "clear"
    puts hangman_art[incorrect]
    puts display
    puts "Please enter a letter: "
    guess = gets.not_nil!
    
    if key.index(guess) == nil
        incorrect += 1
        if incorrect == 6
            playing = false
            system "clear"
            puts hangman_art[incorrect]
            puts display
            puts "Game Over"
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
end


startMenu

def startMenu()
    fanciness = "

    ╔══════════════════════════════════╗
    ║            Welcome to            ║
    ║      Compuer Science Hangman!    ║
    ║     Press 1 to start a new game  ║
    ║     Press 0 to quit              ║
    ╚══════════════════════════════════╝
    
    "
    puts fanciness
    input = gets.not_nil!
    if input.matches?(/1/)
        game
    elsif input.matches?(/0/)
        exit
    end
end

def game() 

gameMenu = "
    ╔══════════════════════════╗
    ║   Press 1 get hint       ║
    ║   Press 2 to guess word  ║
    ║   Press 0 to end game    ║
    ╚══════════════════════════╝
"

wordbank = File.read("wordbank.txt").split("\n")
secret_word = wordbank[Random.rand(wordbank.size)]
# secret_word = wordbank[9]

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
        puts gameMenu
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
    
        flag = true
        guess = ""
        while flag
            guess = gets.not_nil!        
            if guess.bytesize > 1
                puts "Please enter a single letter: "
                flag = true
            else flag = false 
            end
        end
        # if guess.mathches(/1/)
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
                    startMenu()

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
                    startMenu()
                end
            end
        else 
            previousGuess = false
        end
    end
end
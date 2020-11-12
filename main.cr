
checkHiScores
startMenu

def checkHiScores()
    if File.exists?("hiscores.txt")
        # call sort for hiscores
        return;
    else File.write("hiscores.txt", "")
    end
end

def startMenu()
    fanciness = "

    ╔══════════════════════════════════╗
    ║            Welcome to            ║
    ║      Computer Science Hangman!   ║
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

def getHiScoreData(word, name, score)
    data = word + " " + name + " " + score
    File.write("hiscores.txt", data)
end

def game() 

gameMenu = "
    ╔══════════════════════════╗
    ║   Press 1 get hint       ║
    ║   Press 2 to guess word  ║
    ║   Press 0 to end game    ║
    ╚══════════════════════════╝
"

wordbank = File.read_lines("wordbank.txt")
hintBank = File.read_lines("hints.txt")
fileIndex = Random.rand(wordbank.size)
secret_word = wordbank[fileIndex]
hint = hintBank[fileIndex]
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
    hintflag = false
    while playing
        
        system "clear"

        puts gameMenu
        puts hangman_art[incorrect]
        
        if guesses != ""
            print "Previous guesses: ", guesses, "\n"
        end
        if hintflag
            print "Hint: ", hint, "\n"
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
        if guess.matches?(/1/)
            hintflag = true
        elsif guess.matches?(/2/)
            puts "Guess the entire word: "
            word = gets.not_nil!
            # if word.matches?(/secret_word/)
            if word == secret_word
                system "clear"
                puts "Correct! Great job!"
                startMenu()
            else
                system "clear"
                puts "Incorrect... :( Better luck next time!"
                print "The word was ", secret_word, "\n"
                startMenu()
            end
        elsif guess.matches?(/0/)
            startMenu()
        end
         
        char = guess.chars
        alpha = ('a'..'z')

        if (alpha.includes? char[0])
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
        else 
            previousGuess = true
        end
    end
end
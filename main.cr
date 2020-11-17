require "colorize"

checkHiScores
startMenu

def checkHiScores()
    if (!File.exists?("hiscores.txt"))
        File.new("hiscores.txt", "w")
    else return;
    end
end

def printHiScores()
    hiscores = File.read_lines("hiscores.txt")
    scoreArray = [] of Array(String)
    hiscores.each do |el|
        split = el.split(/, /)
        scoreArray.push(split)
    end
    sorted = scoreArray.sort_by! { |array| array[-1].to_i }

    puts " _   _ _       _       _____                         ".colorize(:cyan)
    puts "| | | (_)     | |     /  ___|                        ".colorize(:cyan)
    puts "| |_| |_  __ _| |__   \\ `--.  ___ ___  _ __ ___  ___ ".colorize(:cyan)
    puts "|  _  | |/ _` | '_ \\   `--. \\/ __/ _ \\| '__/ _ \\/ __|".colorize(:cyan)
    puts "| | | | | (_| | | | | /\\__/ / (_| (_) | | |  __/\\__ \\".colorize(:cyan)
    puts "\\_| |_/_|\\__, |_| |_| \\____/ \\___\\___/|_|  \\___||___/".colorize(:cyan)
    puts "          __/ |                                      ".colorize(:cyan)
    puts "         |___/                                       ".colorize(:cyan)

    puts "\v"+"#{"Word".ljust(25).colorize.fore(:yellow)}"+"#{"Player".ljust(25).colorize.fore(:yellow)}" + "#{"Score".ljust(25).colorize.fore(:yellow)}"+"\v"

    sorted.each do |entry|
            puts "#{entry[0].ljust(25).colorize(Colorize::ColorRGB.new(238,130,238))}"+"#{entry[1].ljust(25).colorize(Colorize::ColorRGB.new(238,130,238))}"+"#{entry[2].colorize(Colorize::ColorRGB.new(238,130,238))}"
        
    end

    puts "
          ╔═══════════════════════════╗
          ║          Options          ║
          ║   Press 1 for Main Menu   ║
          ║      Press 0 to Quit      ║
          ╚═══════════════════════════╝".colorize.fore(:yellow)
    input = gets.not_nil!
    if input.matches?(/1/)
        startMenu()
    elsif input.matches?(/0/)
        exit
    end
    
end

def startMenu()
hangman1 = "
 _    _                       __  __".colorize(:red)
hangman2 = "           
| |  | |                     |  \\/  |".colorize(Colorize::ColorRGB.new(255, 69, 0))  

hangman3 ="           
| |__| |  __ _  _ __    __ _ | \\  / |  __ _  _ __".colorize(:yellow)

hangman4 ="           
|  __  | / _` || '_ \\  / _` || |\\/| | / _` || '_ \\ ".colorize(:green)

hangman5 ="           
| |  | || (_| || | | || (_| || |  | || (_| || | | |".colorize(:blue)

hangman6 ="           
|_|  |_| \\__,_||_| |_| \\__, ||_|  |_| \\__,_||_| |_|".colorize(:cyan)

hangman7 ="           
                        __/ |".colorize(Colorize::ColorRGB.new(75,0,130))
hangman8 ="           
                       |___/".colorize(Colorize::ColorRGB.new(238,130,238))       
                 
    print hangman1,hangman2,hangman3,hangman4,hangman5,hangman6,hangman7,hangman8,
    
    fanciness = "

      ╔═══════════════════════════════════╗
      ║            Welcome to             ║
      ║     Computer Science Hangman!     ║
      ║    Press 1 to start a new game    ║
      ║   Press 2 to display High Scores  ║
      ║         Press 0 to quit           ║
      ╚═══════════════════════════════════╝
    
    ".colorize.fore(:yellow)

    input = gets.not_nil!
    if input.matches?(/1/)
        game
    elsif input.matches?(/2/)
        printHiScores
    elsif input.matches?(/0/)
        exit
    end
end

def specifyWordbank()
    optionMenu = "
    ╔═══════════════════════════╗
    ║      Wordbank options     ║
    ║   Press 1 to use default  ║
    ║   Press 2 to specify file ║
    ╚═══════════════════════════╝
".colorize.fore(:yellow)
system "clear"
puts optionMenu
option = gets.not_nil!
if option.matches?(/1/)
    wordbank_file = "wordbank.txt"
    hint_file = "hints.txt"
elsif option.matches?(/2/)
    puts "Please enter wordbank filepath:"
    wordbank_file = gets.not_nil!
    puts "Please enter hints filepath:"
    hint_file = gets.not_nil!
end
{wordbank_file, hint_file}
end

def print_display(word)
    word.each do |letter|
        print letter.colorize.fore(:yellow)
        print ' '.colorize
    end
    print '\n'.colorize 
end

def getHiScoreData(word,score)
    puts "Your score: #{score}".colorize.fore(:yellow)
    puts "Enter name for High Scores: ".colorize.fore(:yellow)
    name = gets.not_nil!
    data = word + ", " + name + ", "+ score.to_s+ "\n"
    File.write("hiscores.txt", data, mode: "a")
end
def game() 
filepaths = specifyWordbank()
wordbank_file = filepaths[0].not_nil!
hint_file = filepaths[1].not_nil!
gameMenu = "
    ╔══════════════════════════╗
    ║   Press 1 get hint       ║
    ║   Press 2 to guess word  ║
    ║   Press 0 to end game    ║
    ╚══════════════════════════╝
    *Using a hint will add +1 to your score.
".colorize.fore(:yellow)

wordbank = File.read_lines(wordbank_file)
hintBank = File.read_lines(hint_file)
fileIndex = Random.rand(wordbank.size)
secret_word = wordbank[fileIndex]
hint = hintBank[fileIndex]

hangman_art = ["
 +---+
 |   |
     |
     |
     |
     |
=========
".colorize.fore(:green), "
 +---+
 |   |
 O   |
     |
     |
     |
=========".colorize.fore(:green), "
 +---+
 |   |
 O   |
 |   |
     |
     |
=========".colorize.fore(:green) , "
 +---+
 |   |
 O   |
/|   |
     |
     |
=========".colorize.fore(:green) , "
 +---+
 |   |
 O   |
/|\\  |
     |
     |
=========".colorize.fore(:green) , "
 +---+
 |   |
 O   |
/|\\  |
/    |
     |
=========".colorize.fore(:green) , "
 +---+          
 |   |
 O   |
/|\\  |
/ \\  |
     |
=========".colorize.fore(:green) ]


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
    hintflagscore = false
    hint
    score = 0

    
    while playing
        
        system "clear"
        if hintflagscore
            score = score + 1
            hintflagscore = false

        end
        puts gameMenu
        puts "Score: #{score}"
        puts hangman_art[incorrect]
        
        if guesses != ""
            print "Previous guesses: ", guesses.colorize.fore(:yellow)
            print "\n"
        end
        
        if hintflag
            print "Hint: ", hint.colorize.fore(:yellow) 
            print "\n"
        end
        
        print_display(display)
        if previousGuess
            puts "\nPlease enter a letter: "
        else
            puts "Letter has already been entered, please enter a different letter.".colorize.fore(:yellow)
        end
       
        flag = true
        guess = ""
        while flag
            guess = gets.not_nil!        
            if guess.bytesize > 1
                puts "Please enter a single letter: ".colorize.fore(:yellow)
                flag = true
            else flag = false 
            end
        end
        if guess.matches?(/1/)
            hintflag = true
            hintflagscore = true
        elsif guess.matches?(/2/)
            puts "Guess the entire word: ".colorize.fore(:yellow)
            word = gets.not_nil!
            # if word.matches?(/secret_word/)
            if word == secret_word
                system "clear"
                puts "Correct! Great job!".colorize.fore(:yellow)
                getHiScoreData(secret_word, score)
                startMenu()
            else
                system "clear"
                puts "Incorrect... :( Better luck next time!".colorize.fore(:yellow)
                print "The word was ", secret_word.colorize.fore(:yellow)
                print "\n"
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
                score += 1
                previousGuess = true
                if key.index(guess) == nil
                    incorrect += 1
                    if incorrect == 6
                        playing = false
                        system "clear"
                        puts hangman_art[incorrect]
                        print_display(display)
                        print "Game Over... The word was ", secret_word.colorize.fore(:yellow)
                        print "\n"
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
                        print_display(display)
                        puts "Winner!".colorize.fore(:yellow)
                        getHiScoreData(secret_word, score)
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
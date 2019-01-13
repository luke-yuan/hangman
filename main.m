file = input("Please input the file with all the student names: ", 's');

% ask for the file containing all words until a valid file is
% entered

while ~exist(file, 'file') || ~(endsWith(file, ".xlsx"))
    disp("Please enter a valid file name!");
    file = input("Please input the file with all the student names: ", 's');
end

[~, easy] = xlsread(file, "Easy");
[~, medium] = xlsread(file, "Medium");
[~, hard] = xlsread(file, "Hard");

playAgain = 1;

players = input("1 player or 2? ", 's');
while (players ~= '1' && players ~= '2')
    players = input("1 player or 2? ", 's');
end

load scoreboard.mat

while (playAgain)
    
    s = input("Difficulty? (e)asy, (m)edium, (h)ard ", 's');
    
    while (s ~= 'e' && s ~= 'm' && s ~= 'h')
        s = input("Difficulty? (e)asy, (m)edium, (h)ard ", 's');
    end
    
    % choose a random word based on difficulty
    if (s == 'e')
        word = char(easy(randi(length(easy))));
    elseif (s == 'm')
        word = char(medium(randi(length(medium))));
    else
        word = char(hard(randi(length(hard))));
    end
    
    if (players == '1')
        guessedLetters = zeros(26);
        wrongGuesses = 0;
        
        while (~guessed(word, guessedLetters) && wrongGuesses < 6)
            displayGameState(wrongGuesses);
            displayWordState(word, guessedLetters);
            
            guess = input("Enter a guess: ", 's');
            while (~validGuess(guess))
                disp("Please enter a valid guess!");
                guess = input("Enter a guess: ", 's');
            end
            
            guessedLetters(lower(guess) - 'a' + 1) = 1;
            
            if (~correctGuess(guess, word))
                disp("Wrong guess!");
                wrongGuesses = wrongGuesses + 1;
            end
            
        end
        
        if (wrongGuesses < 6) % user guessed word correctly
            disp("You got it!");
            scoreboard = updateScoreboard(100.0 * (1.0 - wrongGuesses / length(word)), scoreboard);
        end
        
        disp("Correct word is: " + word);
        
    else
        guessedLetters = zeros(2, 26);
        wrongGuesses = zeros(1, 2);
        
        while (~guessed(word, guessedLetters(1, :)) && ~guessed(word, guessedLetters(2, :)) && wrongGuesses(1) < 6 && wrongGuesses(2) < 6)
            
            for i = 1:2 % alternate between the two players
                clc;
                disp(strcat("Player ", int2str(i), "'s turn"));
                displayGameState(wrongGuesses(i));
                
                displayWordState(word, guessedLetters(i, :));
                
                guess = input("Enter a guess: ", 's');
                while (~validGuess(guess))
                    disp("Please enter a valid guess!");
                    guess = input("Enter a guess: ", 's');
                end
                guessedLetters(i, lower(guess) - 'a' + 1) = 1;
                
                % if the guess is correct, display the updated word,
                % otherwise, display game status
                
                if (~correctGuess(guess, word))
                    disp("Wrong guess!");
                    wrongGuesses(i) = wrongGuesses(i) + 1;
                    displayGameState(wrongGuesses(i));
                else
                    displayWordState(word, guessedLetters(i, :));
                end
                
                % this is to help the player see the updated state
                disp("Enter any key to continue...");
                pause;
            end
        end
        
        for i = 1:2
            if (wrongGuesses(i) < 6) % player guessed word correctly
                scoreboard = updateScoreboard(100.0 * (1.0 - wrongGuesses(i) / length(word)), scoreboard);
            end
        end
        
        if ((guessed(word, guessedLetters(1, :)) && guessed(word, guessedLetters(2, :))) || (wrongGuesses(1) == 6 && wrongGuesses(2) == 6))
            disp("It's a tie!");
        elseif (guessed(word, guessedLetters(1, :)) || gameover(2))
            disp("Player 1 won!");
        else
            disp("Player 2 won!");
        end
        
    end
    
    disp("Scoreboard: ");
    disp(scoreboard);
    
    s = input("Want to play again? y/n ", 's');
    while (s ~= 'y' && s ~= 'n')
        s = input("Want to play again? y/n ", 's');
    end
    
    playAgain = s == 'y';
end

save('scoreboard.mat', 'scoreboard');
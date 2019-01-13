function correct = correctGuess(letter, word)
    correct = 0;
    for i=1:length(word)
        if (letter == word(i))
            correct = 1;
        end
    end
end


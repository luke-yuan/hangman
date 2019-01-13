function result = guessed(word, letters)
    result = 1;
    
    for i=1:length(word)
        if (~letters(word(i) - 'a' + 1))
            result = 0;
        end
    end
end

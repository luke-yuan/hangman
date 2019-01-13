function displayWordState(word, guessedLetters)
% guessedLetters: 1st element 'a'

dispStr = "";
for i=1:length(word)
    if (guessedLetters(word(i) - 'a' + 1))
        dispStr = dispStr + word(i);
    else
        dispStr = dispStr + "_";
    end
    dispStr = dispStr + " ";
end

disp(dispStr);

end



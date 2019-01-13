function displayGameState(wrongGuesses)

    states = ["head" "body" "right arm" "left arm" "right leg"];
    
    if (wrongGuesses == 0)
        disp("start")
    elseif (wrongGuesses == 6)
        disp("game over")
    else
        dispStr = "";
        for i=1:wrongGuesses - 1
            dispStr = dispStr + states(i) + ", ";
        end
        dispStr = dispStr + states(wrongGuesses);
        disp(dispStr)
    end
end


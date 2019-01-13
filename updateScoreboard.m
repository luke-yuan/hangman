function newBoard = updateScoreboard(score, scoreboard)
    newBoard = zeros(5);
    if score >= scoreboard(length(scoreboard))
        for i=1:length(scoreboard)
            if score >= scoreboard(i)
                newBoard = [scoreboard(1:i-1) score scoreboard(i:5)];
                return
            end
        end
    else
        newBoard = scoreboard;
    end
    
end


function valid = validGuess(input)
    valid = length(input) == 1 && lower(input) >= 'a' && lower(input) <= 'z';
end


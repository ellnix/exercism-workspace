def score(word):
    sum = 0

    for c in word.upper():
        if c in ["D", "G"]:
            sum += 2
        elif c in ["B", "C", "M", "P"]:
            sum += 3
        elif c in ["F", "H", "V", "W", "Y"]:
            sum += 4
        elif c == "K":
            sum += 5
        elif c in ["J", "X"]:
            sum += 8
        elif c in ["Q", "Z"]:
            sum += 10
        else:
            sum += 1

    return sum

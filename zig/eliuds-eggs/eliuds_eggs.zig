pub fn eggCount(number: usize) usize {
    var eggs: usize = 0;

    var bit: usize = 1;
    while (bit > 0) : (bit <<= 1) {
        if (number & bit > 0)
            eggs += 1;
    }

    return eggs;
}

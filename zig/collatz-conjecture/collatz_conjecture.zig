pub const ComputationError = error {
    IllegalArgument
};

pub fn steps(number: usize) anyerror!usize {
    if (number < 1)
        return ComputationError.IllegalArgument;

    if (number == 1) 
        return 0;

    return 1 + try steps(if (number % 2 == 0) number / 2 else number * 3 + 1);
}

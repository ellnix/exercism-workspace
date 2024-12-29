pub fn squareOfSum(number: usize) usize {
    const num_float: f32 = @floatFromInt(number);
    const sum: usize = @intFromFloat(num_float / 2.0 * (num_float + 1.0));
    return sum * sum;
}

pub fn sumOfSquares(number: usize) usize {
    return number * (number + 1) * (2 * number + 1) / 6;
}

pub fn differenceOfSquares(number: usize) usize {
    return squareOfSum(number) - sumOfSquares(number);
}

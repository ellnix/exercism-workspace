const std = @import("std");

pub fn squareOfSum(number: usize) usize {
    const n: usize = (number + 1) * number / 2;
    return n * n;
}

pub fn sumOfSquares(number: usize) usize {
    return number * (number + 1) * (2 * number + 1) / 6;
}

pub fn differenceOfSquares(number: usize) usize {
    return squareOfSum(number) - sumOfSquares(number);
}

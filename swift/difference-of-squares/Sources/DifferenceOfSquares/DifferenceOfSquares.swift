import Foundation

class Squares {
    var n: Int
    var squareOfSum: Decimal
    var sumOfSquares: Decimal
    var differenceOfSquares: Decimal

    init(_ input: Int) {
        n = input
        squareOfSum = pow(Decimal(n * (n + 1)) / 2, 2)
        sumOfSquares = Decimal(n * (n + 1) * (2*n + 1) / 6)
        differenceOfSquares = squareOfSum - sumOfSquares
    }
}

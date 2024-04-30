(module
  ;;
  ;; Calculate the square of the sum of the first N natural numbers
  ;;
  ;; @param {i32} max - The upper bound (inclusive) of natural numbers to consider
  ;;
  ;; @returns {i32} The square of the sum of the first N natural numbers
  ;;
  (func $squareOfSum (export "squareOfSum") (param $max i32) (result i32)
    (local $sum i32)

    (f64.mul
      (f64.div (f64.convert_i32_s (local.get $max)) (f64.const 2))
      (f64.convert_i32_s (i32.add (local.get $max) (i32.const 1)))
    )

    i32.trunc_f64_s 
    local.set $sum

    local.get $sum
    local.get $sum

    i32.mul
  )

  ;;
  ;; Calculate the sum of the squares of the first N natural numbers
  ;;
  ;; @param {i32} max - The upper bound (inclusive) of natural numbers to consider
  ;;
  ;; @returns {i32} The sum of the squares of the first N natural numbers
  ;;
  (func $sumOfSquares (export "sumOfSquares") (param $max i32) (result i32)
    (i32.div_u
      (i32.mul
        (i32.mul
          (local.get $max)
          (i32.add (local.get $max) (i32.const 1))
        )
        (i32.add (i32.mul (local.get $max) (i32.const 2)) (i32.const 1))
      )
      (i32.const 6)
    )
  )

  ;;
  ;; Calculate the difference between the square of the sum and the sum of the 
  ;; squares of the first N natural numbers.
  ;;
  ;; @param {i32} max - The upper bound (inclusive) of natural numbers to consider
  ;;
  ;; @returns {i32} Difference between the square of the sum and the sum of the
  ;;                squares of the first N natural numbers.
  ;;
  (func (export "difference") (param $max i32) (result i32)
    (i32.sub (call $squareOfSum (local.get $max)) (call $sumOfSquares (local.get $max)))
  )
)

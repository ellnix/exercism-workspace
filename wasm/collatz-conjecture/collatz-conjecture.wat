(module
  (func $collatz_steps(export "steps") (param $n i32) (result i32)
  (local $additional_steps i32)
    (if (i32.lt_s (local.get $n) (i32.const 1))
      (then (return (i32.const -1))))

    (if (result i32)(i32.eq (local.get $n) (i32.const 1))
    (then
      (i32.const 0)
    )
    (else
      (if (i32.eq (i32.rem_u (local.get $n) (i32.const 2)) (i32.const 0))
      (then
        (call $collatz_steps (i32.div_u (local.get $n) (i32.const 2)))
        local.set $additional_steps
      )
      (else
        (call $collatz_steps (i32.add (i32.const 1) (i32.mul (local.get $n) (i32.const 3))))
        local.set $additional_steps
      ))

      (i32.add (local.get $additional_steps) (i32.const 1))
    ))
  )
)

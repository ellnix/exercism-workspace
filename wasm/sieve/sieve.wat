(module
  (memory (export "mem") 1)

  (func $store_all_numbers (param $limit i32)
    (local $ptr i32)
    (local $n i32)

    (local.set $n (i32.const 1))

    (if (i32.lt_u (local.get $n) (local.get $limit))
      (then
        (loop $write_num
          (i32.store (local.get $ptr) (local.get $n))

          (local.set $ptr (i32.add (local.get $ptr) (i32.const 4)))
          (local.set $n (i32.add (local.get $n) (i32.const 1)))
          (if (i32.le_u (local.get $n) (local.get $limit))
            (then (br $write_num))
          )
        )
      )
    )
  )

  (func $sieve (param $limit i32)
    (local $outer_ptr i32)
    (local $prime i32)
    (local $multiple i32)

    (local.set $outer_ptr (i32.const 4)) ;; skip 1

    (loop $each_prime

      (block $already_filtered
        (local.set $prime (i32.load (local.get $outer_ptr)))

        (if (i32.le_s (local.get $prime) (i32.const 0))
          (then (br $already_filtered)))
        
        ;; $multiple points to positions, so multiples of 2: 4, 6, 8
        ;; are in positions 1, 3, 5 since in this solution memory is 0-indexed
        (local.set $multiple (i32.sub (local.get $prime) (i32.const 1)))
        (loop $sieve
          (local.set $multiple (i32.add (local.get $multiple) (local.get $prime)))

          (i32.store (i32.mul (local.get $multiple) (i32.const 4)) (i32.const -1))

          (if (i32.lt_u (local.get $multiple) (local.get $limit))
            (then (br $sieve))
          )
        )
      )


      (local.set $outer_ptr (i32.add (local.get $outer_ptr) (i32.const 4)))
      (if (i32.lt_u (local.get $outer_ptr) (i32.mul (local.get $limit) (i32.const 4)))
        (then (br $each_prime))
      )
    )
  )

  (func $compact (param $limit i32) (result i32)
    (local $len i32)
    (local $outer_ptr i32)
    (local $inner_ptr i32)
    (local $value i32)
    (local $peek i32)

    (local.set $outer_ptr (i32.const 4))

    (block $no_more_numbers
      (loop $each_num

        (local.set $value (i32.load (local.get $outer_ptr)))

        (if (i32.le_s (local.get $value) (i32.const 0))
          (then 
            (local.set $inner_ptr (local.get $outer_ptr))
            (loop $look_for_value
              (local.set $peek (i32.load (local.get $inner_ptr)))

              (if (i32.gt_s (local.get $peek) (i32.const 0))
                (then
                  (i32.store (local.get $inner_ptr) (i32.const -1))
                  (i32.store (local.get $outer_ptr) (local.get $peek))
                )
                (else
                  (if (i32.ge_u (local.get $inner_ptr) (i32.mul (local.get $limit) (i32.const 4)))
                    (then (br $no_more_numbers))
                    (else 
                      (local.set $inner_ptr (i32.add (local.get $inner_ptr) (i32.const 4)))
                      (br $look_for_value)
                    )
                  )
                )
              )

            )
          )
        )

        (local.set $len (i32.add (local.get $len) (i32.const 1)))


        (local.set $outer_ptr (i32.add (local.get $outer_ptr) (i32.const 4)))
        (if (i32.lt_u (local.get $outer_ptr) (i32.mul (local.get $limit) (i32.const 4)))
          (then (br $each_num))
        )
      )
    )

    (local.get $len)
  )

  ;;
  ;; Determine all the prime numbers below a given limit.
  ;; Return the offset and length of the resulting array of primes.
  ;;
  ;; @param {i32} limit - the upper bound for the prime numbers
  ;;
  ;; @return {i32} - offset off the u32[] array
  ;; @return {i32} - length off the u32[] array in elements
  ;;
  (func (export "primes") (param $limit i32) (result i32 i32)
    (call $store_all_numbers (local.get $limit))
    (call $sieve (local.get $limit))
    (return (i32.const 4) (call $compact (local.get $limit)))
  )
)

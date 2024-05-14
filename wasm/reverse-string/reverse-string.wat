(module
  (memory (export "mem") 1)
 
  ;;
  ;; Reverse a string
  ;;
  ;; @param {i32} offset - The offset of the input string in linear memory
  ;; @param {i32} length - The length of the input string in linear memory
  ;;
  ;; @returns {(i32,i32)} - The offset and length of the reversed string in linear memory
  ;;
  (func (export "reverseString") (param $offset i32) (param $length i32) (result i32 i32)
    (local $temp i32)
    (local $i i32)
    (local $midpoint i32)
    (local $left_pos i32)
    (local $right_pos i32)

    (local.set $midpoint (i32.div_u (local.get $length) (i32.const 2)))

    (loop $reverse_loop
      (local.set $left_pos (i32.add (local.get $offset) (local.get $i)))
      (local.set $right_pos (i32.add (i32.sub (i32.sub (local.get $length) (i32.const 1)) (local.get $i)) (local.get $offset)))

      (local.set $temp (i32.load8_u (local.get $left_pos)))
      
      (i32.store8 (local.get $left_pos) (i32.load8_u (local.get $right_pos)))
      (i32.store8 (local.get $right_pos) (local.get $temp))

      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (if (i32.lt_s (local.get $i) (local.get $midpoint)) (then (br $reverse_loop)))
    )

    (return (local.get $offset) (local.get $length))
  )
)

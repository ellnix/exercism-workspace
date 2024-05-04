(module
  ;;
  ;; Score a dart throw based on its coordinates.
  ;;
  ;; @param {f32} x - The x coordinate of the dart.
  ;; @param {f32} y - The y coordinate of the dart.
  ;;
  ;; @returns {i32} - The score of the dart throw (10, 5, 1, or 0).
  ;;
  (func (export "score") (param $x f32) (param $y f32) (result i32)
    (local $distance f32)
    (local $score i32)

    (local.set $distance 
      (f32.add
        (f32.mul (local.get $x) (local.get $x))
        (f32.mul (local.get $y) (local.get $y))
      )
    )

    (local.set $score (i32.const 0))
    (block $score_set
      (f32.le (local.get $distance) (f32.const 1))

      if
        (local.set $score (i32.const 10))
        (br $score_set)
      end

      (f32.le (local.get $distance) (f32.const 25))

      if
        (local.set $score (i32.const 5))
        (br $score_set)
      end

      (f32.le (local.get $distance) (f32.const 100))

      if
        (local.set $score (i32.const 1))
        (br $score_set)
      end
    )

    local.get $score
  )
)

#[macro_export]
macro_rules! hashmap {
    ( $( $k:expr => $v:expr ),* ) => {
        {
            let mut map = ::std::collections::HashMap::new();

            $(
                map.insert($k, $v);
            )*

            map
        }
    };

    ( $( $k:expr => $v:expr, )+ ) => {
        {
            $crate::hashmap!($($k => $v),*)
        }
    };
}

use itertools::iproduct;

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    let col_size = minefield.len();
    let row_size = minefield.get(0).unwrap_or(&"").len();
    let mut buffer: Vec<Vec<u8>> = (0..col_size).map(|_| vec![b'0'].repeat(row_size)).collect();

    for (y, row) in minefield.iter().enumerate() {
        for (x, cell) in row.bytes().enumerate() {
            if cell == b'*' {
                buffer[y][x] = b'*';

                let mut valid_ys = vec![y];
                if y > 0 { valid_ys.push(y - 1) }
                if y + 1 < col_size { valid_ys.push(y + 1) }

                let mut valid_xs = vec![x];
                if x > 0 { valid_xs.push(x - 1) }
                if x + 1 < row_size { valid_xs.push(x + 1) }

                for (neighbor_y, neighbor_x) in iproduct!(valid_ys, valid_xs) {
                    if buffer[neighbor_y][neighbor_x] != b'*' {
                        buffer[neighbor_y][neighbor_x] += 1
                    }
                }
            }

        }
    };

    buffer.iter().map(|list| 
        list.iter().map(|byte| if *byte == b'0' { ' ' } else { char::from(*byte) }).collect()
    ).collect()
}

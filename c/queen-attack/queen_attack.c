#include "queen_attack.h"
#include <stdlib.h>
#include <stdbool.h>

bool invalid_positions(position_t queen_1, position_t queen_2);

attack_status_t can_attack(position_t queen_1, position_t queen_2) {
  if (invalid_positions(queen_1, queen_2))
    return INVALID_POSITION;

  int row_dist = abs(queen_1.row - queen_2.row);
  int col_dist = abs(queen_1.column - queen_2.column);

  if (row_dist == 0 || col_dist == 0 || col_dist == row_dist)
    return CAN_ATTACK;
  else
    return CAN_NOT_ATTACK;
}

bool invalid_positions(position_t queen_1, position_t queen_2) {
  return queen_1.row >= 8 || queen_1.column >= 8 || 
         queen_2.row >= 8 || queen_2.column >= 8 ||
         (queen_1.row == queen_2.row && queen_1.column == queen_2.column);
}

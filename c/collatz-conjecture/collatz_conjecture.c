#include "collatz_conjecture.h"

int steps(int start) {
  if (start < 1)
    return ERROR_VALUE;

  int steps;

  for(steps = 0; start > 1; steps++)
    if (start & 1)
      start = start * 3 + 1;
    else
      start >>= 1;

  return steps;
}

#include "resistor_color.h"
#include <stdlib.h>

int color_code(resistor_band_t color) { return color; }

const resistor_band_t *colors() {
  resistor_band_t *colors = malloc(COLOR_COUNT);

  for(int i = 0; i < COLOR_COUNT; i++)
    colors[i] = (resistor_band_t)i;

  return colors;
}

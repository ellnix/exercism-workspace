raindrops <- function(number) {
  pling <- if (number %% 3 == 0) "Pling" else ""
  plang <- if (number %% 5 == 0) "Plang" else ""
  plong <- if (number %% 7 == 0) "Plong" else ""

  sound <- paste(pling, plang, plong, sep = "")
  if (sound == "") paste(number) else sound
}

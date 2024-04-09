import std/algorithm

proc reverse*(s: string): string =
  var set = cast[seq[char]](s)
  set.reverse
  cast[string](set)


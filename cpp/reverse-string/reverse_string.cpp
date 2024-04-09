#include "reverse_string.h"
#include <string>

using namespace std;

namespace reverse_string {

string reverse_string(string input) 
{
  string new_string;
  new_string.resize(input.length());

  for(unsigned long int i = 0; i < input.length(); i++) {
    new_string[i] = input[input.length() - 1 - i];
  }

  return new_string;
}

}  // namespace reverse_string

# let idx = 0;

# fn whitespace() {

# }

# fn main()  {

# }
import json

def entry(myjson):
  try:
    json.loads(myjson)
  except ValueError as e:
    return False
  return True

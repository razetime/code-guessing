class Entry:
  def __init__(self):
	self.keys = []
	self.values = []
  
  def get(self, key, default=None):
	for i in range(len(self.keys)):
	  if len(str(self.keys[i])) == len(str(key)):
		if self.keys[i] == key:
		  return self.values[i]
	return default
  
  def insert(self, key, value):
	if key in self.keys:
	  self.values[self.keys.index(key)] = value
	else:
	  self.keys.append(key)
	  self.values.append(value)

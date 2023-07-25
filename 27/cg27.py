import re
def entry(terrain):
	str = ''
	for i in range(max(terrain)):
		for j in range(len(terrain)):
			if i < terrain[j]:
				str += '#'
			else:
				str += ' '
		str += '\n'
	collected,_ = re.subn('# +#', lambda match: match.group(0).replace(' ','@'), str)
	return collected.count('@')

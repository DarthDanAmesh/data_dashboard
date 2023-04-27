import csv, os

#search present directory (.)
for root in os.walk('.'):
    for dir in root:
    	for files in dir:
    		pass
    pass
#print(repr(dir))

excelTypes = ['.csv','.xls','.xlsx']
emptyFile= []

#retreive file names which are not arrays
for file in dir:
	if file.lower().endswith('.csv') or file.lower().endswith('.xls') or file.lower().endswith('.xlsx'):
		emptyFile.append(file)
		for item in emptyFile:
			target = os.path.splitext(item)[0]
			print(target)
			if target == 'Jobs Application Details-Report':
				print('yes')
			else:
				print('no')
				print(target)

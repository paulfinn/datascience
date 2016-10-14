

myreadfile = open('Auto.csv', 'r')
print (myreadfile)

myfiledata = myreadfile.readlines()
print len(myfiledata)

for line in range (len(myfiledata)):
    print str(line) + ':' + myfiledata[line]


myreadfile.close()


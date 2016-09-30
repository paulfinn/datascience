import numbers

while 1==1:

    eurInput = raw_input("Please input the euro amount: ")


    try:
        eurOutput = float(eurInput) * 100
        print(str(eurInput) + ' Euro is ' + str(eurOutput) + ' in EuroCents')
        break
    except:
        print "Sorry, I you didnt enter a proper number"

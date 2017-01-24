#Fibonacci
#Thanks to https://www.mathsisfun.com/numbers/fibonacci-sequence.html
#1.618034 is the "Golden Ratio" in maths - crops up a lot in maths & biology and in the fibonacci sequence

#I want to do a square root later so will need math functions
import math

n = int(raw_input('Enter the position in the Fibonacci Sequence you would like to know: '))

fib = 0
if n <0:
    
    print("Sorry, the Fibonacci Sequence doesn't work for negative numbers.")
else:
    fib = (((1.618034**n)-((1-1.618034)**n))/ math.sqrt(5))
    print ('The value of position ', n, ' in the Fibonacci Sequence is: ', int(fib))
    

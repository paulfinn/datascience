### FIBONACCI

s = int(input("What number of Fibonacci Sequence do you want to know? "))

f0 = 0
f1 = 1
finalFib = 0
PreFibNumber = f1
Pre2FibNumber = f0

if s < 0:
    print('No Fibonacci Number Sequence for negative Numbers')

elif s == f0:
    print('Position Zero Number in Fibonacci Sequence is 0')

elif s == f1:
    print('First Position Number in Fibonacci Sequence is 1') 

else:
    for x in range(1,s,1) :
        finalFib = PreFibNumber + Pre2FibNumber
        Pre2FibNumber = PreFibNumber
        PreFibNumber = finalFib

print(" Fibonacci number for ",s," position of the sequence is ",finalFib)

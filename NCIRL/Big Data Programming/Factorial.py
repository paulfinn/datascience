#-------------------------------------------------------------------------------
# Name:        module2
# Purpose:
#
# Author:      finnp
#
# Created:     07/10/2016
# Copyright:   (c) finnp 2016
# Licence:     <your licence>
#-------------------------------------------------------------------------------

def sumfact(number):
    sumfact = 0
    for i in range (1, number +1):
        sumfact=sumfact + i
    return sumfact

def factorial(number):
    result = 1
    for i in range (1, number+1):
        result = result * i
    return result

def factorial2(number):
    product = 1
    for i in range(number):
        product = product * (i+1)
    return product


def combin(set, selection):
    #Combinatorial Probability from Thursday 6th OCt
    # P(Event) = N!/n!(N-n)!
    return (factorial(set)/(factorial(selection)* factorial(set - selection)))


print (sumfact(6))
print(factorial(6))
print(combin(6,2))
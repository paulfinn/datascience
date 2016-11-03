#0 define functions

#define a function to calculate a triangular number
def triangular(n):
	#set up a variable to count up for the while loop
	counter = 1

	#set up a variable to hold the value of triangular number
	total = 0

	#while the counter is less than the number input
	while (counter <= n):
		#increase the total by the value of the counter
		total = total + counter

		#increment the counter
		counter = counter + 1

	#Return the value for the triangular number calculated
	return (total)


#1 take input
#ask the user for a value for n
input_target = raw_input("Please input the number you want to add the sum of all numbers up to")

#2 convert input
#n should be an integer
int_target=int(input_target)

#3 perform calculations
#invoke the triangular function
int_result=triangular(int_target)

#4 prepare output
string_result=str(int_result)

#5 produce outputs
print(string_result)
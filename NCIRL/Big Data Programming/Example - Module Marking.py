

#PA1 = raw_input("Enter Result for PA1: ")
#PA2 = raw_input("Enter Result for PA2: ")
#PA3 = raw_input("Enter Result for PA3: ")
#PA4 = raw_input("Enter Result for PA4: ")
#PR1 = raw_input("Enter Result for PR1: ")

#grade = float(PA1)+ float(PA2) + float(PA3) + float(PA4) + float(PR1)

list_scores = [[PA1, "Assignment 1"],[PA1, "Assignment 2"],[PA1, "Assignment 3"],[PA4, "Assignment 4"],[PR, "Project"]]
for score in list_scores:
      prompt_string = score[0] + "= raw_input('Enter the score for " + score[1] + ": ')"
      print(prompt_string)
     
#if (grade > 40.00):
#    print("Great!, You passed")
#else:
#    print("You're a failure!")
    

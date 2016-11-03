

def removePunc(s):
    puncChars =':;!?,.'
    result = ''
    for c in s:
        if c not in puncChars:
            result=result+c
    return result


r= removePunc('This question, confused as it is, asks the following question: Why?!')
print r


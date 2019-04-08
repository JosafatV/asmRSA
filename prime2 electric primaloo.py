def main ():
    pS = [2]
    num = 3

    for i in range (1, 10000):
        if (testNum(num, pS)):
            num += 2
        else:
            pS.append(num)
            num += 2
    print (pS)

        
def testNum (num, pS):
    for j in range (0, len(pS)): # known primes
        if (num%pS[j] == 0):
            return 1 #not Prime
    return 0 # is Prim

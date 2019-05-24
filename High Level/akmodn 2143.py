# Insituto Tecnologico de Costa Rica
# Ingenieria en computadores
#
# Handbook of Applied Cryptography by A. Menezes, P. van Oorschot and S. Vanstone.
# Page 71. 2.143 Algorithm: Repeated square-and-multiply algorithm for exponentiation in Zn
#
# 24 de Mayo, 2019


# Book's algorithm
def akmodn (a, k, n):
    ki = bin (k)[2:]  # we need the binary of k
    t = len(ki)-1     # start with lsb
    b = 1             # output

    # trivial
    if (k == 0): 
        b = 1
        print ("k == 0 -> 1 % n = " + str(b))
        return 0

    # non-trivial
    A = a
    if (ki[t] == '1'):
        b = a
    t -= 1
    while (t>=0):
        A = A * A
        A = A % n
        if (ki[t] == '1'):
            b = A * b
            b = b % n
        t -= 1
    print ("a**k%n = " + str(b))
    return 0



# Expected, based on 2.144 Example
a = 5
k = 596
n = 1234
print ("expected result is: " + str(a**k%n))

akmodn(a, k, n)

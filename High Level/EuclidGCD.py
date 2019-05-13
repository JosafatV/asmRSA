# -*- coding: utf-8 -*-


def gcd(a, b):
    while (a != b):
        if (a > b):
           a -= b; 
        else:
           b -= a; 
    return a
    

def run():
    m = 125877461
    l = 691197
    while (l>1):
        r = gcd(m, l)
        if (r == 1):
            #they are coprime
            return l
        else:
        # they aren't coprime
            l-=1
    

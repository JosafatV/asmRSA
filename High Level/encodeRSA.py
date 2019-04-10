# Instituto Tecnologico de Costa Rica
# Arquitectura de Computadores 1
#
# RSA encryption and decryption
#
# Josafat Vargas
# 21 of March, 2019

from fileCoder import fileManager
from fileCoder import encodeNoFile
from fileCoder import decodeNoFile
import math
import random


# Finds the prime numbers between 2 and n by testing odd numbers against known primes
# n: positive upper limit integer
# returns: a list with all prime numbers in range
def primeList (n):
    allPrimeNumbers = [2]
    num = 3

    for i in range (1, n):
        if (primeListAux(num, allPrimeNumbers)):
            num += 2
        else:
            allPrimeNumbers.append(num)
            num += 2
            
    return allPrimeNumbers

def primeListAux (num, pS):
    for j in range (0, len(pS)): # known primes
        if (num%pS[j] == 0):
            return 1 #not Prime
    return 0 # is Prim

# Selects a random prime number given a list of prime numbers and the length of the list
# primeNumbers: list of prim numbers
# n: length of the list
# return: prime integer
def randomPrime (primeNumbers, lowerLimit, upperLimit):
    randomIndex = random.randint(lowerLimit,upperLimit)
    randomPrime = primeNumbers[randomIndex]
    return randomPrime



# Calculates the private decryptor values
# encryptor: integer with the value of the encryptor
# length: (prime1-1)*(prime2-1)
# return: one of the decryptor values
def getDecryptor (encryptor, length):
    decryptors = []
    findDecryptor = (lambda d: (encryptor*d-1)%length == 0)
    for d in range (1, length-1000000): # 1 < d < phi
        if (findDecryptor(d)):
            decryptors.append(d)
    if (len(decryptors) == 0):
        print ("Error: decryptor not found")
        return -1
    else:
        randomIndex = random.randint(0, len(decryptors)-1)
        #print (decryptors[randomIndex])
        return decryptors[randomIndex]

        
# Codes the data from a text file
# sourceFile: file with the data
# outputFile: file where the RSA encoded data is stored
# return: 0 if succeded, writes the output file
#def encodeRSA (sourceFile, outputFile, maxPrime):
def RSAkeys():
    k = 1024
    encryptor = 65537
    allPrimes = primeList(10000) #at least 10 000 prime numbers.
    
    prime1 = randomPrime(allPrimes, 50, len(allPrimes)/2)
    prime2 = randomPrime(allPrimes, len(allPrimes)/2, len(allPrimes)-1)
    
    while (prime1%encryptor == 1):
        prime1 = randomPrime(allPrimes, 20, 500)
    while (prime2%encryptor == 1):
        prime2 = randomPrime(allPrimes, 500, 900)

    modulus = prime1*prime2
    length = (prime1-1)*(prime2-1)
    decryptor = getDecryptor(encryptor, length)

    if (decryptor<0):
        return 1
    else:
        pukFile = "public key.txt"
        publicKey = str(encryptor) + "," + str(modulus)
        a = fileManager(pukFile, "w", publicKey)

        prkFile = "private key.txt"
        privateKey = str(decryptor) + "," + str(modulus)
        b = fileManager(prkFile, "w", privateKey)

        if (a or b):
            return 1
        else:
            print ("Keys created")
            return 0






# Encrypts the data from a text file
# sourceFile: file with the  original text
# outputFile: file with the data converted to the encrypted data
# return: 0 if succeded, writes the output file
#def RSAencrypt (srcFile, publicFile):
def RSAencrypt ():
    srcFile = "src.txt"
    publicFile = "public key.txt"
    tempFile = "temp.txt"   #can be removed
    outputFile = "out.txt"

    #code the file
    codedData = encodeNoFile(srcFile)
    codedData = int(codedData)
    
    #load keys
    publicKeys = fileManager(publicFile, "r", 0)
    split = publicKeys.index(",")
    txtEncryptor = publicKeys[0:split]
    encryptor = int(txtEncryptor)
    txtModulus = publicKeys[split+1:len(publicKeys)]
    modulus = int(txtModulus)
    
    #encrypt
    if (codedData<modulus):
        cipherText = (codedData**encryptor)%modulus
        status = fileManager(outputFile, "w", str(cipherText))
        if (status):
            print("Error writting file")
            return 1
        else:
            print("Encryption completed - Praise the Omnissiah")
            return 0
    else:
        print("The message is too long")
        return 1
        
    


# Decrypts the data from a text file
# sourceFile: file with the encrypted data
# outputFile: file with the data converted to the original text
# return: 0 if succeded, writes the output file
#def RSAdecrypt (srcFile, privateFile):
def RSAdecrypt ():
    srcFile = "out.txt"
    privateFile = "private key.txt"
    tempFile = "temp.txt"
    outputFile = "dec.txt"

    #load keys
    privateKeys = fileManager(privateFile, "r", 0)
    split = privateKeys.index(",")
    decryptor = privateKeys[0:split]
    decryptor = int(decryptor)
    modulus = privateKeys[split+1:len(privateKeys)]
    modulus = int(modulus)
    
    #encrypt
    c = fileManager(srcFile, "r", 0)
    crypted = int(c)
    print("Starting decryption ...")
    decyphered = crypted**decryptor%modulus
    msg = str(decyphered)
    
    #decode the file
    print("Decoding file ...")
    plainTextMsg = decodeNoFile(msg)
    status = fileManager(outputFile, "w", str(plainTextMsg))
    if (status):
        print("Error writting file")
        return 1
    else:
        print("Decryption completed - Praise the Omnissiah")
        return 0






























    
    

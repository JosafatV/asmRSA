# Instituto Tecnologico de Costa Rica
# Arquitectura de Computadores 1
#
# String to int coding/decoding
#
# Josafat Vargas
# 21 of March, 2019


# Manages the access and operaions in the external file
# fileName: file to be accessed
# mode: "r" to read, "w" to write (erases previous data), "a" appends data to file
# toWrite: anything if read, data to append/wrie
# return: 0 if failed
# return: 1 if succeded, overwrites/appends to fileName file
# return: data read if mode == "r"
def fileManager (fileName, mode, toWrite):
    #read and print file
    if (mode == "r"):
        file_object = open(fileName, mode)
        return file_object.read()
    #appends to file
    if (mode == "a"):
        file_object = open(fileName, mode)
        file_object.write(toWrite)
        return 0
        file_object.close()
    #Create a new file
    if (mode == "w"):
        file_object = open(fileName, mode)
        file_object.write(toWrite)
        return 0
        file_object.close()
    else:
        return 1

# Converts a small string (size tbd) into numbers
# source: string to be coverted
# return: a large number with the data encoded
def mapping (source):
    holder = ""
    msg = list(source)
    n = len(msg)
    for i in range (0, n, 1):
        if (msg[i]=="a"):
            holder += "10"
        if (msg[i]=="b"):
            holder += "11"
        if (msg[i]=="c"):
            holder += "12"
        if (msg[i]=="d"):
            holder += "13"
        if (msg[i]=="e"):
            holder += "14"
        if (msg[i]=="f"):
            holder += "15"
        if (msg[i]=="g"):
            holder += "16"
        if (msg[i]=="h"):
            holder += "17"
        if (msg[i]=="i"):
            holder += "18"
        if (msg[i]=="j"):
            holder += "19"
        if (msg[i]=="k"):
            holder += "20"
        if (msg[i]=="l"):
            holder += "21"
        if (msg[i]=="m"):
            holder += "22"
        if (msg[i]=="n"):
            holder += "23"
        if (msg[i]=="o"):
            holder += "24"
        if (msg[i]=="p"):
            holder += "25"
        if (msg[i]=="q"):
            holder += "26"
        if (msg[i]=="r"):
            holder += "27"
        if (msg[i]=="s"):
            holder += "28"
        if (msg[i]=="t"):
            holder += "29"
        if (msg[i]=="u"):
            holder += "30"
        if (msg[i]=="v"):
            holder += "31"
        if (msg[i]=="w"):
            holder += "32"
        if (msg[i]=="x"):
            holder += "33"
        if (msg[i]=="y"):
            holder += "34"
        if (msg[i]=="z"):
            holder += "35"
        if (msg[i]==" "):
            holder += "36"
        if (msg[i]=="."):
            holder += "37"
        if (msg[i]==","):
            holder += "38"
        else:
            holder += ""
    return holder

# Converts a large string of numbers (size tbd) into readable characters
# source: string to be decoverted
# return: a string with the data decoded
def demapping (source):
    holder = ""
    msg = list(source)
    n = len(msg)
    for i in range (0, n, 2):
        if (msg[i]+msg[i+1]=="10"):
            holder += "a"
        if (msg[i]+msg[i+1]=="11"):
            holder += "b"
        if (msg[i]+msg[i+1]=="12"):
            holder += "c"
        if (msg[i]+msg[i+1]=="13"):
            holder += "d"
        if (msg[i]+msg[i+1]=="14"):
            holder += "e"
        if (msg[i]+msg[i+1]=="15"):
            holder += "f"
        if (msg[i]+msg[i+1]=="16"):
            holder += "g"
        if (msg[i]+msg[i+1]=="17"):
            holder += "h"
        if (msg[i]+msg[i+1]=="18"):
            holder += "i"
        if (msg[i]+msg[i+1]=="19"):
            holder += "j"
        if (msg[i]+msg[i+1]=="20"):
            holder += "k"
        if (msg[i]+msg[i+1]=="21"):
            holder += "l"
        if (msg[i]+msg[i+1]=="22"):
            holder += "m"
        if (msg[i]+msg[i+1]=="23"):
            holder += "n"
        if (msg[i]+msg[i+1]=="24"):
            holder += "o"
        if (msg[i]+msg[i+1]=="25"):
            holder += "p"
        if (msg[i]+msg[i+1]=="26"):
            holder += "q"
        if (msg[i]+msg[i+1]=="27"):
            holder += "r"
        if (msg[i]+msg[i+1]=="28"):
            holder += "s"
        if (msg[i]+msg[i+1]=="29"):
            holder += "t"
        if (msg[i]+msg[i+1]=="30"):
            holder += "u"
        if (msg[i]+msg[i+1]=="31"):
            holder += "v"
        if (msg[i]+msg[i+1]=="32"):
            holder += "w"
        if (msg[i]+msg[i+1]=="33"):
            holder += "x"
        if (msg[i]+msg[i+1]=="34"):
            holder += "y"
        if (msg[i]+msg[i+1]=="35"):
            holder += "z"
        if (msg[i]+msg[i+1]=="36"):
            holder += " "
        if (msg[i]+msg[i+1]=="37"):
            holder += ","
        if (msg[i]+msg[i+1]=="38"):
            holder += "."
        else:
            holder += ""
    return holder

# Converts a small string (size tbd) from a file into numbers and stores them in a file
# sourceFile: file with the string to be coverted
# outputFile: file where the converted string will be stored
# return: 1 if there was an error with the file
# return: 0 if the encoding was succesful
def encode (sourceFile, outputFile):
    read = "r"
    write = "w"
    append = "a"
    output = fileManager(outputFile, write, "")
    if (output):
        return 1
    else:
        source = fileManager(sourceFile, read, 0)
        codedData = mapping(source)
        output = fileManager(outputFile, append, codedData)
        return codedData



# Converts a small string (size tbd) from a file into numbers
# sourceFile: file with the string to be coverted
# return: the string with coded data
def encodeNoFile (sourceFile):
    data = fileManager(sourceFile, "r", 0)
    codedData = mapping(data)
    return codedData



# Converts a short number (size tbd) from a file into characters and stores them in a file
# sourceFile: file with the string to be coverted
# outputFile: file where the converted string will be stored
# return: 1 if there was an error with the file
# return: the encoded data and writes to a file
def decode (sourceFile, outputFile):
    read = "r"
    write = "w"
    append = "a"
    output = fileManager(outputFile, write, "")
    if (output):
        return 1
    else:
        source = fileManager(sourceFile, read, 0)
        decodedData = demapping(source)
        output = fileManager(outputFile, append, decodedData)
        return decodedData




# Converts a short number (size tbd) from a file into characters
# data: string to be coverted
# return: the encoded data
def decodeNoFile (data):
    decodedData = demapping(data)
    return decodedData






#test function, requires especific files to exist
def testEncode():
    errorMsg = encode ("Files/src.txt", "Files/temp.txt")
    if (errorMsg):
        print ("Error writing file")
        return 1
    else:
        print ("Encoding complete")
        return 0

#test function, requires especific files to exist
def testDecode():
    errorMsg = decode ("Files/temp.txt", "Files/dec.txt")
    if (errorMsg):
        print ("Error writing file")
        return 1
    else:
        print ("Decoding complete")
        return 0

#test both encode and decode
def test():
    status = testEncode()
    if (status):
        return status
    else:
        status = testDecode()
        if (status):
            return 1
        else:
            return 0













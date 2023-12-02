#!/usr/bin/python3
import socket
import sys
from datetime import datetime

# Defining a target
if len(sys.argv) == 2:
    # translate hostname to IPv4
    target = socket.gethostbyname(sys.argv[1])
else:
    print("Invalid amount of Argument")

# Add Banner
print("-" * 50)
print("Scanning Target: " + target)
print("Scanning started at:" + str(datetime.now()))
print("-" * 50)

try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        socket.setdefaulttimeout(1)
        result = s.connect_ex((target, 22))
        if result == 0:
            print("Port {} is open".format(22))
            s.close()
        else :
#            s.close()
            sys.exit(22)

except KeyboardInterrupt:
    print("\nExiting Program!!!")
    sys.exit()

except socket.gaierror:
    print("\nHostname Could Not Be Resolved!!!")
    sys.exit()

except socket.error:
    print("\nServer not responding!!!")
    sys.exit()

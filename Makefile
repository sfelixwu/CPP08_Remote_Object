# Makefile for HW3 Web Report, ecs36b, f2020
#

CC = g++ -std=c++14
CFLAGS = -g -g -I/opt/homebrew/include

# CFLAGS = -g -Wall -Wstrict-prototypes
# CFLAGS = -O3

# CORE_INCS =	Core.h Transaction.h Person.h
# CORE_OBJS =	Core.o Transaction.o Person.o
# SHADOW_INCS = Shadow_Flight.h Shadow_Person.h
# SHADOW_OBJS = Shadow_Flight.o Shadow_Person.o 

LDFLAGS = -L/opt/homebrew/lib -ljsoncpp -lmicrohttpd -ljsonrpccpp-common -ljsonrpccpp-server -ljsonrpccpp-client -lcurl

# rules.
all: 	roclient roserver

#
#

roclient.h:		ecs36b_ro.json
	jsonrpcstub ecs36b_ro.json --cpp-server=roServer --cpp-client=roClient

roserver.h:		ecs36b_ro.json
	jsonrpcstub ecs36b_ro.json --cpp-server=roServer --cpp-client=roClient

roclient.o:		roclient.h roclient.cpp
	$(CC) -c $(CFLAGS) roclient.cpp

roserver.o:		roserver.h roserver.cpp
	$(CC) -c $(CFLAGS) roserver.cpp

GPS.o:		GPS.cpp GPS.h
	$(CC) -c $(CFLAGS) GPS.cpp

Labeled_GPS.o:	Labeled_GPS.cpp Labeled_GPS.h GPS.h
	$(CC) -c $(CFLAGS) Labeled_GPS.cpp

roclient:		roclient.o
	$(CC) -o roclient roclient.o $(LDFLAGS)

roserver:		roserver.o Labeled_GPS.o GPS.o
	$(CC) -o roserver roserver.o Labeled_GPS.o GPS.o $(LDFLAGS)

clean:
	rm -f *.o *~ core roclient roserver roclient.h roserver.h

CC      = c++
C       = cc
INCDIR  = ./include
OBJ     = ./unix
SRC     = trcomp.cpp
SHELL   = /bin/csh
APPS    = range2list fillout toid toname par xptest filter lookup

CFLAGS  = -Wc++11-compat-deprecated-writable-strings -ferror-limit=2 -c -g -Wall -I${INCDIR} -D_BOOL_EXISTS -D__macosx -UDIAGNOSE 

#
# Should not have -O3 with debug
# -DHAVE_BITLIST

SKIPOB = \
   ${OBJ}/SkipListElement.o \
   ${OBJ}/SkipList.o \
   ${OBJ}/HtmRange.o \
   cc_aux.o 

OBJECTS = \
   ${OBJ}/SpatialIndex.o \
   ${OBJ}/SpatialConstraint.o \
   ${OBJ}/sqlInterface.o \
   ${OBJ}/SpatialVector.o \
   ${OBJ}/SpatialInterface.o \
   ${OBJ}/SpatialEdge.o \
   ${OBJ}/SpatialException.o \
   ${OBJ}/SpatialDomain.o \
   ${OBJ}/RangeConvex.o \
   ${OBJ}/Htmio.o \
   ${OBJ}/SkipListElement.o \
   ${OBJ}/SkipList.o \
   ${OBJ}/HtmRange.o \
   ${OBJ}/HtmRangeIterator.o \
   cc_aux.o 

#  ${OBJ}/SpatialConvex.o 
#   ${OBJ}/BitList.o

all: intersect  filter
# example

example: ${OBJ}/example.o ${OBJECTS}
	$(CC) -o $@  ${OBJ}/example.o ${OBJECTS}

sqlExample: ${OBJ}/sqlExample.o ${OBJECTS}
	$(CC) -o $@  ${OBJ}/sqlExample.o ${OBJECTS}

intersect: ${OBJ}/intersect.o ${OBJECTS}
	$(CC) -g -o $@  ${OBJ}/intersect.o ${OBJECTS} 
#---------------------------------------------
${OBJ}/htmlookup.o: app/htmlookup.c
	$(C) $(CFLAGS) app/htmlookup.c -o $@
htmlookup: ${OBJ}/htmlookup.o cc_aux.o
	$(C) -g -o $@  ${OBJ}/htmlookup.o cc_aux.o
#---------------------------------------------
${OBJ}/toname.o: app/toname.c
	$(C) $(CFLAGS) app/toname.c -o $@
toname: ${OBJ}/toname.o cc_aux.o
	$(C) -g -o $@  ${OBJ}/toname.o cc_aux.o
#---------------------------------------------
${OBJ}/toid.o: app/toid.c
	$(C) $(CFLAGS) app/toid.c -o $@
toid: ${OBJ}/toid.o cc_aux.o
	$(C) -g -o $@  ${OBJ}/toid.o cc_aux.o
#---------------------------------------------
${OBJ}/fillout.o: app/fillout.c
	$(C) $(CFLAGS) app/fillout.c -o $@
fillout: ${OBJ}/fillout.o cc_aux.o
	$(C) -g -o $@  ${OBJ}/fillout.o cc_aux.o
#---------------------------------------------
${OBJ}/range2list.o: app/range2list.c
	$(C) $(CFLAGS) app/range2list.c -o $@
range2list: ${OBJ}/range2list.o cc_aux.o
	$(C) -g -o $@  ${OBJ}/range2list.o cc_aux.o
#---------------------------------------------
lookup: ${OBJ}/lookup.o ${OBJECTS}
	$(CC) -g -o $@  ${OBJ}/lookup.o ${OBJECTS} 

filter: filter.o $(SKIPOB)
	$(CC) -o $@ filter.o $(SKIPOB)

filter.o: filter.cpp
	$(CC) $(CFLAGS) filter.cpp -o $@

testrun:
	make -f Makefile intersect
	./intersect  20 testInputIntersect > tmp.out
	diff tmp.out correctOutputIntersect
	./intersect -varlength 20 testInputIntersect > tmp.out 
	diff tmp.out correctVarout
	./intersect -varlength 20 testTiny > tmp.out
	diff tmp.out correctTinyVarout
	./intersect  20 testTiny > tmp.out
	diff tmp.out correctTinyOut
testcompress:
	make -f Makefile intersect filter
	./intersect 20 testInputIntersect | filter 1 
	./intersect -nranges 1 20 testInputIntersect
vis:
	echo "C 80 20 30" > /tmp/h1
	./intersect -varlength 20 testInputIntersect >> /tmp/h1

xptest: ${OBJ}/xptest.o ${OBJECTS}
	$(CC) -g -o $@  ${OBJ}/xptest.o ${OBJECTS}

${OBJ}/lookup.o: app/lookup.cpp
	$(CC) $(CFLAGS) app/lookup.cpp -o $@

test1: ${OBJ}/test1.o ${OBJECTS}
	$(CC) -g -o $@  ${OBJ}/test1.o ${OBJECTS}

${OBJ}/xptest.o: app/xptest.cpp
	$(CC) $(CFLAGS) app/xptest.cpp -o $@

${OBJ}/intersect.o: app/intersect.cpp
	$(CC) $(CFLAGS) app/intersect.cpp -o $@

${OBJ}/test1.o: app/test1.cpp
	$(CC) $(CFLAGS) app/test1.cpp -o $@

${OBJ}/example.o: app/example.cpp
	$(CC) $(CFLAGS) app/example.cpp -o $@

${OBJ}/sqlExample.o: app/sqlExample.cpp
	$(CC) $(CFLAGS) app/sqlExample.cpp -o $@

${OBJ}/SpatialIndex.o: src/SpatialIndex.cpp
	$(CC) $(CFLAGS) src/SpatialIndex.cpp -o $@

${OBJ}/SpatialConstraint.o: src/SpatialConstraint.cpp
	$(CC) $(CFLAGS) src/SpatialConstraint.cpp -o $@

${OBJ}/sqlInterface.o: src/sqlInterface.cpp
	$(CC) $(CFLAGS) src/sqlInterface.cpp -o $@

${OBJ}/SpatialVector.o: src/SpatialVector.cpp
	$(CC) $(CFLAGS) src/SpatialVector.cpp -o $@

${OBJ}/SpatialInterface.o: src/SpatialInterface.cpp
	$(CC) $(CFLAGS) src/SpatialInterface.cpp -o $@

${OBJ}/SpatialEdge.o: src/SpatialEdge.cpp
	$(CC) $(CFLAGS) src/SpatialEdge.cpp -o $@

${OBJ}/SpatialException.o: src/SpatialException.cpp
	$(CC) $(CFLAGS) src/SpatialException.cpp -o $@

${OBJ}/SpatialDomain.o: src/SpatialDomain.cpp
	$(CC) $(CFLAGS) src/SpatialDomain.cpp -o $@

${OBJ}/SpatialConvex.o: src/SpatialConvex.cpp
	$(CC) $(CFLAGS) src/SpatialConvex.cpp -o $@

${OBJ}/RangeConvex.o: src/RangeConvex.cpp
	$(CC) $(CFLAGS) src/RangeConvex.cpp -o $@

${OBJ}/Htmio.o: src/Htmio.cpp
	$(CC) $(CFLAGS) src/Htmio.cpp -o $@

${OBJ}/SkipListElement.o: src/SkipListElement.cpp
	$(CC) $(CFLAGS) src/SkipListElement.cpp -o $@

${OBJ}/SkipList.o: src/SkipList.cpp
	$(CC) $(CFLAGS) src/SkipList.cpp -o $@

${OBJ}/HtmRange.o: src/HtmRange.cpp
	$(CC) $(CFLAGS) src/HtmRange.cpp -o $@

${OBJ}/HtmRangeIterator.o: src/HtmRangeIterator.cpp
	$(CC) $(CFLAGS) src/HtmRangeIterator.cpp -o $@

${OBJ}/XXX.o: src/XXX.cpp
	$(CC) $(CFLAGS) src/XXX.cpp -o $@

cc_aux.o: cc_aux.c
	cc -c $(CFLAGS) cc_aux.c

cc_intersect.o: cc_intersect.c
	cc -c cc_intersect.c

clean:
	rm -f $(OBJECTS) ${OBJ}/hello.o  $(OBJ)/intersect.o $(OBJ)/test1.o $(OBJ)/fin.o 

cleanAll:
	-rm -f $(OBJECTS) ${OBJ}/*.o
	-rm -f a.out intersect sqlExample trcomp 
	-rm -f $(APPS)
	-rm -f tmp.out *.o *~ 
	-rm -f app/*~
#
tarball:
	source mktarball.csh
par: HtmParse.o
	$(CC) -g -o $@ HtmParse.o  ${OBJECTS}

HtmParse.o: HtmParse.cpp HtmParse.h
	$(CC) $(CFLAGS) -I. HtmParse.cpp
%.o: %.cpp
	$(CC) -c $(CC_FLAGS) $< -o $@

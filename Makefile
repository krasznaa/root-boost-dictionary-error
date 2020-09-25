
CXXFLAGS = -I ~/software/boost/1.74.0/x86_64-centos8-gcc8-opt/include

libMyLibrary.so: MyClass.o Dictionary.o
	`root-config --ld` -o $@ -shared `root-config --libs` $^

Dictionary.cxx: MyClass.h LinkDef.h
	rootcling -f $@ -rmf=libMyLibrary.rootmap -rml=libMyLibrary.so \
		-s=libMyLibrary.so $(CXXFLAGS) $^

clean:
	rm -f *.o
	rm -f Dictionary.*
	rm -f libMyLibrary*

distclean: clean
	rm -f *~

.SUFFIXES: .cxx .o

.cxx.o:
	`root-config --cxx` -c -o $@ `root-config --cflags` -fPIC $(CXXFLAGS) $<

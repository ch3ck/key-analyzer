# Builds and runs the ECC crypto project
#
CC          := gcc
CXX         := g++
CFLAGS      := -O3 -Wall
LIBS        := -lgmp $(shell libgcrypt-config --cflags --libs)
SRCDIR      := .
OBJDIR      := obj
BINDIR      := bin
OBJECTS     := $(BINDIR)/bloom.o $(BINDIR)/sha256.o $(BINDIR)/base58.o $(BINDIR)/rmd160.o $(BINDIR)/xxhash.o $(BINDIR)/util.o
SOURCES     := $(wildcard $(SRCDIR)/*.c)
EXECUTABLES := test_functions rehashaddress calculatefromkey calculatefrompublickey division math modmath keygen sharedsecret addr2rmd verifymsg

.PHONY: all
all: default

test: $(EXECUTABLES)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

test_functions: $(OBJDIR)/util.o
	$(CC) $(CFLAGS) -o $(BINDIR)/$@ test_functions.c $^

rehashaddress calculatefromkey division math modmath keygen sharedsecret addr2rmd verifymsg: $(OBJDIR)/util.o $(OBJDIR)/gmpecc.o $(OBJDIR)/sha256.o $(OBJDIR)/base58.o $(OBJDIR)/rmd160.o
	$(CC) $(CFLAGS) -o $(BINDIR)/$@ $@.c $^ $(LIBS)

calculatefrompublickey: $(OBJDIR)/util.o $(OBJDIR)/base58.o $(OBJDIR)/sha256.o $(OBJDIR)/rmd160.o
	$(CC) $(CFLAGS) -o $(BINDIR)/$@ $@.c $^ $(LIBS)

.PHONY: clean
clean:
	rm -rf $(OBJDIR)/*.o $(BINDIR)/*


.PHONY: default
default:
	@mkdir -p bin
	$(CC) $(CFLAGS) -c bloom/bloom.c -o $(BINDIR)/bloom.o
	$(CC) $(CFLAGS) -c sha256/sha256.c -o $(BINDIR)/sha256.o
	$(CC) $(CFLAGS) -c base58/base58.c -o $(BINDIR)/base58.o
	$(CC) $(CFLAGS) -c rmd160/rmd160.c -o $(BINDIR)/rmd160.o
	$(CC) $(CFLAGS) -c xxhash/xxhash.c -o $(BINDIR)/xxhash.o
	# $(CC) $(CFLAGS) -c gmpecc.c -o $(BINDIR)/gmpecc.o
	$(CC) $(CFLAGS) -c util.c -o $(BINDIR)/util.o
	# $(CC) $(CFLAGS) -o $(BINDIR)/test_functions test_functions.c util.o
	# $(CC) $(CFLAGS) -o $(BINDIR)/rehashaddress rehashaddress.c gmpecc.c $(OBJECTS) $(LIBS)
	# $(CC) $(CFLAGS) -o $(BINDIR)/calculatefromkey calculatefromkey.c gmpecc.c $(OBJECTS) $(LIBS)
	# $(CC) $(CFLAGS) -o $(BINDIR)/calculatefrompublickey calculatefrompublickey.c $(OBJECTS) $(LIBS)
	# $(CC) $(CFLAGS) -o $(BINDIR)/division division.c gmpecc.c $(OBJECTS) $(LIBS)
	$(CC) $(CFLAGS) -o $(BINDIR)/math math.c gmpecc.c $(BINDIR)/util.o  $(BINDIR)/base58.o $(BINDIR)/sha256.o $(BINDIR)/rmd160.o $(LIBS)
	$(CC) $(CFLAGS) -o $(BINDIR)/modmath  modmath.c gmpecc.c $(BINDIR)/util.o  $(BINDIR)/base58.o $(BINDIR)/sha256.o $(BINDIR)/rmd160.o $(LIBS)
	# $(CC) $(CFLAGS) -o $(BINDIR)/keygen keygen.c gmpecc.c $(OBJECTS) -lcrypto $(LIBS)
	# $(CC) $(CFLAGS) -o $(BINDIR)/sharedsecret sharedsecret.c gmpecc.c $(OBJECTS) $(LIBS)
	# $(CC) -o $(BINDIR)/addr2rmd addr2rmd.c $(BINDIR)/util.o $(BINDIR)/base58.o
	# $(CC) -o $(BINDIR)/test_functions test_functions.c $(BINDIR)/util.o
	# $(CC) $(CFLAGS) -o $(BINDIR)/verifymsg verifymsg.c gmpecc.c $(OBJECTS) $(LIBS)

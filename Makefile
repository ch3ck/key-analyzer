# Builds and runs the ECC crypto project
#
CC          := gcc
CXX         := g++
RM          := rm -f
LDLIBS      := -lm
CFLAGS      := -O3
LIBS        := -lgmp $(shell libgcrypt-config --cflags --libs)
SRCDIR      := .
OBJDIR      := obj
BINDIR      := bin
SOURCES     := $(wildcard $(SRCDIR)/*.c)
OBJECTS     := $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SOURCES))
EXECUTABLES := test_functions rehashaddress calculatefromkey calculatefrompublickey division math modmath keygen sharedsecret addr2rmd verifymsg

.PHONY: all clean
all: $(EXECUTABLES)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

test_functions: $(OBJDIR)/util.o
	$(CC) $(CFLAGS) -o $(BINDIR)/$@ test_functions.c $^

rehashaddress calculatefromkey division math modmath keygen sharedsecret addr2rmd verifymsg: $(OBJDIR)/util.o $(OBJDIR)/gmpecc.o $(OBJDIR)/sha256.o $(OBJDIR)/base58.o $(OBJDIR)/rmd160.o
	$(CC) $(CFLAGS) -o $(BINDIR)/$@ $@.c $^ $(LIBS)

calculatefrompublickey: $(OBJDIR)/util.o $(OBJDIR)/base58.o $(OBJDIR)/sha256.o $(OBJDIR)/rmd160.o
	$(CC) $(CFLAGS) -o $(BINDIR)/$@ $@.c $^ $(LIBS)

clean:
	rm -rf $(OBJDIR)/*.o $(BINDIR)/*

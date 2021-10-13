#!/bin/sh

# How to use it : ./creation.sh filename "int fct(args)"

if [ $# -eq 0 ]; then
    echo Couldn\'t do anything.
    exit 1
fi

mkdir $1
cd $1
mkdir src
mkdir tests
mkdir ~/afs/thomasBazar/piscine/thomas.emerdjian-piscine-2024/$1

echo "#include \"src/$1.h\"

#include <assert.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    $2;
    return 0;
}" > main.c

echo "NAME =$1

CC =gcc
CFLAGS =-Wall -Wextra -Werror -pedantic -std=c99
CSRFLAGS =csr
LDFLAGS =-L.
LDLIB =-l\$(NAME)

FILE =src/\$(NAME).o
TEST =tests/test.o

BIN =check main main.o

.PHONY: all clean

all: main

main: main.o library
	\$(CC) \$(LDFLAGS) $< \$(LDLIB) -o \$@

library: lib\$(NAME).a

lib\$(NAME).a: \$(FILE)
	ar \$(CSRFLAGS) \$@ $^

check: LDFLAGS += -lcriterion
check: \$(TEST) library
	\$(CC) \$(LDFLAGS) $< \$(LDLIB) -o \$@
	./\$@

valgrind: CFLAGS += -g
valgrind: clean main
	\$@ -s ./main

fsanitize: CFLAGS += -fsanitize=address -g
fsanitize: LDFLAGS += -lasan
fsanitize: clean main
	./main

clean:
  \$(RM) \$(TEST) \$(FILE) \$(BIN)" > Makefile

cd src

echo "#ifndef $1_H
#define $1_H

#include <stddef.h>

$2;

#endif /* ! $1_H */" > $1.h

echo "#include \"$1.h\"

$2
{
}" > $1.c

cd ..
cd tests

echo "#include \"../src/$1.h\"

#include <criterion/criterion.h>

Test(example, test)
{
    actual = 1;
    expected = 1;
    cr_assert_eq(actual, expected, \"Expected: %d. Got %d.\", actual, expected);
}" > 'test.c'

echo Job done !

cd ../..

tree $1

DAFNY ?= dafny

.PHONY: all check clean

all: check Main.exe

check:
	$(DAFNY) /whatever | egrep -q "Dafny.*version 1.9.7.30401"

clean:
	rm -rf Vampire.dll Vampire.dll.mdb Main.exe

Vampire.dll: Vampire.dfy
	$(DAFNY) Vampire.dfy

Main.exe: Vampire.dll Main.cs
	mcs -r:System.Numerics.dll -r:Vampire.dll Main.cs

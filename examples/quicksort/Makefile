include ../../common.mk

all: coq

QuickSort.v: QuickSort.hs edits
	$(HS_TO_COQ) -e edits -e ../../base/edits QuickSort.hs -o .

QuickSort2.v: QuickSort2.hs edits2 preamble2.v
	$(HS_TO_COQ) -e edits2 -e ../../base/edits -p preamble2.v QuickSort2.hs -o .

Makefile.coq: _CoqProject
	coq_makefile -f _CoqProject -o $@

coq: Makefile.coq QuickSort.v QuickSort2.v Proofs.v
	$(MAKE) -f Makefile.coq OPT=$(COQFLAGS)

clean:
	rm -f */*.vo */*.glob */*.v.d *.vo *.v.d QuickSort.v QuickSort2.v Makefile.coq  */*.v~

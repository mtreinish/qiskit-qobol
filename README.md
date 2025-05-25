# Qiskit Qobol

This repository contains COBOL language bindings to Qiskit to enable COBOL
users to use quantum computers.

## Building Qiskit Qobol

Qiskit qobol is only tested using GnuCOBOL and is the only supported compiler.
Qiskit Qobol is only tested on Linux. This doesn't mean Qiskit Qobol doesn't
necessarily work on other COBOL compilers or other operating systems, but
those aren't currently supported. Other platform support can be introduced
if there is CI testing resources available to validate it works on those
platforms.

The typical workflow is:

```bash
$ make
$ LD_LIBRARY_PATH=../qiskit-terra/dist/c/lib:$LD_LIBRARY_PATH ./build_bell
```

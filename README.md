# Qiskit Qobol

This repository contains COBOL language bindings to Qiskit to enable COBOL
users to use quantum computers.

## Building Qiskit Qobol

Qiskit Qobol is only tested using GnuCOBOL and is the only supported compiler.
Qiskit Qobol is only tested on Linux. This doesn't mean Qiskit Qobol doesn't
necessarily work on other COBOL compilers or other operating systems, but
those aren't currently supported. Other platform support can be introduced
if there is CI testing resources available to validate it works on those
platforms. But for the time being only Linux on x86_64 is officially
supported.

### Dependencies

To build Qiskit Qobol you need the following dependencies installed

1. GnuCOBOL 3.2.0
2. `libqiskit` 2.6.2 ([Qiskit](https://github.com/Qiskit/qiskit)'s C API)
3. `libqiskit_ibm_runtime` ([Qiskit IBM Runtime C](https://github.com/Qiskit/qiskit-ibm-runtime-c))

To install `libqiskit` and `libqiskit_ibm_runtime` you will typically need `git` and Rust >= 1.85.
But any installation method will work for them, the most common just involves building from source.

### Common installation instructions

The typical workflow for building Qiskit Qobol is:

```bash
$ ./install_deps.sh
$ make
```

The `./install_deps.sh` script will build Qiskit v2.6.2 and
qiskit-ibm-runtime-c at the correct version and then install them
in you system. If you already have either installed on your system
or would prefer to install this on your own do not run this script.
This script assumes Linux with sudo configured and will install the
library and headers in `/usr/local`. If this isn't compatible with
your local environment you can use the script as a guide on how to
build the Qiskit dependencies and install them however works for your
system.

The Makefile is setup to build the example programs present in
`./examples` and will build the executables in the repository root.
The intent is for these to serve as examples for the COBOL
programmer for how to use Qiskit and IBM Quantum Computers from
COBOL.

## Running the examples

All the example scripts are setup to read your IBM Quantum Platform
credentials from `~/.qiskit/qiskit-ibm.json` which is the default
place that [qiskit-ibm-runtime](https://quantum.cloud.ibm.com/docs/en/api/qiskit-ibm-runtime), the Python client package for Qiskit
to work with IBM Quantum. It will load the default credentials
from this file and use these for interacting with
IBM Quantum Platform. You will need this credential file setup
to run the example scripts.

### `build_bell`

This script will build a bell state circuit of the form:

```
     ┌───┐     ┌─┐
q_0: ┤ H ├──■──┤M├───
     └───┘┌─┴─┐└╥┘┌─┐
q_1: ─────┤ X ├─╫─┤M├
          └───┘ ║ └╥┘
c: 2/═══════════╩══╩═
                0  1
```

transpile that circuit for the `ibm_chicago` backend with
optimization level 2, and then submit a sampler job to run the
circuit on `ibm_chicago` with 1000 shots, and when the job finishes
executing on the backend it will print the resulting counts. The
typical output of this program should look like:

```
Building Bell Circuit.

Submitting sampler job.
Job status: PENDING
Job status: RUNNING
Job status: DONE

Number of samples: 1000

Results:
  0x3: 478
  0x0: 496
  0x1: 13
  0x2: 13
```

The backend being run is hardcoded in the source file `examples/build_bell.cbl`
you can replace the string `ibm_chicago` with any IBM Quantum backend that you
have access to.

### `estimator_example.cbl`

This script will build the following QAOA Ansatz circuit:

```
     ┌───┐                                    ┌───────┐
q_0: ┤ H ├─■──────────────────────────■───────┤ Rx(π) ├
     ├───┤ │ZZ(2π)          ┌───────┐ │       └───────┘
q_1: ┤ H ├─■────────■───────┤ Rx(π) ├─┼────────────────
     ├───┤          │ZZ(2π) └───────┘ │       ┌───────┐
q_2: ┤ H ├──────────■────────■────────┼───────┤ Rx(π) ├
     ├───┤                   │ZZ(2π)  │ZZ(2π) ├───────┤
q_3: ┤ H ├───────────────────■────────■───────┤ Rx(π) ├
     └───┘                                    └───────┘
```

In addition it constructs a `SparseObservable` with ZZ terms on
the indices with RZZ gates which is used to compute the expectation
value of. The circuit is then transpiled for `ibm_chicago` with
optimization level 2, the resulting layout is then applied to
the observable. This transpiled circuit and modified observable
are then submitted as an estimator job on `ibm_chicago`, and when
the job finishes executing the program prints the computed
expectation value.

The backend being run is hardcoded in the source file `examples/estimator_example.cbl`
you can replace the string `ibm_chicago` with any IBM Quantum backend that you
have access to.

## Repository Organization

There are two main directories in the repository, `examples/` and
`src/`. The `src/` directory contains the main library code in
qiskit-qobol. It contains COBOL source files with subroutines that
wrap Qiskit's C API to enable working with quantum circuits. It
also contains subroutines that wrap qiskit-ibm-runtime-c to enable
taking Qiskit objects and running them on IBM's Quantum computers
through the IBM Quantum Platform. This is different from the main
Qiskit SDK and language binding libraries which are not tied to a
specific vendor, but as this repository is not a traditional shared
library but instead is a collection of reusable source files and
examples this was a tradeoff for demonstrating the capabilities of
using a quantum computer from COBOL. Contributions for leveraging
other hardware vendor's quantum computers are very welcome.

The intent of the `src/` directory is to provide reusable COBOL
source code that can be integrated into your COBOL program that
needs to leverage quantum computing resources.

The other directory, `examples/` contains example programs that
are simple examples that show how to leverage the COBOL subroutines
in `src/` to run quantum workloads. Each is fully functional and
can be compiled and run to demonstrate how to use quantum computers
from COBOL.

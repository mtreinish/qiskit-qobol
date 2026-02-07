default: build

build:
	gcc -c src/qiskit_interface.c -o qiskit_interface.o
	cobc -fbinary-byteorder=native -fstatic-call -w -x examples/build_bell.cbl src/circuit_gate.cbl src/circuit_measure.cbl src/circuit_new.cbl src/circuit_gate_no_params.cbl -debug qiskit_interface.o -l qiskit -L ../qiskit-core/dist/c/lib -I ../qiskit-core/dist/c/include

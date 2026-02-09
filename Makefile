default: build

build:
	cobc -fbinary-byteorder=native -fstatic-call -w -x examples/build_bell.cbl src/circuit_gate.cbl src/circuit_measure.cbl src/circuit_new.cbl -debug -l qiskit -L ../qiskit-core/dist/c/lib -I ../qiskit-core/dist/c/include

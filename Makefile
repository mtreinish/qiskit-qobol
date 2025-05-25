default: build

build:
	cobc -fstatic-call -w -x examples/build_bell.cbl src/circuit_gate.cbl src/circuit_measure.cbl src/circuit_new.cbl -l qiskit -L ../qiskit-terra/dist/c/lib -I ../qiskit-terra/dist/c/include -O3

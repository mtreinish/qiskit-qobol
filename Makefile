default: build

build:
	cobc -fbinary-byteorder=native -fstatic-call -w -x examples/build_bell.cbl src/circuit_gate.cbl src/circuit_measure.cbl src/circuit_new.cbl src/circuit_gate_no_params.cbl -l qiskit -L ../qiskit-terra/dist/c/lib -I ../qiskit-terra/dist/c/include -debug

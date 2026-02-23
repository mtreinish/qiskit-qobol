default: build

build:
	cobc -fbinary-byteorder=native -fstatic-call -w -x \
		examples/build_bell.cbl \
		src/circuit_gate.cbl \
		src/circuit_measure.cbl \
		src/circuit_new.cbl \
		src/service_new.cbl \
		src/least_busy_backend.cbl \
		src/backend_by_name.cbl \
		src/execute.cbl \
		src/sampler_job_results.cbl \
		src/histogram.cbl \
		-debug \
		-l qiskit \
		-l qiskit_ibm_runtime
	cobc -fbinary-byteorder=native -fstatic-call -w -x \
		examples/estimator_example.cbl \
		src/circuit_gate.cbl \
		src/circuit_measure.cbl \
		src/circuit_new.cbl \
		src/service_new.cbl \
		src/least_busy_backend.cbl \
		src/backend_by_name.cbl \
		src/estimate.cbl \
		src/estimator_job_results.cbl \
		src/obs_new.cbl \
		src/obs_add_term.cbl \
		src/expectation_value_count.cbl \
		src/display_expectation_values.cbl \
		--debug \
		-l qiskit \
		-l qiskit_ibm_runtime

clean:
	rm -f build_bell
	rm -f estimator_example

      / This code is part of Qiskit Qobol.
      /
      / (C) Copyright Matthew Treinish 2025.
      /
      / This code is licensed under the Apache License, Version 2.0. You may
      / obtain a copy of this license in the LICENSE.txt file in the root directory
      / of this source tree or at http://www.apache.org/licenses/LICENSE-2.0.
      /
      / Any modifications or derivative works of this code must retain this
      / copyright notice, and modified files need to carry a notice indicating
      / that they have been altered from the originals.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. bell_circuit.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NUM_QUBITS USAGE BINARY-LONG UNSIGNED.
       01 NUM_CLBITS USAGE BINARY-LONG UNSIGNED.
       01 H_GATE USAGE BINARY-CHAR UNSIGNED VALUE 1.
       01 CX_GATE USAGE BINARY-CHAR UNSIGNED VALUE 22.
       01 QUBIT_MEASURE USAGE BINARY-LONG VALUE 0.
       01 CLBIT_MEASURE USAGE BINARY-LONG VALUE 0.
       01 GateQubits.
           02 QUBIT USAGE BINARY PIC S9(5) OCCURS 3 TIMES.
       01 GateParams.
           02 PARAM USAGE COMP-2 OCCURS 3 TIMES.
       01 CIRCUIT USAGE POINTER.
       01 SERVICE USAGE POINTER.
       01 Backend USAGE POINTER.
       01 Job USAGE POINTER.
       01 Samples USAGE POINTER.
       01 BACKEND-NAME PIC X(32) VALUE "ibm_torino".

       PROCEDURE DIVISION.
       000-Main.
           DISPLAY "Building Bell Circuit.".
           MOVE 2 to NUM_QUBITS.
           MOVE 2 to NUM_CLBITS.
           CALL 'QiskitCreateCircuit' USING
               BY VALUE NUM_QUBITS, NUM_CLBITS,
               BY REFERENCE CIRCUIT.
           MOVE 0 to QUBIT(1).
           CALL 'QiskitCircuitGate' USING BY VALUE H_GATE,
               BY REFERENCE Circuit,
               BY REFERENCE GateQubits,
               BY REFERENCE GateParams.
           MOVE 0 to QUBIT(1).
           MOVE 1 to QUBIT(2).
           CALL 'QiskitCircuitGate' USING BY VALUE CX_GATE,
               BY REFERENCE Circuit,
               BY REFERENCE GateQubits,
               BY REFERENCE GateParams.
           CALL 'QiskitCircuitMeasure' USING BY VALUE QUBIT_MEASURE,
               CLBIT_MEASURE, BY REFERENCE Circuit.
           MOVE 1 to QUBIT_MEASURE, CLBIT_MEASURE.
           CALL 'QiskitCircuitMeasure' USING BY VALUE QUBIT_MEASURE,
               CLBIT_MEASURE, BY REFERENCE Circuit.
           CALL 'ServiceNew' USING BY REFERENCE SERVICE.
           CALL 'BackendByName' USING
               BY REFERENCE Service,
               BY REFERENCE BACKEND-NAME,
               BY REFERENCE Backend.
           IF Backend = NULL
               STOP RUN
           END-IF.
           CALL 'ExecuteSampler' USING
               BY REFERENCE Service,
               BY REFERENCE Backend,
               BY REFERENCE Circuit,
               BY REFERENCE Job.
           CALL 'SamplerJobResults' USING
               BY REFERENCE Service,
               BY REFERENCE Job,
               BY REFERENCE Samples.
           CALL 'Histogram' USING
               BY REFERENCE Samples.
           STOP RUN.

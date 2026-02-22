      / This code is part of Qiskit Qobol.
      /
      / (C) Copyright Matthew Treiniish 2026.
      /
      / This code is licensed under the Apache License, Version 2.0. You may
      / obtain a copy of this license in the LICENSE.txt file in the root directory
      / of this source tree or at http://www.apache.org/licenses/LICENSE-2.0.
      /
      / Any modifications or derivative works of this code must retain this
      / copyright notice, and modified files need to carry a notice indicating
      / that they have been altered from the originals.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. estimator_example.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NUM_QUBITS USAGE BINARY-LONG UNSIGNED.
       01 NUM_CLBITS USAGE BINARY-LONG UNSIGNED.
       01 H_GATE USAGE BINARY-CHAR UNSIGNED VALUE 1.
       01 RZZ_GATE USAGE BINARY-CHAR UNSIGNED VALUE 41.
       01 RX_GATE USAGE BINARY-CHAR UNSIGNED VALUE 8.
       01 QkBitTerm_Y USAGE BINARY-CHAR UNSIGNED VALUE 3.
       01 QUBIT_MEASURE USAGE BINARY-LONG VALUE 0.
       01 CLBIT_MEASURE USAGE BINARY-LONG VALUE 0.
       01 GateQubits.
           02 QUBIT BINARY-LONG UNSIGNED OCCURS 3 TIMES.
       01 GateParams.
           02 PARAM USAGE COMP-2 OCCURS 3 TIMES.
       01 Observable USAGE POINTER.
       01 Coeff_COMPLEX.
           02 RE USAGE COMP-2 VALUE 1.0.
           02 IM USAGE COMP-2 VALUE 0.0.
       01 NumBitTerms USAGE BINARY-LONG UNSIGNED VALUE 2.
       01 Terms.
           02 TERM USAGE BINARY PIC S9(1) OCCURS 2 TIMES.
       01 Term_Indices.
           02 IDX USAGE BINARY PIC S9(5) OCCURS 2 TIMES.
       01 EV USAGE COMP-2.
       01 CIRCUIT USAGE POINTER.
       01 SERVICE USAGE POINTER.
       01 Backend USAGE POINTER.
       01 Job USAGE POINTER.
       01 ExpectationValues USAGE POINTER.
       01 BACKEND-NAME PIC X(32) VALUE "ibm_torino".
       01 TMP_QUBIT PIC S9(5).

       PROCEDURE DIVISION.
       000-Main.
           DISPLAY "Building QAOA Ansatz Circuit.".
           MOVE 4 to NUM_QUBITS.
           MOVE 4 to NUM_CLBITS.
           CALL 'QiskitCreateCircuit' USING
               BY VALUE NUM_QUBITS, NUM_CLBITS,
               BY REFERENCE CIRCUIT.
           PERFORM VARYING TMP_QUBIT FROM 0 BY 1
               UNTIL TMP_QUBIT > 3
               MOVE TMP_QUBIT to QUBIT(1)
               CALL 'QiskitCircuitGate' USING BY VALUE H_GATE,
                   BY REFERENCE Circuit,
                   BY REFERENCE GateQubits,
                   BY REFERENCE GateParams
           END-PERFORM.

           PERFORM VARYING TMP_QUBIT FROM 0 BY 1
               UNTIL TMP_QUBIT > 3
               MOVE TMP_QUBIT TO QUBIT(1)
               IF TMP_QUBIT = 3
                   MOVE 0 TO QUBIT(2)
               ELSE
                   ADD 1 TO TMP_QUBIT
                   MOVE TMP_QUBIT TO QUBIT(2)
                   SUBTRACT 1 FROM TMP_QUBIT
               END-IF
               MOVE 6.283 TO PARAM(1)
               CALL 'QiskitCircuitGate' USING BY VALUE RZZ_GATE,
                   BY REFERENCE Circuit,
                   BY REFERENCE GateQubits,
                   BY REFERENCE GateParams
           END-PERFORM.

           PERFORM VARYING TMP_QUBIT FROM 0 BY 1
               UNTIL TMP_QUBIT > 3
               MOVE TMP_QUBIT TO QUBIT(1)
               MOVE 3.141 TO PARAM(1)
               CALL 'QiskitCircuitGate' USING BY VALUE RX_GATE,
                   BY REFERENCE Circuit,
                   BY REFERENCE GateQubits,
                   BY REFERENCE GateParams
           END-PERFORM.
           DISPLAY "Building Cost Hamiltonian".
      / Build Cost Hamiltonian
           CALL 'QiskitZeroObs' USING BY VALUE NUM_QUBITS
               BY REFERENCE Observable.
      / Z Term
           MOVE 1 TO TERM(1).
      / Z Term
           MOVE 1 TO TERM(2).
      / Add ZZ term to (0, 1), (1, 2), (2, 3), (3, 0)
           PERFORM VARYING TMP_QUBIT FROM 0 BY 1
               UNTIL TMP_QUBIT > 3
               MOVE TMP_QUBIT to IDX(1)
               IF TMP_QUBIT = 3
                   MOVE 0 TO IDX(2)
               ELSE
                   ADD 1 TO TMP_QUBIT
                   MOVE TMP_QUBIT TO IDX(2)
                   SUBTRACT 1 FROM TMP_QUBIT
               END-IF
               CALL 'QiskitAddTerm' USING
                   BY VALUE NUM_QUBITS,
                   BY VALUE NumBitTerms,
                   BY REFERENCE Coeff_COMPLEX,
                   BY REFERENCE Terms,
                   BY REFERENCE Term_Indices,
                   BY REFERENCE Observable
           END-PERFORM.
           CALL 'ServiceNew' USING BY REFERENCE SERVICE.
           CALL 'BackendByName' USING
               BY REFERENCE Service,
               BY REFERENCE BACKEND-NAME,
               BY REFERENCE Backend.
           IF Backend = NULL
               DISPLAY "Invalid backend 'ibm_torino'"
               STOP RUN
           END-IF.
           CALL 'ExecuteEstimator' USING
               BY REFERENCE Service,
               BY REFERENCE Backend,
               BY REFERENCE Circuit,
               BY REFERENCE Job,
               BY REFERENCE Observable.
           CALL 'EstimatorJobResults' USING
               BY REFERENCE Service,
               BY REFERENCE Job,
               BY REFERENCE ExpectationValues.
           call 'qkrt_expectation_values_get_ev' USING
               BY VALUE ExpectationValues,
               BY VALUE 0
               RETURNING EV.
           DISPLAY ""
           DISPLAY "Result:"
           DISPLAY "Expectation Value: " EV.
           STOP RUN.

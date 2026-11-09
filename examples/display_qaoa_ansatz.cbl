      / This code is part of Qiskit Qobol.
      /
      / (C) Copyright Matthew Treinish 2026.
      /
      / This code is licensed under the Apache License, Version 2.0. You may
      / obtain a copy of this license in the LICENSE.txt file in the root directory
      / of this source tree or at http://www.apache.org/licenses/LICENSE-2.0.
      /
      / Any modifications or derivative works of this code must retain this
      / copyright notice, and modified files need to carry a notice indicating
      / that they have been altered from the originals.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. display_qaoa_ansatz.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NUM_QUBITS USAGE BINARY-LONG UNSIGNED.
       01 NUM_CLBITS USAGE BINARY-LONG UNSIGNED.
       01 H_GATE USAGE BINARY-CHAR UNSIGNED VALUE 1.
       01 RZX_GATE USAGE BINARY-CHAR UNSIGNED VALUE 42.
       01 RX_GATE USAGE BINARY-CHAR UNSIGNED VALUE 8.
       01 QUBIT_MEASURE USAGE BINARY-LONG VALUE 0.
       01 CLBIT_MEASURE USAGE BINARY-LONG VALUE 0.
       01 GateQubits.
           02 QUBIT BINARY-LONG UNSIGNED OCCURS 3 TIMES.
       01 GateParams.
           02 PARAM USAGE COMP-2 OCCURS 3 TIMES.
       01 TMP_QUBIT PIC S9(5).
       01 CIRCUIT USAGE POINTER.

       PROCEDURE DIVISION.
       000-Main.
           DISPLAY "Building Bell Circuit.".
           MOVE 10 to NUM_QUBITS.
           MOVE 10 to NUM_CLBITS.
           CALL 'QiskitCreateCircuit' USING
               BY VALUE NUM_QUBITS, NUM_CLBITS,
               BY REFERENCE CIRCUIT.
           PERFORM VARYING TMP_QUBIT FROM 0 BY 1
               UNTIL TMP_QUBIT > 9
               MOVE TMP_QUBIT to QUBIT(1)
               CALL 'QiskitCircuitGate' USING BY VALUE H_GATE,
                   BY REFERENCE Circuit,
                   BY REFERENCE GateQubits,
                   BY REFERENCE GateParams
           END-PERFORM.
           PERFORM VARYING TMP_QUBIT FROM 0 BY 1
               UNTIL TMP_QUBIT > 9
               MOVE TMP_QUBIT TO QUBIT(1)
               IF TMP_QUBIT = 9
                   MOVE 0 TO QUBIT(2)
               ELSE
                   ADD 1 TO TMP_QUBIT
                   MOVE TMP_QUBIT TO QUBIT(2)
                   SUBTRACT 1 FROM TMP_QUBIT
               END-IF
               MOVE 0.392699081698724 TO PARAM(1)
               CALL 'QiskitCircuitGate' USING BY VALUE RZX_GATE,
                   BY REFERENCE Circuit,
                   BY REFERENCE GateQubits,
                   BY REFERENCE GateParams
           END-PERFORM.
           PERFORM VARYING TMP_QUBIT FROM 0 BY 1
               UNTIL TMP_QUBIT > 9
               MOVE TMP_QUBIT TO QUBIT(1)
               MOVE 3.141592653589793 TO PARAM(1)
               CALL 'QiskitCircuitGate' USING BY VALUE RX_GATE,
                   BY REFERENCE Circuit,
                   BY REFERENCE GateQubits,
                   BY REFERENCE GateParams
           END-PERFORM.
           PERFORM VARYING TMP_QUBIT FROM 0 BY 1
               UNTIL TMP_QUBIT > 9
               SET QUBIT_MEASURE TO TMP_QUBIT
               MOVE TMP_QUBIT TO CLBIT_MEASURE
               CALL 'QiskitCircuitMeasure' USING BY VALUE QUBIT_MEASURE,
                   CLBIT_MEASURE, BY REFERENCE Circuit
           END-PERFORM.
           CALL 'QiskitCircuitDraw' USING
               BY REFERENCE CIRCUIT.
           STOP RUN.

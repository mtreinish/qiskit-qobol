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
       01 H_GATE USAGE BINARY-SHORT VALUE 1.
       01 CX_GATE USAGE BINARY-SHORT VALUE 20.
       01 QUBIT_MEASURE USAGE BINARY-LONG VALUE 0.
       01 CLBIT_MEASURE USAGE BINARY-LONG VALUE 0.
       01 GateQubits USAGE BINARY-SHORT UNSIGNED OCCURS 2 TIMES.
       01 CIRCUIT USAGE POINTER.

       PROCEDURE DIVISION.
       000-Main.
           DISPLAY "Building Bell Circuit.".
           MOVE 2 to NUM_QUBITS.
           MOVE 2 to NUM_CLBITS.
           CALL 'QiskitCreateCircuit' USING BY VALUE NUM_QUBITS,
           NUM_CLBITS, BY REFERENCE CIRCUIT.
           MOVE 0 to GateQubits(1);
      / Below this still isn't working yet
           CALL 'QiskitCircuitGateNoParams' USING BY VALUE H_GATE, 
               BY REFERENCE GateQubits(1), Circuit.
           MOVE 0 to GateQubits(1);
           MOVE 1 to GateQubits(2);
           CALL 'QiskitCircuitGateNoParams' USING BY VALUE CX_GATE, 
               BY REFERENCE GateQubits(1), Circuit.
           CALL 'QiskitCircuitMeasure' USING BY VALUE QUBIT_MEASURE,
               CLBIT_MEASURE, BY REFERENCE Circuit.
           MOVE 1 to QUBIT_MEASURE, CLBIT_MEASURE.
           CALL 'QiskitCircuitMeasure' USING BY VALUE QUBIT_MEASURE,
               CLBIT_MEASURE, BY REFERENCE Circuit.
           STOP RUN.

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
       01 NUM_QUBITS BINARY-LONG VALUE 2.
       01 NUM_CLBITS BINARY-LONG VALUE 2.
       01 H_GATE BINARY-SHORT VALUE 1.
       01 CX_GATE BINARY-SHORT VALUE 20.
       01 QUBIT_MEASURE BINARY-LONG VALUE 0.
       01 CLBIT_MEASURE BINARY-LONG VALUE 0.
       01 CIRCUIT USAGE POINTER.

       PROCEDURE DIVISION.
       000-Main.
           DISPLAY "Building Bell Circuit.".
           CALL 'QiskitCreateCircuit' USING NUM_QUBITS, NUM_CLBITS,
               CIRCUIT.
           CALL 'QiskitCircuitGate' USING CIRCUIT, H_GATE.
           CALL 'QiskitCircuitGate' USING CIRCUIT, CX_GATE.
           CALL 'QiskitCircuitMeasure' USING CIRCUIT, QUBIT_MEASURE,
           CLBIT_MEASURE.
           MOVE 1 to QUBIT_MEASURE, CLBIT_MEASURE.
           CALL 'QiskitCircuitMeasure' USING CIRCUIT, QUBIT_MEASURE,
           CLBIT_MEASURE.
           STOP RUN.

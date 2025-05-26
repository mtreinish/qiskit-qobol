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
       PROGRAM-ID. QiskitCircuitGateNoParams.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01 Gate BINARY-SHORT UNSIGNED.
       01 Circuit USAGE POINTER.
       01 GateQubits BINARY-SHORT UNSIGNED OCCURS 10 TIMES.

       PROCEDURE DIVISION USING BY VALUE Gate, BY
           REFERENCE GateQubits, Circuit.
       000-Main.
           DISPLAY "Circuit: ", Circuit.
           DISPLAY "GATE: ", Gate.
           DISPLAY "GateQubits: ", GateQubits(1).
           call 'qk_circuit_gate' USING BY REFERENCE Circuit,
                                        BY VALUE Gate,
                                        BY REFERENCE GateQubits(1),
                                        BY REFERENCE NULL.
           GOBACK.

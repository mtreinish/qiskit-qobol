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
       PROGRAM-ID. QiskitCircuitGate.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01 Gate BINARY-SHORT UNSIGNED.
       01 Circuit USAGE POINTER.
       01 GateNumQubits BINARY-LONG UNSIGNED.
       01 GateQubits.
           02 QUBITS OCCURS 10 TIMES
                  DEPENDING ON GateNumQubits.
               03 QUBIT BINARY-SHORT UNSIGNED.
       01 GateNumParams BINARY-LONG UNSIGNED.
       01 GateParams.
           02 PARMS OCCURS 3 TIMES
                 DEPENDING ON GateNumParams.
               03 PARAM COMP-2.

       PROCEDURE DIVISION USING BY VALUE Gate, BY
           REFERENCE GateQubits, GateParams, Circuit.
       000-Main.
           call 'qk_circuit_gate' USING BY REFERENCE Circuit,
                                        BY CONTENT Gate,
                                        BY REFERENCE GateQubits,
                                        BY REFERENCE GateParams.
           GOBACK.

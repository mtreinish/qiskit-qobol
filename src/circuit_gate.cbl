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
       01 GateNumParams USAGE BINARY-LONG UNSIGNED.

       LINKAGE SECTION.
       01 Gate BINARY-SHORT UNSIGNED.
       01 Circuit USAGE POINTER.
       01 GateQubits.
           02 QUBIT BINARY-SHORT UNSIGNED OCCURS 3 TIMES.
       01 GateParams.
           02 PARAM COMP-2 OCCURS 3 TIMES.

       PROCEDURE DIVISION USING BY VALUE Gate, BY
           REFERENCE Circuit, GateQubits, GateParams.
       000-Main.
           CALL 'qk_gate_num_params' USING BY VALUE Gate
               RETURNING GateNumParams.
           CALL 'qk_circuit_gate' USING BY VALUE Circuit,
                                  BY VALUE Gate,
                                  BY VALUE ADDRESS OF GateQubits,
                                  BY VALUE ADDRESS OF GateParams.
           GOBACK.

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
       PROGRAM-ID. QiskitCreateCircuit.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01 NumQubits USAGE BINARY-LONG UNSIGNED.
       01 NumClbits USAGE BINARY-LONG UNSIGNED.
       01 Circuit USAGE POINTER.
           
       PROCEDURE DIVISION USING BY VALUE NumQubits, NumClbits, BY
           REFERENCE Circuit.
       000-Main.
           DISPLAY "Creating new circuit with qubits: " NumQubits.
           DISPLAY "CLBITS: " NumClbits.
           call 'qk_circuit_new' USING BY VALUE NumQubits,
                                       BY VALUE NumClbits,
                                       RETURNING Circuit.
           GOBACK.

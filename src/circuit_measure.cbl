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
       PROGRAM-ID. QiskitCircuitMeasure.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01 Circuit USAGE POINTER.
       01 QUBIT BINARY-LONG UNSIGNED.
       01 CLBIT BINARY-LONG UNSIGNED.

       PROCEDURE DIVISION USING BY VALUE QUBIT, CLBIT, BY
           REFERENCE Circuit.
       000-Main.
           call 'qk_circuit_measure' USING BY VALUE Circuit,
                                           BY VALUE QUBIT,
                                           BY VALUE CLBIT.
           GOBACK.

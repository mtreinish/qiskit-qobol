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
       PROGRAM-ID. ExpectationValuesCount.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 EV_COUNT BINARY-LONG UNSIGNED VALUE 0.

       LINKAGE SECTION.
       01 EVS USAGE POINTER.

       PROCEDURE DIVISION USING EVS.
       000-Main.
           CALL 'qkrt_expectation_values_num_evs' USING
               BY VALUE  EVS,
               RETURNING EV_COUNT.
           GOBACK RETURNING EV_COUNT.

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
       PROGRAM-ID. DisplayExpectationValues.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDX USAGE BINARY-LONG UNSIGNED VALUE 0.
       01 EVS_COPY.
          02 EV USAGE COMP-2 OCCURS 1 TO 512 TIMES
           DEPENDING ON EV_COUNT.

       LINKAGE SECTION.
       01 EV_COUNT USAGE BINARY-LONG UNSIGNED.
       01 EVS USAGE POINTER.

       PROCEDURE DIVISION USING BY REFERENCE EVS, BY VALUE EV_COUNT.
       000-Main.
           DISPLAY " "
           CALL 'qkrt_expectation_values_copy_into' USING
               BY VALUE EVS,
               BY VALUE ADDRESS OF EVS_COPY.
           DISPLAY "Expectation Values:"
           PERFORM VARYING IDX FROM 1 BY 1
               UNTIL IDX > EV_COUNT
               DISPLAY EV(IDX)
           END-PERFORM.
           GOBACK.

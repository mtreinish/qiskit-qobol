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
       PROGRAM-ID. EstimatorJobResults.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 StatusCode PIC 9(10) COMP-5.
       01 ReturnCode PIC S9(10) COMP-5.
       01 PrevStatus PIC 9(10) COMP-5 VALUE 999.
       01 StatusName PIC X(8).
       01 SLEEP-TIME.
          02 SLEEP-SECS PIC 9(9) COMP-5 VALUE 5.
          02 SLEEP-NS PIC 9(9) COMP-5 VALUE 0.
       01 EV_COUNT USAGE BINARY-LONG UNSIGNED.
       01 IDX USAGE BINARY-LONG UNSIGNED VALUE 0.
       01 EVS.
          02 EV USAGE COMP-2 OCCURS 1 TO 512 TIMES
           DEPENDING ON NumExpectationValues.

       LINKAGE SECTION.
       01 Service USAGE POINTER.
       01 Job USAGE POINTER.
       01 ExpectationValues USAGE POINTER.
       01 NumExpectationValues USAGE BINARY-LONG UNSIGNED.

       PROCEDURE DIVISION USING BY REFERENCE Service, Job,
           ExpectationValues BY VALUE NumExpectationValues.
       000-Main.
           PERFORM 100-Poll-Status.
           DISPLAY " ".
           IF STATUSCODE > 2
               DISPLAY "Job returned an unknown status"
               STOP RUN
           END-IF.
           PERFORM 200-Fetch-Results.
           GOBACK.

       100-Poll-Status.
           PERFORM WITH TEST AFTER UNTIL StatusCode > 1
               CALL "CBL_GC_NANOSLEEP" USING SLEEP-TIME
               CALL 'qkrt_job_status' USING
                   BY VALUE ADDRESS OF StatusCode,
                   BY VALUE Service,
                   BY VALUE Job
                   RETURNING ReturnCode
               IF StatusCode NOT = PrevStatus
                   EVALUATE StatusCode
                       WHEN 0 MOVE "PENDING" TO StatusName
                       WHEN 1 MOVE "RUNNING" TO StatusName
                       WHEN 2 MOVE "DONE" TO StatusName
                       WHEN OTHER MOVE "UNKNOWN" TO StatusName
                   END-EVALUATE
                   DISPLAY "Job status: "
                       FUNCTION TRIM(StatusName)
                   MOVE StatusCode TO PrevStatus
               END-IF
           END-PERFORM.

       200-Fetch-Results.
           CALL 'qkrt_estimator_job_results' USING
               BY VALUE ADDRESS OF ExpectationValues,
               BY VALUE Service,
               BY VALUE Job
               RETURNING ReturnCode.
           IF ReturnCode > 0
               DISPLAY "Job result query errored."
               STOP RUN
           END-IF.
           CALL 'qkrt_expectation_values_num_evs' USING
               BY VALUE  ExpectationValues
               RETURNING EV_COUNT.
           DISPLAY " "
           CALL 'qkrt_expectation_values_copy_into' USING
               BY VALUE ExpectationValues
               BY VALUE ADDRESS OF EVS.
           DISPLAY "Expectation Values:"
           PERFORM VARYING IDX FROM 1 BY 1
               UNTIL IDX > EV_COUNT
               DISPLAY EV(IDX)
           END-PERFORM.

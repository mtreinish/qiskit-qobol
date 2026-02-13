      / This code is part of Qiskit Qobol.
      /
      / (C) Copyright Ian Hincks 2026.
      /
      / This code is licensed under the Apache License, Version 2.0. You may
      / obtain a copy of this license in the LICENSE.txt file in the root directory
      / of this source tree or at http://www.apache.org/licenses/LICENSE-2.0.
      /
      / Any modifications or derivative works of this code must retain this
      / copyright notice, and modified files need to carry a notice indicating
      / that they have been altered from the originals.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. Histogram.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NumSamples PIC 9(18) COMP-5.
       01 SampleIdx PIC 9(18) COMP-5.
       01 SampleStr USAGE POINTER.
       01 CurrentSample PIC X(128).
       01 HISTOGRAM-TABLE.
          02 HISTOGRAM-ENTRY OCCURS 1024 TIMES.
             03 HIST-VALUE PIC X(128).
             03 HIST-COUNT PIC 9(10) COMP-5.
       01 NumDistinct PIC 9(10) COMP-5 VALUE 0.
       01 FoundFlag PIC 9 VALUE 0.
       01 SearchIdx PIC 9(10) COMP-5.
       01 DisplayIdx PIC 9(10) COMP-5.
       01 EditedNum PIC Z(9)9.

       LINKAGE SECTION.
       01 Samples USAGE POINTER.
       01 CSampleStr PIC X(128).

       PROCEDURE DIVISION USING BY REFERENCE Samples.
       000-Main.
           CALL 'qkrt_samples_num_samples' USING
               BY VALUE Samples
               RETURNING NumSamples.
           MOVE NumSamples TO EditedNum.
           DISPLAY "Number of samples: "
               FUNCTION TRIM(EditedNum).
           MOVE 0 TO NumDistinct.
           INITIALIZE HISTOGRAM-TABLE.
           PERFORM VARYING SampleIdx FROM 0 BY 1
               UNTIL SampleIdx >= NumSamples
               CALL 'qkrt_samples_get_sample' USING
                   BY VALUE Samples,
                   BY VALUE SampleIdx
                   RETURNING SampleStr
               SET ADDRESS OF CSampleStr TO SampleStr
               MOVE SPACES TO CurrentSample
               STRING CSampleStr DELIMITED BY x"00"
                   INTO CurrentSample
               PERFORM 100-Tally-Sample
               CALL 'qkrt_str_free' USING BY VALUE SampleStr
           END-PERFORM.
           CALL 'qkrt_samples_free' USING BY VALUE Samples.
           PERFORM 200-Display-Histogram.
           GOBACK.

       100-Tally-Sample.
           MOVE 0 TO FoundFlag.
           PERFORM VARYING SearchIdx FROM 1 BY 1
               UNTIL SearchIdx > NumDistinct OR FoundFlag = 1
               IF HIST-VALUE(SearchIdx) = CurrentSample
                   ADD 1 TO HIST-COUNT(SearchIdx)
                   MOVE 1 TO FoundFlag
               END-IF
           END-PERFORM.
           IF FoundFlag = 0
               ADD 1 TO NumDistinct
               MOVE CurrentSample TO HIST-VALUE(NumDistinct)
               MOVE 1 TO HIST-COUNT(NumDistinct)
           END-IF.

       200-Display-Histogram.
           DISPLAY " ".
           DISPLAY "Results:".
           PERFORM VARYING DisplayIdx FROM 1 BY 1
               UNTIL DisplayIdx > NumDistinct
               MOVE HIST-COUNT(DisplayIdx) TO EditedNum
               DISPLAY "  "
                   FUNCTION TRIM(HIST-VALUE(DisplayIdx))
                   ": " FUNCTION TRIM(EditedNum)
           END-PERFORM.

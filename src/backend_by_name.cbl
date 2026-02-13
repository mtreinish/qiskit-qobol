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
       PROGRAM-ID. BackendByName.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Results USAGE POINTER.
       01 DataPtr USAGE POINTER.
       01 ResultCount PIC 9(18) COMP-5.
       01 Idx PIC 9(18) COMP-5.
       01 NamePtr USAGE POINTER.
       01 CNameBuffer PIC X(32).
       01 Found PIC 9 VALUE 0.

       LINKAGE SECTION.
       01 Service USAGE POINTER.
       01 BackendName PIC X(32).
       01 Backend USAGE POINTER.
       01 BackendArray.
          02 BackendPtr USAGE POINTER OCCURS 256 TIMES.
       01 CNameStr PIC X(32).

       PROCEDURE DIVISION USING BY REFERENCE Service, BackendName,
           Backend.
       000-Main.
           CALL 'qkrt_backend_search' USING
               BY VALUE ADDRESS OF Results
               BY VALUE Service.
           CALL 'qkrt_backend_search_results_length' USING
               BY VALUE Results
               RETURNING ResultCount.
           CALL 'qkrt_backend_search_results_data' USING
               BY VALUE Results
               RETURNING DataPtr.
           SET ADDRESS OF BackendArray TO DataPtr.
           MOVE 0 TO Found.
           PERFORM VARYING Idx FROM 1 BY 1
               UNTIL Idx > ResultCount OR Found = 1
               CALL 'qkrt_backend_name' USING
                   BY VALUE BackendPtr(Idx)
                   RETURNING NamePtr
               SET ADDRESS OF CNameStr TO NamePtr
               MOVE SPACES TO CNameBuffer
               STRING CNameStr DELIMITED BY x"00"
                   INTO CNameBuffer
               IF FUNCTION TRIM(CNameBuffer)
                   = FUNCTION TRIM(BackendName)
                   SET Backend TO BackendPtr(Idx)
                   MOVE 1 TO Found
               END-IF
           END-PERFORM.
           IF Found = 0
               DISPLAY "Backend not found: "
                   FUNCTION TRIM(BackendName)
               SET Backend TO NULL
           END-IF.
           GOBACK.

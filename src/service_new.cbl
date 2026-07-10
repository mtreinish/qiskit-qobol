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
       PROGRAM-ID. ServiceNew.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 CONFIG.
           02 TOKEN USAGE POINTER.
           02 URL USAGE POINTER.
           02 USER_AGENT USAGE POINTER.
           02 FILENAME USAGE POINTER.
           02 ACCOUNT_NAME USAGE POINTER.
      *> Null-terminated because its address is passed to C.
       01 COBOL_USER_AGENT PIC X(17)0 VALUE "QISKIT_QOBOL/0.1".

       LINKAGE SECTION.
       01 Service USAGE POINTER.
       PROCEDURE DIVISION USING BY REFERENCE Service.
       000-Main.
           SET USER_AGENT TO ADDRESS OF COBOL_USER_AGENT.
           SET TOKEN TO NULL.
           SET FILENAME TO NULL.
           SET URL TO NULL.
           SET ACCOUNT_NAME to NULL
           CALL 'qkrt_service_new_from_config' USING BY VALUE 
               ADDRESS OF CONFIG,
               BY VALUE ADDRESS OF Service.
           GOBACK.

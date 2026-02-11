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
       PROGRAM-ID. LeastBusyBackend.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Results USAGE POINTER.


       LINKAGE SECTION.
       01 Service USAGE POINTER.
       01 Backend USAGE POINTER.
           
       PROCEDURE DIVISION USING BY REFERENCE Service, Backend.
       000-Main.
           CALL 'qkrt_backend_search' USING 
               BY VALUE ADDRESS OF Results
               BY VALUE Service.
           CALL 'qkrt_backend_search_results_least_busy' USING
               BY VALUE Results
               RETURNING Backend.
           GOBACK.

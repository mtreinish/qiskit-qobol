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
       PROGRAM-ID. ExecuteSampler.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Target USAGE POINTER.
       01 Job USAGE POINTER.
       01 TranspileResults.
          02 TRANSPILED_CIRCUIT USAGE POINTER.
          02 TRANSPILE_LAYOUT USAGE POINTER.
       01 TRANSPILE_OPTIONS.
          02 optimization_level BINARY-SHORT UNSIGNED VALUE 2.
          02 seed BINARY-LONG VALUE 42.
          02 approximation_degree COMP-2 VALUE 1.0. 
       01 SHOTS BINARY-LONG VALUE 10000. 

       LINKAGE SECTION.
       01 Service USAGE POINTER.
       01 Backend USAGE POINTER.
       01 Circuit USAGE POINTER.
           
       PROCEDURE DIVISION USING BY REFERENCE Service, Backend, Circuit.
       000-Main.
           CALL 'qkrt_get_backend_target' USING 
               BY VALUE Service
               BY VALUE Backend
               RETURNING Target.
           CALL 'qk_transpile' USING
               BY VALUE CIRCUIT,
               BY VALUE TARGET,
               BY VALUE ADDRESS OF TRANSPILE_OPTIONS,
               BY VALUE ADDRESS OF TranspileResults,
               BY VALUE 0.
           CALL 'qkrt_sampler_job_run' USING
               BY VALUE ADDRESS OF Job,
               BY VALUE Service,
               BY VALUE Backend,
               BY VALUE TRANSPILED_CIRCUIT,
               BY VALUE SHOTS,
               BY VALUE 0.
           
           GOBACK.

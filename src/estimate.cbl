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
       PROGRAM-ID. ExecuteEstimator.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Target USAGE POINTER.
       01 TranspileResults.
          02 TRANSPILED_CIRCUIT USAGE POINTER.
          02 TRANSPILE_LAYOUT USAGE POINTER.
       01 TRANSPILE_OPTIONS.
          02 optimization_level PIC 9(2) COMP-5 VALUE 2.
          02 FILLER PIC X(7).
          02 seed PIC S9(18) COMP-5 VALUE 42.
          02 approximation_degree USAGE COMP-2 VALUE 1.0.
       01 SHOTS BINARY-LONG VALUE 1000.
       01 FINAL_LAYOUT USAGE BINARY-LONG UNSIGNED OCCURS 512 TIMES.
       01 NUM_OUTPUT_QUBITS USAGE BINARY-LONG UNSIGNED.
       01 RET_CODE USAGE BINARY-LONG UNSIGNED.

       LINKAGE SECTION.
       01 Service USAGE POINTER.
       01 Backend USAGE POINTER.
       01 Circuit USAGE POINTER.
       01 Job USAGE POINTER.
       01 Observable USAGE POINTER.

       PROCEDURE DIVISION USING BY REFERENCE Service, Backend, Circuit,
           Job, Observable.
       000-Main.
           CALL 'qkrt_get_backend_target' USING
               BY VALUE Service
               BY VALUE Backend
               RETURNING Target.
           CALL 'qk_transpile' USING
               BY VALUE CIRCUIT,
               BY VALUE TARGET,
               BY REFERENCE TRANSPILE_OPTIONS,
               BY VALUE ADDRESS OF TranspileResults,
               BY VALUE 0.
           CALL 'qk_transpile_layout_num_output_qubits' USING
               BY VALUE TRANSPILE_LAYOUT
               RETURNING NUM_OUTPUT_QUBITS.
           CALL 'qk_transpile_layout_final_layout' USING
               BY VALUE TRANSPILE_LAYOUT,
               BY VALUE 0,
               BY REFERENCE FINAL_LAYOUT(1).
           CALL 'qk_obs_apply_layout' USING
               BY VALUE Observable,
               BY REFERENCE FINAL_LAYOUT(1)
               BY VALUE NUM_OUTPUT_QUBITS
               RETURNING RET_CODE.
           CALL 'qkrt_estimator_job_run' USING
               BY VALUE ADDRESS OF JOB,
               BY VALUE Service,
               BY VALUE Backend,
               BY VALUE TRANSPILED_CIRCUIT,
               BY VALUE Observable,
               BY VALUE 0.
           GOBACK.

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
       REMARKS.
           This function takes a pointer to a Samples return from Qiskit
           IBM Runtime C and will display the counts of those samples to
           STDOUT using qkrt_counts_display.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Counts USAGE POINTER.

       LINKAGE SECTION.
       01 Samples USAGE POINTER.

       PROCEDURE DIVISION USING BY REFERENCE Samples.
       000-Main.
           CALL 'qkrt_samples_to_counts' USING
               BY VALUE Samples
               RETURNING Counts.
           CALL 'qkrt_counts_display' USING
               BY VALUE Counts.
           CALL 'qkrt_counts_free' USING BY VALUE Counts.
           GOBACK.

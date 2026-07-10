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
       PROGRAM-ID. QiskitAddTerm.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Term.
           02 TERM_COEFF.
               03 TERM_RE USAGE COMP-2.
               03 TERM_IM USAGE COMP-2.
           02 LEN USAGE BINARY-DOUBLE UNSIGNED.
           02 BIT_TERMS USAGE POINTER.
           02 INDICES_ARR USAGE POINTER.
           02 NUM_QUBITS USAGE BINARY-LONG UNSIGNED.
           02 FILLER PIC X(4).

       LINKAGE SECTION.
       01 NumQubits USAGE BINARY-LONG UNSIGNED.
       01 NumBitTerms USAGE BINARY-LONG UNSIGNED.
       01 BitTerms.
           02 BIT_TERM USAGE BINARY-CHAR UNSIGNED
               OCCURS 1 TO 512 TIMES
               DEPENDING ON NumBitTerms.
       01 Indices.
           02 IDX USAGE BINARY PIC S9(5)
               OCCURS 1 TO 512 TIMES
               DEPENDING ON NumBitTerms.
       01 Coeff.
           02 RE USAGE COMP-2.
           02 IM USAGE COMP-2.
       01 Observable USAGE POINTER.

       PROCEDURE DIVISION USING BY VALUE NumQubits, NumBitTerms,
           BY REFERENCE Coeff, BitTerms, Indices, Observable.
       000-Main.
           MOVE NumQubits TO NUM_QUBITS.
           MOVE NumBitTerms TO LEN.
           SET BIT_TERMS TO ADDRESS OF BitTerms.
           SET INDICES_ARR TO ADDRESS OF Indices.
           MOVE Coeff to TERM_COEFF.
           call 'qk_obs_add_term' USING BY VALUE Observable,
                                        BY REFERENCE Term.
           GOBACK.

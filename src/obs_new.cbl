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
       PROGRAM-ID. QiskitZeroObs.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01 NumQubits USAGE BINARY-LONG UNSIGNED.
       01 Observable USAGE POINTER.

       PROCEDURE DIVISION USING BY VALUE NumQubits, BY
           REFERENCE Observable.
       000-Main.
           call 'qk_obs_zero' USING BY VALUE NumQubits,
                                    RETURNING Observable.
           GOBACK.

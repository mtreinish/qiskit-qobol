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
       PROGRAM-ID. QiskitCircuitDraw.
       REMARKS.
           Takes in a pointer to a Qiskit Circuit and will
           use the DISPLAY statement to print a circuit diagram.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 DrawConfig.
           02 bundle_cregs PIC 1 VALUE 0.
           02 merge_wires PIC 1 VALUE 1.
           02 fold PIC X(64) VALUE 120.
           02 barrier_label_len PIC X(64) VALUE 0.
       01 CircuitDiagram USAGE POINTER.
       01 POS USAGE POINTER.
       01 CircuitDiagramChar PIC X BASED.

       LINKAGE SECTION.
       01 Circuit USAGE POINTER.

       PROCEDURE DIVISION USING BY REFERENCE Circuit.
       000-Main.
           CALL 'qk_circuit_draw' USING BY VALUE Circuit,
                                  BY VALUE ADDRESS OF DrawConfig
                                  RETURNING CircuitDiagram.
           SET POS TO CircuitDiagram.
           SET ADDRESS OF CircuitDiagramChar TO POS.
           PERFORM WITH TEST AFTER UNTIL CircuitDiagramChar = x"00"
               SET ADDRESS OF CircuitDiagramChar TO POS
               IF CircuitDiagramChar = x"00"
                   EXIT PERFORM
               END-IF
               DISPLAY CircuitDiagramChar WITH NO ADVANCING
               SET POS UP BY 1
           END-PERFORM.
           CALL 'qk_str_free' USING BY VALUE CircuitDiagram.
           GOBACK.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. QiskitCircuitMeasure.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01 Circuit USAGE POINTER.
       01 QUBIT BINARY-LONG UNSIGNED.
       01 CLBIT BINARY-LONG UNSIGNED.

       PROCEDURE DIVISION USING BY VALUE QUBIT, CLBIT, BY
           REFERENCE Circuit.
       000-Main.
           call 'qk_circuit_measure' USING BY REFERENCE Circuit,
                                           BY CONTENT QUBIT,
                                           BY CONTENT CLBIT,
           GOBACK.

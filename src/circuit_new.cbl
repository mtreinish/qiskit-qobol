       IDENTIFICATION DIVISION.
       PROGRAM-ID. QiskitCreateCircuit.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01 NumQubits BINARY-LONG UNSIGNED.
       01 NumClbits BINARY-LONG UNSIGNED.
       01 Circuit USAGE POINTER.
           
       PROCEDURE DIVISION USING BY VALUE NumQubits, NumClbits, BY
           REFERENCE Circuit.
       000-Main.
           call 'qk_circuit_new' USING BY CONTENT NumQubits,
                                       BY CONTENT NumClbits,
                                       RETURNING Circuit.
           GOBACK.

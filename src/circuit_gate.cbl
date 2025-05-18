       IDENTIFICATION DIVISION.
       PROGRAM-ID. QiskitCircuitGate.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       LINKAGE SECTION.
       01 Gate BINARY-SHORT UNSIGNED.
       01 Circuit USAGE POINTER.
       01 GateNumQubits BINARY-LONG UNSIGNED.
       01 GateQubits.
           02 QUBITS OCCURS 10 TIMES
                  DEPENDING ON GateNumQubits.
               03 QUBIT BINARY-SHORT UNSIGNED.
       01 GateNumParams BINARY-LONG UNSIGNED.
       01 GateParams.
           02 PARMS OCCURS 3 TIMES
                 DEPENDING ON GateNumParams.
               03 PARAM COMP-2.

       PROCEDURE DIVISION USING BY VALUE Gate, BY
           REFERENCE GateQubits, GateParams, Circuit.
       000-Main.
           call 'qk_circuit_gate' USING BY REFERENCE Circuit,
                                        BY CONTENT Gate,
                                        BY REFERENCE GateQubits,
                                        BY REFERENCE GateParams.
           GOBACK.

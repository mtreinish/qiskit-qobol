/* This code is part of Qiskit Qobol.
 *
 * (C) Copyright Matthew Treinish 2026.
 *
 * This code is licensed under the Apache License, Version 2.0. You may
 * obtain a copy of this license in the LICENSE.txt file in the root directory
 * of this source tree or at http://www.apache.org/licenses/LICENSE-2.0.
 *
 * Any modifications or derivative works of this code must retain this
 * copyright notice, and modified files need to carry a notice indicating
 * that they have been altered from the originals.
 */

#include <qiskit.h>

// Wrapper for no params to translate no params
QkExitCode qq_circuit_gate_no_params(QkCircuit *circuit, QkGate gate, const uint32_t *qubits) {
    return qk_circuit_gate(circuit, gate, qubits, NULL);
}

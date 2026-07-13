# This code is part of Qiskit Qobol.
# 
# (C) Copyright Matthew Treinish 2026.
# 
# This code is licensed under the Apache License, Version 2.0. You may
# obtain a copy of this license in the LICENSE.txt file in the root directory
# of this source tree or at http://www.apache.org/licenses/LICENSE-2.0.
# 
# Any modifications or derivative works of this code must retain this
# copyright notice, and modified files need to carry a notice indicating
# that they have been altered from the originals.


# This script is setup to build and install the qiskit dependencies
# for qiskit-qobol on linux systems. It requires sudo to be installed
# for installing the library files and headers.

set -e
set -x

which sudo > /dev/null
if [[ $? == 1 ]] ; then
    echo "sudo not installed"
    exit 1
fi

if [[ ! -d build_deps ]] ; then
    mkdir build_deps
fi

pushd build_deps

if [[ ! -d qiskit ]] ; then
    git clone https://github.com/Qiskit/qiskit
fi

pushd qiskit
git checkout 2.3.0
make c
sudo cp dist/c/lib/libqiskit.so /usr/local/lib/.
sudo cp -r dist/c/include/* /usr/local/include/.
popd

if [[ ! -d qiskit-ibm-runtime-c ]] ; then
    git clone https://github.com/Qiskit/qiskit-ibm-runtime-c
fi

pushd qiskit-ibm-runtime-c
git remote add mtreinish https://github.com/mtreinish/qiskit-ibm-runtime-c || true
git fetch mtreinish
git checkout add-user-defined-service-path
git merge mtreinish/evs-copy --no-commit
cargo build --release
sudo cp -r include/* /usr/local/include/.
sudo cp target/release/libqiskit_ibm_runtime.so /usr/local/lib/.
popd
popd

//===-- ModuleUtils.h - Functions to manipulate Modules ---------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This family of functions perform manipulations on Modules.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_TRANSFORMS_UTILS_MODULEUTILS_H
#define LLVM_TRANSFORMS_UTILS_MODULEUTILS_H

#include "llvm/ADT/StringRef.h"
#include <utility> // for std::pair

namespace llvm {

template <typename T> class ArrayRef;
class Module;
class Function;
class GlobalValue;
class GlobalVariable;
class Constant;
class StringRef;
class Value;
class Type;

/// Append F to the list of global ctors of module M with the given Priority.
/// This wraps the function in the appropriate structure and stores it along
/// side other global constructors. For details see
/// http://llvm.org/docs/LangRef.html#intg_global_ctors
void appendToGlobalCtors(Module &M, Function *F, int Priority,
                         Constant *Data = nullptr);

/// Same as appendToGlobalCtors(), but for global dtors.
void appendToGlobalDtors(Module &M, Function *F, int Priority,
                         Constant *Data = nullptr);

// Validate the result of Module::getOrInsertFunction called for an
// interface function of ComprehensiveStaticInstrumentation. If the
// instrumented module defines a function with the same name, their
// prototypes must match, otherwise getOrInsertFunction returns a
// bitcast.
Function *checkCsiInterfaceFunction(Constant *FuncOrBitcast);

// Validate the result of Module::getOrInsertFunction called for an interface
// function of given sanitizer. If the instrumented module defines a function
// with the same name, their prototypes must match, otherwise
// getOrInsertFunction returns a bitcast.
Function *checkSanitizerInterfaceFunction(Constant *FuncOrBitcast);

/// \brief Creates sanitizer constructor function, and calls sanitizer's init
/// function from it.
/// \return Returns pair of pointers to constructor, and init functions
/// respectively.
std::pair<Function *, Function *> createSanitizerCtorAndInitFunctions(
    Module &M, StringRef CtorName, StringRef InitName,
    ArrayRef<Type *> InitArgTypes, ArrayRef<Value *> InitArgs,
    StringRef VersionCheckName = StringRef());

/// Rename all the anon functions in the module using a hash computed from
/// the list of public globals in the module.
bool nameUnamedFunctions(Module &M);

} // End llvm namespace

#endif //  LLVM_TRANSFORMS_UTILS_MODULEUTILS_H

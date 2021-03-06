//===--- Checkers.td - Static Analyzer Checkers -===-----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

include "clang/StaticAnalyzer/Checkers/CheckerBase.td"

//===----------------------------------------------------------------------===//
// Packages.
//===----------------------------------------------------------------------===//

def Experimental : Package<"experimental">;

def Core : Package<"core">;
def CoreBuiltin : Package<"builtin">, InPackage<Core>;
def CoreUninitialized  : Package<"uninitialized">, InPackage<Core>;
def CoreExperimental : Package<"core">, InPackage<Experimental>, Hidden;

def Cplusplus : Package<"cplusplus">;
def CplusplusExperimental : Package<"cplusplus">, InPackage<Experimental>, Hidden;

def DeadCode : Package<"deadcode">;
def DeadCodeExperimental : Package<"deadcode">, InPackage<Experimental>, Hidden;

def Security : Package <"security">;
def InsecureAPI : Package<"insecureAPI">, InPackage<Security>;
def SecurityExperimental : Package<"security">, InPackage<Experimental>, Hidden;
def Taint : Package<"taint">, InPackage<SecurityExperimental>, Hidden;  

def Unix : Package<"unix">;
def UnixExperimental : Package<"unix">, InPackage<Experimental>, Hidden;

def OSX : Package<"osx">;
def OSXExperimental : Package<"osx">, InPackage<Experimental>, Hidden;
def Cocoa : Package<"cocoa">, InPackage<OSX>;
def CocoaExperimental : Package<"cocoa">, InPackage<OSXExperimental>, Hidden;
def CoreFoundation : Package<"coreFoundation">, InPackage<OSX>;

def LLVM : Package<"llvm">;
def Debug : Package<"debug">;

//===----------------------------------------------------------------------===//
// Core Checkers.
//===----------------------------------------------------------------------===//

let ParentPackage = Core in {

def DereferenceChecker : Checker<"NullDereference">,
  HelpText<"Check for dereferences of null pointers">,
  DescFile<"DereferenceChecker.cpp">;

def CallAndMessageChecker : Checker<"CallAndMessage">,
  HelpText<"Check for logical errors for function calls and Objective-C message expressions (e.g., uninitialized arguments, null function pointers)">,
  DescFile<"CallAndMessageChecker.cpp">;

def AdjustedReturnValueChecker : Checker<"AdjustedReturnValue">,
  HelpText<"Check to see if the return value of a function call is different than the caller expects (e.g., from calls through function pointers)">,
  DescFile<"AdjustedReturnValueChecker.cpp">;

def AttrNonNullChecker : Checker<"AttributeNonNull">,
  HelpText<"Check for null pointers passed as arguments to a function whose arguments are marked with the 'nonnull' attribute">,
  DescFile<"AttrNonNullChecker.cpp">;

def VLASizeChecker : Checker<"VLASize">,
  HelpText<"Check for declarations of VLA of undefined or zero size">,
  DescFile<"VLASizeChecker.cpp">;

def DivZeroChecker : Checker<"DivideZero">,
  HelpText<"Check for division by zero">,
  DescFile<"DivZeroChecker.cpp">;

def UndefResultChecker : Checker<"UndefinedBinaryOperatorResult">,
  HelpText<"Check for undefined results of binary operators">,
  DescFile<"UndefResultChecker.cpp">;

def StackAddrEscapeChecker : Checker<"StackAddressEscape">,
  HelpText<"Check that addresses to stack memory do not escape the function">,
  DescFile<"StackAddrEscapeChecker.cpp">;

} // end "core"

let ParentPackage = CoreExperimental in {

def CastSizeChecker : Checker<"CastSize">,
  HelpText<"Check when casting a malloc'ed type T, whether the size is a multiple of the size of T">,
  DescFile<"CastSizeChecker.cpp">;

def CastToStructChecker : Checker<"CastToStruct">,
  HelpText<"Check for cast from non-struct pointer to struct pointer">,
  DescFile<"CastToStructChecker.cpp">;

def FixedAddressChecker : Checker<"FixedAddr">,
  HelpText<"Check for assignment of a fixed address to a pointer">,
  DescFile<"FixedAddressChecker.cpp">;

def PointerArithChecker : Checker<"PointerArithm">,
  HelpText<"Check for pointer arithmetic on locations other than array elements">,
  DescFile<"PointerArithChecker">;

def PointerSubChecker : Checker<"PointerSub">,
  HelpText<"Check for pointer subtractions on two pointers pointing to different memory chunks">,
  DescFile<"PointerSubChecker">;

def SizeofPointerChecker : Checker<"SizeofPtr">,
  HelpText<"Warn about unintended use of sizeof() on pointer expressions">,
  DescFile<"CheckSizeofPointer.cpp">;

} // end "core.experimental"

//===----------------------------------------------------------------------===//
// Evaluate "builtin" functions.
//===----------------------------------------------------------------------===//

let ParentPackage = CoreBuiltin in {

def NoReturnFunctionChecker : Checker<"NoReturnFunctions">,
  HelpText<"Evaluate \"panic\" functions that are known to not return to the caller">,
  DescFile<"NoReturnFunctionChecker.cpp">;

def BuiltinFunctionChecker : Checker<"BuiltinFunctions">,
  HelpText<"Evaluate compiler builtin functions (e.g., alloca())">,
  DescFile<"BuiltinFunctionChecker.cpp">;

} // end "core.builtin"

//===----------------------------------------------------------------------===//
// Uninitialized values checkers.
//===----------------------------------------------------------------------===//

let ParentPackage = CoreUninitialized in {

def UndefinedArraySubscriptChecker : Checker<"ArraySubscript">,
  HelpText<"Check for uninitialized values used as array subscripts">,
  DescFile<"UndefinedArraySubscriptChecker.cpp">;

def UndefinedAssignmentChecker : Checker<"Assign">,
  HelpText<"Check for assigning uninitialized values">,
  DescFile<"UndefinedAssignmentChecker.cpp">;

def UndefBranchChecker : Checker<"Branch">,
  HelpText<"Check for uninitialized values used as branch conditions">,
  DescFile<"UndefBranchChecker.cpp">;

def UndefCapturedBlockVarChecker : Checker<"CapturedBlockVariable">,
  HelpText<"Check for blocks that capture uninitialized values">,
  DescFile<"UndefCapturedBlockVarChecker.cpp">;
  
def ReturnUndefChecker : Checker<"UndefReturn">,
  HelpText<"Check for uninitialized values being returned to the caller">,
  DescFile<"ReturnUndefChecker.cpp">;

} // end "core.uninitialized"

//===----------------------------------------------------------------------===//
// C++ checkers.
//===----------------------------------------------------------------------===//

let ParentPackage = CplusplusExperimental in {

def IteratorsChecker : Checker<"Iterators">,
  HelpText<"Check improper uses of STL vector iterators">,
  DescFile<"IteratorsChecker.cpp">;

def VirtualCallChecker : Checker<"VirtualCall">,
  HelpText<"Check virtual function calls during construction or destruction">, 
  DescFile<"VirtualCallChecker.cpp">;

} // end: "cplusplus.experimental"

//===----------------------------------------------------------------------===//
// Deadcode checkers.
//===----------------------------------------------------------------------===//

let ParentPackage = DeadCode in {

def DeadStoresChecker : Checker<"DeadStores">,
  HelpText<"Check for values stored to variables that are never read afterwards">,
  DescFile<"DeadStoresChecker.cpp">;
} // end DeadCode

let ParentPackage = DeadCodeExperimental in {

def IdempotentOperationChecker : Checker<"IdempotentOperations">,
  HelpText<"Warn about idempotent operations">,
  DescFile<"IdempotentOperationChecker.cpp">;

def UnreachableCodeChecker : Checker<"UnreachableCode">,
  HelpText<"Check unreachable code">,
  DescFile<"UnreachableCodeChecker.cpp">;

} // end "deadcode.experimental"

//===----------------------------------------------------------------------===//
// Security checkers.
//===----------------------------------------------------------------------===//

let ParentPackage = InsecureAPI in {
  def gets : Checker<"gets">,
    HelpText<"Warn on uses of the 'gets' function">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
  def getpw : Checker<"getpw">,
    HelpText<"Warn on uses of the 'getpw' function">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
  def mktemp : Checker<"mktemp">,
    HelpText<"Warn on uses of the 'mktemp' function">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
  def mkstemp : Checker<"mkstemp">,
    HelpText<"Warn when 'mkstemp' is passed fewer than 6 X's in the format string">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
  def rand : Checker<"rand">,
    HelpText<"Warn on uses of the 'rand', 'random', and related functions">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
  def strcpy : Checker<"strcpy">,
    HelpText<"Warn on uses of the 'strcpy' and 'strcat' functions">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
  def vfork : Checker<"vfork">,
    HelpText<"Warn on uses of the 'vfork' function">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
  def UncheckedReturn : Checker<"UncheckedReturn">,
    HelpText<"Warn on uses of functions whose return values must be always checked">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
}
let ParentPackage = Security in {
  def FloatLoopCounter : Checker<"FloatLoopCounter">,
    HelpText<"Warn on using a floating point value as a loop counter (CERT: FLP30-C, FLP30-CPP)">,
    DescFile<"CheckSecuritySyntaxOnly.cpp">;
}

let ParentPackage = SecurityExperimental in {

def ArrayBoundChecker : Checker<"ArrayBound">,
  HelpText<"Warn about buffer overflows (older checker)">,
  DescFile<"ArrayBoundChecker.cpp">;  

def ArrayBoundCheckerV2 : Checker<"ArrayBoundV2">,
  HelpText<"Warn about buffer overflows (newer checker)">,
  DescFile<"ArrayBoundCheckerV2.cpp">;

def ReturnPointerRangeChecker : Checker<"ReturnPtrRange">,
  HelpText<"Check for an out-of-bound pointer being returned to callers">,
  DescFile<"ReturnPointerRangeChecker.cpp">;

def MallocOverflowSecurityChecker : Checker<"MallocOverflow">,
  HelpText<"Check for overflows in the arguments to malloc()">,
  DescFile<"MallocOverflowSecurityChecker.cpp">;

} // end "security.experimental"

//===----------------------------------------------------------------------===//
// Taint checkers.
//===----------------------------------------------------------------------===//

let ParentPackage = Taint in {

def GenericTaintChecker : Checker<"TaintPropagation">,
  HelpText<"Generate taint information used by other checkers">,
  DescFile<"GenericTaintChecker.cpp">;

} // end "experimental.security.taint"

//===----------------------------------------------------------------------===//
// Unix API checkers.
//===----------------------------------------------------------------------===//

let ParentPackage = Unix in {

def UnixAPIChecker : Checker<"API">,
  HelpText<"Check calls to various UNIX/Posix functions">,
  DescFile<"UnixAPIChecker.cpp">;
  
} // end "unix"

let ParentPackage = UnixExperimental in {

def ChrootChecker : Checker<"Chroot">,
  HelpText<"Check improper use of chroot">,
  DescFile<"ChrootChecker.cpp">;

def CStringChecker : Checker<"CString">,
  HelpText<"Check calls to functions in <string.h>">,
  DescFile<"CStringChecker.cpp">;

def MallocChecker : Checker<"Malloc">,
  HelpText<"Check for potential memory leaks, double free, and use-after-free problems">,
  DescFile<"MallocChecker.cpp">;

def MallocSizeofChecker : Checker<"MallocSizeof">,
  HelpText<"Check for dubious malloc arguments involving sizeof">,
  DescFile<"MallocSizeofChecker.cpp">;

def PthreadLockChecker : Checker<"PthreadLock">,
  HelpText<"Simple lock -> unlock checker">,
  DescFile<"PthreadLockChecker.cpp">;

def StreamChecker : Checker<"Stream">,
  HelpText<"Check stream handling functions">,
  DescFile<"StreamChecker.cpp">;

} // end "unix.experimental"

//===----------------------------------------------------------------------===//
// Mac OS X, Cocoa, and Core Foundation checkers.
//===----------------------------------------------------------------------===//

let ParentPackage = OSX in {

def MacOSXAPIChecker : Checker<"API">,
  InPackage<OSX>,
  HelpText<"Check for proper uses of various Mac OS X APIs">,
  DescFile<"MacOSXAPIChecker.cpp">;

def OSAtomicChecker : Checker<"AtomicCAS">,
  InPackage<OSX>,
  HelpText<"Evaluate calls to OSAtomic functions">,
  DescFile<"OSAtomicChecker.cpp">;

def MacOSKeychainAPIChecker : Checker<"SecKeychainAPI">,
  InPackage<OSX>,
  HelpText<"Check for proper uses of Secure Keychain APIs">,
  DescFile<"MacOSKeychainAPIChecker.cpp">;

} // end "macosx"

let ParentPackage = Cocoa in {

def ObjCAtSyncChecker : Checker<"AtSync">,
  HelpText<"Check for null pointers used as mutexes for @synchronized">,
  DescFile<"ObjCAtSyncChecker.cpp">;

def NilArgChecker : Checker<"NilArg">,
  HelpText<"Check for prohibited nil arguments to ObjC method calls">,
  DescFile<"BasicObjCFoundationChecks.cpp">;

def ClassReleaseChecker : Checker<"ClassRelease">,
  HelpText<"Check for sending 'retain', 'release', or 'autorelease' directly to a Class">,
  DescFile<"BasicObjCFoundationChecks.cpp">;

def VariadicMethodTypeChecker : Checker<"VariadicMethodTypes">,
  HelpText<"Check for passing non-Objective-C types to variadic methods that expect "
           "only Objective-C types">,
  DescFile<"BasicObjCFoundationChecks.cpp">;

def NSAutoreleasePoolChecker : Checker<"NSAutoreleasePool">,
  HelpText<"Warn for suboptimal uses of NSAutoreleasePool in Objective-C GC mode">,
  DescFile<"NSAutoreleasePoolChecker.cpp">;

def ObjCMethSigsChecker : Checker<"IncompatibleMethodTypes">,
  HelpText<"Warn about Objective-C method signatures with type incompatibilities">,
  DescFile<"CheckObjCInstMethSignature.cpp">;

def ObjCUnusedIvarsChecker : Checker<"UnusedIvars">,
  HelpText<"Warn about private ivars that are never used">,
  DescFile<"ObjCUnusedIVarsChecker.cpp">;
 
def NSErrorChecker : Checker<"NSError">,
  HelpText<"Check usage of NSError** parameters">,
  DescFile<"NSErrorChecker.cpp">;

def RetainCountChecker : Checker<"RetainCount">,
  HelpText<"Check for leaks and improper reference count management">,
  DescFile<"RetainCountChecker.cpp">;

} // end "cocoa"

let ParentPackage = CocoaExperimental in {

def ObjCContainersASTChecker : Checker<"ContainerAPI">,
  HelpText<"Check for common pitfalls when using 'CFArray', 'CFDictionary', 'CFSet' APIs">,
  DescFile<"ObjCContainersASTChecker.cpp">;

def ObjCSelfInitChecker : Checker<"SelfInit">,
  HelpText<"Check that 'self' is properly initialized inside an initializer method">,
  DescFile<"ObjCSelfInitChecker.cpp">;

def ObjCDeallocChecker : Checker<"Dealloc">,
  HelpText<"Warn about Objective-C classes that lack a correct implementation of -dealloc">,
  DescFile<"CheckObjCDealloc.cpp">;

} // end "cocoa.experimental"

let ParentPackage = CoreFoundation in {

def CFNumberCreateChecker : Checker<"CFNumber">,
  HelpText<"Check for proper uses of CFNumberCreate">,
  DescFile<"BasicObjCFoundationChecks.cpp">;

def CFRetainReleaseChecker : Checker<"CFRetainRelease">,
  HelpText<"Check for null arguments to CFRetain/CFRelease">,
  DescFile<"BasicObjCFoundationChecks.cpp">;

def CFErrorChecker : Checker<"CFError">,
  HelpText<"Check usage of CFErrorRef* parameters">,
  DescFile<"NSErrorChecker.cpp">;
}

//===----------------------------------------------------------------------===//
// Checkers for LLVM development.
//===----------------------------------------------------------------------===//

def LLVMConventionsChecker : Checker<"Conventions">,
  InPackage<LLVM>,
  HelpText<"Check code for LLVM codebase conventions">,
  DescFile<"LLVMConventionsChecker.cpp">;

//===----------------------------------------------------------------------===//
// Debugging checkers (for analyzer development).
//===----------------------------------------------------------------------===//

let ParentPackage = Debug in {

def DominatorsTreeDumper : Checker<"DumpDominators">,
  HelpText<"Print the dominance tree for a given CFG">,
  DescFile<"DebugCheckers.cpp">;

def LiveVariablesDumper : Checker<"DumpLiveVars">,
  HelpText<"Print results of live variable analysis">,
  DescFile<"DebugCheckers.cpp">;

def CFGViewer : Checker<"ViewCFG">,
  HelpText<"View Control-Flow Graphs using GraphViz">,
  DescFile<"DebugCheckers.cpp">;

def CFGDumper : Checker<"DumpCFG">,
  HelpText<"Display Control-Flow Graphs">,
  DescFile<"DebugCheckers.cpp">;

def AnalyzerStatsChecker : Checker<"Stats">,
  HelpText<"Emit warnings with analyzer statistics">,
  DescFile<"AnalyzerStatsChecker.cpp">;

def TaintTesterChecker : Checker<"TaintTest">,
  HelpText<"Mark tainted symbols as such.">,
  DescFile<"TaintTesterChecker.cpp">;

} // end "debug"


clang_tablegen(Checkers.inc -gen-clang-sa-checkers
  -I ${CMAKE_CURRENT_SOURCE_DIR}/../../../include
  SOURCE Checkers.td
  TARGET ClangSACheckers)

set(LLVM_USED_LIBS clangBasic clangAST clangStaticAnalyzerCore)

add_clang_library(clangStaticAnalyzerCheckers
  AdjustedReturnValueChecker.cpp
  AnalyzerStatsChecker.cpp
  ArrayBoundChecker.cpp
  ArrayBoundCheckerV2.cpp
  AttrNonNullChecker.cpp
  BasicObjCFoundationChecks.cpp
  BuiltinFunctionChecker.cpp
  CStringChecker.cpp
  CallAndMessageChecker.cpp
  CastSizeChecker.cpp
  CastToStructChecker.cpp
  CheckObjCDealloc.cpp
  CheckObjCInstMethSignature.cpp
  CheckSecuritySyntaxOnly.cpp
  CheckSizeofPointer.cpp
  CheckerDocumentation.cpp
  ChrootChecker.cpp
  ClangCheckers.cpp
  DeadStoresChecker.cpp
  DebugCheckers.cpp
  DereferenceChecker.cpp
  DivZeroChecker.cpp
  FixedAddressChecker.cpp
  GenericTaintChecker.cpp
  IdempotentOperationChecker.cpp
  IteratorsChecker.cpp
  LLVMConventionsChecker.cpp
  MacOSKeychainAPIChecker.cpp
  MacOSXAPIChecker.cpp
  MallocChecker.cpp
  MallocOverflowSecurityChecker.cpp
  MallocSizeofChecker.cpp
  NSAutoreleasePoolChecker.cpp
  NSErrorChecker.cpp
  NoReturnFunctionChecker.cpp
  OSAtomicChecker.cpp
  ObjCAtSyncChecker.cpp
  ObjCContainersASTChecker.cpp
  ObjCSelfInitChecker.cpp
  ObjCUnusedIVarsChecker.cpp
  PointerArithChecker.cpp
  PointerSubChecker.cpp
  PthreadLockChecker.cpp
  RetainCountChecker.cpp
  ReturnPointerRangeChecker.cpp
  ReturnUndefChecker.cpp
  StackAddrEscapeChecker.cpp
  StreamChecker.cpp
  TaintTesterChecker.cpp
  UndefBranchChecker.cpp
  UndefCapturedBlockVarChecker.cpp
  UndefResultChecker.cpp
  UndefinedArraySubscriptChecker.cpp
  UndefinedAssignmentChecker.cpp
  UnixAPIChecker.cpp
  UnreachableCodeChecker.cpp
  VLASizeChecker.cpp
  VirtualCallChecker.cpp
  )

add_dependencies(clangStaticAnalyzerCheckers
  clangStaticAnalyzerCore
  ClangAttrClasses
  ClangAttrList
  ClangDeclNodes
  ClangStmtNodes
  ClangSACheckers
  )

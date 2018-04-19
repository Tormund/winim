
{.deadCodeElim: on.}

import winapi_pt0, winapi_pt1

# misc/rpcndr.nim
const
  # IDL_CS_CONVERT* = enum
  IDL_CS_NO_CONVERT* = 0
  IDL_CS_IN_PLACE_CONVERT* = 1
  IDL_CS_NEW_BUFFER_CONVERT* = 2
  # XLAT_SIDE* = enum
  XLAT_SERVER* = 1
  XLAT_CLIENT* = 2
  # STUB_PHASE* = enum
  STUB_UNMARSHAL* = 0
  STUB_CALL_SERVER* = 1
  STUB_MARSHAL* = 2
  STUB_CALL_SERVER_NO_HRESULT* = 3
  # PROXY_PHASE* = enum
  PROXY_CALCSIZE* = 0
  PROXY_GETBUFFER* = 1
  PROXY_MARSHAL* = 2
  PROXY_SENDRECEIVE* = 3
  PROXY_UNMARSHAL* = 4

const
  RPCNDR_H_VERSION* = 450

const
  NDR_CHAR_REP_MASK* = 0xF
  NDR_INT_REP_MASK* = 0xF0
  NDR_FLOAT_REP_MASK* = 0xFF00
  NDR_LITTLE_ENDIAN* = 0x10
  NDR_BIG_ENDIAN* = 0
  NDR_IEEE_FLOAT* = 0
  NDR_VAX_FLOAT* = 0x100
  NDR_ASCII_CHAR* = 0
  NDR_EBCDIC_CHAR* = 1
  NDR_LOCAL_DATA_REPRESENTATION* = 0x10
  NDR_LOCAL_ENDIAN* = NDR_LITTLE_ENDIAN

type
  # midl_user_allocate* = MIDL_user_allocate
  # midl_user_free* = MIDL_user_free
  # hyper* = int64
  MIDL_uhyper* = uint64
  small* = char
  NDR_RUNDOWN* = proc (P1: pointer): void {.stdcall.}

const
  cbNDRContext* = 20

type
  NDR_CCONTEXT* = pointer
  tagNDR_SCONTEXT* {.final, pure.} = object
    pad*: array[2, pointer]
    userContext*: pointer
  NDR_SCONTEXT* = ptr tagNDR_SCONTEXT
  SCONTEXT_QUEUE* {.final, pure.} = object
    NumberOfObjects*: uint32
    ArrayOfObjects*: ptr NDR_SCONTEXT
  PSCONTEXT_QUEUE* = ptr SCONTEXT_QUEUE
  # MIDL_STUB_MESSAGE* {.final, pure.} = object
  # MIDL_STUB_DESC* {.final, pure.} = object
  # FULL_PTR_XLAT_TABLES* {.final, pure.} = object
  RPC_BUFPTR* = ptr uint8
  RPC_LENGTH* = uint32
  PFORMAT_STRING* = cstring
  ARRAY_INFO* {.final, pure.} = object
    Dimension*: int32
    BufferConformanceMark*: ptr uint32
    BufferVarianceMark*: ptr uint32
    MaxCountArray*: ptr uint32
    OffsetArray*: ptr uint32
    ActualCountArray*: ptr uint32
  PARRAY_INFO* = ptr ARRAY_INFO

proc NDRCContextBinding*(P1: NDR_CCONTEXT): RPC_BINDING_HANDLE {.winapi, dynlib: "rpcrt4", importc.}
proc NDRCContextMarshall*(P1: NDR_CCONTEXT, P2: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc NDRCContextUnmarshall*(P1: ptr NDR_CCONTEXT, P2: RPC_BINDING_HANDLE, P3: pointer, P4: uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc NDRSContextMarshall*(P1: NDR_SCONTEXT, P2: pointer, P3: NDR_RUNDOWN): void {.winapi, dynlib: "rpcrt4", importc.}
proc NDRSContextUnmarshall*(pBuff: pointer, P2: uint32): NDR_SCONTEXT {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsDestroyClientContext*(P1: ptr pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc NDRcopy*(P1: pointer, P2: pointer, P3: uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc MIDL_wchar_strlen*(P1: ptr uint16): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc MIDL_wchar_strcpy*(P1: pointer, P2: ptr uint16): void {.winapi, dynlib: "rpcrt4", importc.}
proc char_from_ndr*(P1: PRPC_MESSAGE, P2: ptr uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc char_array_from_ndr*(P1: PRPC_MESSAGE, P2: uint32, P3: uint32, P4: ptr uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc short_from_ndr*(P1: PRPC_MESSAGE, P2: ptr uint16): void {.winapi, dynlib: "rpcrt4", importc.}
proc short_array_from_ndr*(P1: PRPC_MESSAGE, P2: uint32, P3: uint32, P4: ptr uint16): void {.winapi, dynlib: "rpcrt4", importc.}
proc short_from_ndr_temp*(P1: ptr ptr uint8, P2: ptr uint16, P3: uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc int_from_ndr*(P1: PRPC_MESSAGE, P2: ptr uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc int_array_from_ndr*(P1: PRPC_MESSAGE, P2: uint32, P3: uint32, P4: ptr uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc int_from_ndr_temp*(P1: ptr ptr uint8, P2: ptr uint32, P3: uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc enum_from_ndr*(P1: PRPC_MESSAGE, P2: ptr uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc float_from_ndr*(P1: PRPC_MESSAGE, P2: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc float_array_from_ndr*(P1: PRPC_MESSAGE, P2: uint32, P3: uint32, P4: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc double_from_ndr*(P1: PRPC_MESSAGE, P2: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc double_array_from_ndr*(P1: PRPC_MESSAGE, P2: uint32, P3: uint32, P4: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc hyper_from_ndr*(P1: PRPC_MESSAGE, P2: ptr hyper): void {.winapi, dynlib: "rpcrt4", importc.}
proc hyper_array_from_ndr*(P1: PRPC_MESSAGE, P2: uint32, P3: uint32, P4: ptr hyper): void {.winapi, dynlib: "rpcrt4", importc.}
proc hyper_from_ndr_temp*(P1: ptr ptr uint8, P2: ptr hyper, P3: uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc data_from_ndr*(P1: PRPC_MESSAGE, P2: pointer, P3: cstring, P4: uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc data_into_ndr*(P1: pointer, P2: PRPC_MESSAGE, P3: cstring, P4: uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc tree_into_ndr*(P1: pointer, P2: PRPC_MESSAGE, P3: cstring, P4: uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc data_size_ndr*(P1: pointer, P2: PRPC_MESSAGE, P3: cstring, P4: uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc tree_size_ndr*(P1: pointer, P2: PRPC_MESSAGE, P3: cstring, P4: uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc tree_peek_ndr*(P1: PRPC_MESSAGE, P2: ptr ptr uint8, P3: cstring, P4: uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc midl_allocate*(P1: int32): pointer {.winapi, dynlib: "rpcrt4", importc.}

type
  MIDL_STUB_MESSAGE* {.final, pure.} = object
    RpcMsg*: PRPC_MESSAGE
    Buffer*: ptr uint8
    BufferStart*: ptr uint8
    BufferEnd*: ptr uint8
    BufferMark*: ptr uint8
    BufferLength*: uint32
    MemorySize*: uint32
    Memory*: ptr uint8
    IsClient*: int32
    ReuseBuffer*: int32
    AllocAllNodesMemory*: ptr uint8
    AllocAllNodesMemoryEnd*: ptr uint8
    IgnoreEmbeddedPointers*: int32
    PointerBufferMark*: ptr uint8
    fBufferValid*: uint8
    Unused*: uint8
    MaxCount*: uint32
    Offset*: uint32
    ActualCount*: uint32
    pfnAllocate*: proc(P1: uint32): pointer
    pfnFree*: proc(P1: pointer): void
    StackTop*: ptr uint8
    pPresentedType*: ptr uint8
    pTransmitType*: ptr uint8
    SavedHandle*: handle_t
    StubDesc*: ptr MIDL_STUB_DESC
    FullPtrXlatTables*: ptr FULL_PTR_XLAT_TABLES
    FullPtrRefId*: uint32
    fCheckBounds*: int32
    bit_fields_for_D*: int8
    dwDestContext*: uint32
    pvDestContext*: pointer
    SavedContextHandles*: ptr NDR_SCONTEXT
    ParamNumber*: int32
    pRpcChannelBuffer*: ptr IRpcChannelBuffer
    pArrayInfo*: PARRAY_INFO
    SizePtrCountArray*: ptr uint32
    SizePtrOffsetArray*: ptr uint32
    SizePtrLengthArray*: ptr uint32
    pArgQueue*: pointer
    dwStubPhase*: uint32
    w2kReserved*: array[5, uint32]
  PMIDL_STUB_MESSAGE* = ptr MIDL_STUB_MESSAGE
  GENERIC_BINDING_ROUTINE* = proc (P1: pointer): pointer {.stdcall.}
  GENERIC_UNBIND_ROUTINE* = proc (P1: pointer, P2: ptr uint8): void {.stdcall.}
  USER_MARSHAL_SIZING_ROUTINE* = proc (P1: ptr uint32, P2: uint32, P3: pointer): uint32 {.stdcall.}
  USER_MARSHAL_MARSHALLING_ROUTINE* = proc (P1: ptr uint32, P2: ptr uint8, P3: pointer): ptr uint8 {.stdcall.}
  USER_MARSHAL_UNMARSHALLING_ROUTINE* = proc (P1: ptr uint32, P2: ptr uint8, P3: pointer): ptr uint8 {.stdcall.}
  USER_MARSHAL_FREEING_ROUTINE* = proc (P1: ptr uint32, P2: pointer): void {.stdcall.}
  NDR_NOTIFY_ROUTINE* = proc (): void {.stdcall.}
  GENERIC_BINDING_ROUTINE_PAIR* {.final, pure.} = object
    pfnBind*: GENERIC_BINDING_ROUTINE
    pfnUnbind*: GENERIC_UNBIND_ROUTINE
  PGENERIC_BINDING_ROUTINE_PAIR* = ptr GENERIC_BINDING_ROUTINE_PAIR
  GENERIC_BINDING_INFO* {.final, pure.} = object
    pObj*: pointer
    Size*: uint32
    pfnBind*: GENERIC_BINDING_ROUTINE
    pfnUnbind*: GENERIC_UNBIND_ROUTINE
  PGENERIC_BINDING_INFO* = ptr GENERIC_BINDING_INFO
  XMIT_ROUTINE_QUINTUPLE* {.final, pure.} = object
    pfnTranslateToXmit*: XMIT_HELPER_ROUTINE
    pfnTranslateFromXmit*: XMIT_HELPER_ROUTINE
    pfnFreeXmit*: XMIT_HELPER_ROUTINE
    pfnFreeInst*: XMIT_HELPER_ROUTINE
  PXMIT_ROUTINE_QUINTUPLE* = ptr XMIT_ROUTINE_QUINTUPLE
  MALLOC_FREE_STRUCT* {.final, pure.} = object
    pfnAllocate*: proc(P1: uint32): pointer
    pfnFree*: proc(P1: pointer): void
  COMM_FAULT_OFFSETS* {.final, pure.} = object
    CommOffset*: int16
    FaultOffset*: int16
  USER_MARSHAL_ROUTINE_QUADRUPLE* {.final, pure.} = object
    pfnBufferSize*: USER_MARSHAL_SIZING_ROUTINE
    pfnMarshall*: USER_MARSHAL_MARSHALLING_ROUTINE
    pfnUnmarshall*: USER_MARSHAL_UNMARSHALLING_ROUTINE
    pfnFree*: USER_MARSHAL_FREEING_ROUTINE
  IDL_CS_CONVERT* = int32
  NDR_CS_SIZE_CONVERT_ROUTINES* {.final, pure.} = object
    pfnNetSize*: CS_TYPE_NET_SIZE_ROUTINE
    pfnToNetCs*: CS_TYPE_TO_NETCS_ROUTINE
    pfnLocalSize*: CS_TYPE_LOCAL_SIZE_ROUTINE
    pfnFromNetCs*: CS_TYPE_FROM_NETCS_ROUTINE
  NDR_CS_ROUTINES* {.final, pure.} = object
    pSizeConvertRoutines*: ptr NDR_CS_SIZE_CONVERT_ROUTINES
    pTagGettingRoutines*: ptr CS_TAG_GETTING_ROUTINE
  MIDL_STUB_DESC_IMPLICIT_HANDLE_INFO* {.final, union, pure.} = object
    pAutoHandle*: ptr handle_t
    pPrimitiveHandle*: ptr handle_t
    pGenericBindingInfo*: PGENERIC_BINDING_INFO
  MIDL_STUB_DESC* {.final, pure.} = object
    RpcInterfaceInformation*: pointer
    pfnAllocate*: proc(P1: uint32): pointer
    pfnFree*: proc(P1: pointer): void
    apfnNdrRundownRoutines*: ptr NDR_RUNDOWN
    aGenericBindingRoutinePairs*: ptr GENERIC_BINDING_ROUTINE_PAIR
    apfnExprEval*: ptr EXPR_EVAL
    aXmitQuintuple*: ptr XMIT_ROUTINE_QUINTUPLE
    pFormatTypes*: ptr cstring
    fCheckBounds*: int32
    Version*: uint32
    pMallocFreeStruct*: ptr MALLOC_FREE_STRUCT
    MIDLVersion*: int32
    CommFaultOffsets*: ptr COMM_FAULT_OFFSETS
    aUserMarshalQuadruple*: ptr USER_MARSHAL_ROUTINE_QUADRUPLE
    NotifyRoutineTable*: ptr NDR_NOTIFY_ROUTINE
    mFlags*: ULONG_PTR
    CsRoutineTables*: ptr NDR_CS_ROUTINES
    Reserved4*: pointer
    Reserved5*: ULONG_PTR
  PMIDL_STUB_DESC* = ptr MIDL_STUB_DESC
  PMIDL_XMIT_TYPE* = pointer
  MIDL_FORMAT_STRING* {.final, pure.} = object
    Pad*: int16
    Format*: array[1, uint8]
  MIDL_SERVER_INFO* {.final, pure.} = object
    pStubDesc*: PMIDL_STUB_DESC
    DispatchTable*: ptr SERVER_ROUTINE
    ProcString*: PFORMAT_STRING
    FmtStringOffset*: ptr uint16
    ThunkTable*: ptr STUB_THUNK
  PMIDL_SERVER_INFO* = ptr MIDL_SERVER_INFO
  MIDL_STUBLESS_PROXY_INFO* {.final, pure.} = object
    pStubDesc*: PMIDL_STUB_DESC
    ProcFormatString*: PFORMAT_STRING
    FormatStringOffset*: ptr uint16
  PMIDL_STUBLESS_PROXY_INFO* = ptr MIDL_STUBLESS_PROXY_INFO
  CLIENT_CALL_RETURN* {.final, union, pure.} = object
    Pointer*: pointer
    Simple*: int32
  XLAT_SIDE* = int32
  FULL_PTR_TO_REFID_ELEMENT* {.final, pure.} = object
    Next*: ptr FULL_PTR_TO_REFID_ELEMENT
    Pointer*: pointer
    RefId*: uint32
    State*: uint8
  PFULL_PTR_TO_REFID_ELEMENT* = ptr FULL_PTR_TO_REFID_ELEMENT
  FULL_PTR_XLAT_TABLES_PointerToRefId* {.final, pure.} = object
    XlatTable*: ptr PFULL_PTR_TO_REFID_ELEMENT
    NumberOfBuckets*: uint32
    HashMask*: uint32
  FULL_PTR_XLAT_TABLES_RefIdToPointer* {.final, pure.} = object
    XlatTable*: ptr pointer
    StateTable*: ptr uint8
    NumberOfEntries*: uint32
  FULL_PTR_XLAT_TABLES* {.final, pure.} = object
    RefIdToPointer*: FULL_PTR_XLAT_TABLES_RefIdToPointer
    PointerToRefId*: FULL_PTR_XLAT_TABLES_PointerToRefId
    NextRefId*: uint32
    XlatSide*: XLAT_SIDE
  PFULL_PTR_XLAT_TABLES* = ptr FULL_PTR_XLAT_TABLES
  STUB_PHASE* = int32
  PROXY_PHASE* = int32
  RPC_SS_THREAD_HANDLE* = pointer
  EXPR_EVAL* = proc (P1: ptr MIDL_STUB_MESSAGE): void {.stdcall.}
  XMIT_HELPER_ROUTINE* = proc (P1: PMIDL_STUB_MESSAGE): void {.stdcall.}
  CS_TYPE_NET_SIZE_ROUTINE* = proc (P1: RPC_BINDING_HANDLE, P2: uint32, P3: uint32, P4: ptr IDL_CS_CONVERT, P5: ptr uint32, P6: ptr error_status_t): void {.stdcall.}
  CS_TYPE_LOCAL_SIZE_ROUTINE* = proc (P1: RPC_BINDING_HANDLE, P2: uint32, P3: uint32, P4: ptr IDL_CS_CONVERT, P5: ptr uint32, P6: ptr error_status_t): void {.stdcall.}
  CS_TYPE_TO_NETCS_ROUTINE* = proc (P1: RPC_BINDING_HANDLE, P2: uint32, P3: pointer, P4: uint32, P5: ptr int8, P6: ptr uint32, P7: ptr error_status_t): void {.stdcall.}
  CS_TYPE_FROM_NETCS_ROUTINE* = proc (P1: RPC_BINDING_HANDLE, P2: uint32, P3: ptr int8, P4: uint32, P5: uint32, P6: pointer, P7: ptr uint32, P8: ptr error_status_t): void {.stdcall.}
  CS_TAG_GETTING_ROUTINE* = proc (P1: RPC_BINDING_HANDLE, P2: int32, P3: ptr uint32, P4: ptr uint32, P5: ptr uint32, P6: ptr error_status_t): void {.stdcall.}
  PRPC_CLIENT_ALLOC* = proc (P1: uint32): pointer {.stdcall.}
  PRPC_CLIENT_FREE* = proc (P1: pointer): void {.stdcall.}
  STUB_THUNK* = proc (P1: PMIDL_STUB_MESSAGE): void {.stdcall.}
  SERVER_ROUTINE* = proc (): int32 {.stdcall.}

proc NdrSimpleTypeMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrPointerMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, pFormat: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStructMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrHardStructMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexStructMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonConformantStringMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStringMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrByteCountPointerMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrClientContextMarshall*(P1: PMIDL_STUB_MESSAGE, P2: NDR_CCONTEXT, P3: int32): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerContextMarshall*(P1: PMIDL_STUB_MESSAGE, P2: NDR_SCONTEXT, P3: NDR_RUNDOWN): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSimpleTypeUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrPointerUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStructUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrHardStructUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexStructUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonConformantStringUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStringUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrByteCountPointerUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrClientContextUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr NDR_CCONTEXT, P3: RPC_BINDING_HANDLE): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerContextUnmarshall*(P1: PMIDL_STUB_MESSAGE): NDR_SCONTEXT {.winapi, dynlib: "rpcrt4", importc.}
proc NdrPointerBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStructBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrHardStructBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexStructBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStringBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonConformantStringBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrByteCountPointerBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrContextHandleSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrPointerMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStructMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrHardStructMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexStructMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStringMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonConformantStringMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrPointerFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSimpleStructFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantStructFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingStructFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrHardStructFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexStructFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFixedArrayFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantArrayFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConformantVaryingArrayFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrVaryingArrayFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrComplexArrayFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrEncapsulatedUnionFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNonEncapsulatedUnionFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrByteCountPointerFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrXmitOrRepAsFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrInterfacePointerFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrConvert*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrClientInitializeNew*(P1: PRPC_MESSAGE, P2: PMIDL_STUB_MESSAGE, P3: PMIDL_STUB_DESC, P4: uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerInitializeNew*(P1: PRPC_MESSAGE, P2: PMIDL_STUB_MESSAGE, P3: PMIDL_STUB_DESC): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrClientInitialize*(P1: PRPC_MESSAGE, P2: PMIDL_STUB_MESSAGE, P3: PMIDL_STUB_DESC, P4: uint32): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerInitialize*(P1: PRPC_MESSAGE, P2: PMIDL_STUB_MESSAGE, P3: PMIDL_STUB_DESC): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerInitializeUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: PMIDL_STUB_DESC, P3: PRPC_MESSAGE): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerInitializeMarshall*(P1: PRPC_MESSAGE, P2: PMIDL_STUB_MESSAGE): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrGetBuffer*(P1: PMIDL_STUB_MESSAGE, P2: uint32, P3: RPC_BINDING_HANDLE): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNsGetBuffer*(P1: PMIDL_STUB_MESSAGE, P2: uint32, P3: RPC_BINDING_HANDLE): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSendReceive*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrNsSendReceive*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: ptr RPC_BINDING_HANDLE): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFreeBuffer*(P1: PMIDL_STUB_MESSAGE): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrClientCall*(P1: PMIDL_STUB_DESC, P2: PFORMAT_STRING): CLIENT_CALL_RETURN {.winapi, dynlib: "rpcrt4", varargs, importc.}
proc NdrStubCall*(P1: ptr IRpcStubBuffer, P2: ptr IRpcChannelBuffer, P3: PRPC_MESSAGE, P4: ptr uint32): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerCall*(P1: PRPC_MESSAGE): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerUnmarshall*(P1: ptr IRpcChannelBuffer, P2: PRPC_MESSAGE, P3: PMIDL_STUB_MESSAGE, P4: PMIDL_STUB_DESC, P5: PFORMAT_STRING, P6: pointer): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrServerMarshall*(P1: ptr IRpcStubBuffer, P2: ptr IRpcChannelBuffer, P3: PMIDL_STUB_MESSAGE, P4: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrMapCommAndFaultStatus*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint32, P3: ptr uint32, P4: RPC_STATUS): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_UPDecision*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: RPC_BUFPTR): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_TLUPDecision*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_TLUPDecisionBuffer*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_IfAlloc*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: uint32): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_IfAllocRef*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: uint32): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_IfAllocSet*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: uint32): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_IfCopy*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: uint32): RPC_BUFPTR {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_IfAllocCopy*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: uint32): RPC_BUFPTR {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_Copy*(P1: ptr uint8, P2: ptr uint8, P3: uint32): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_IfFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_StringMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: uint32, P4: int32): RPC_BUFPTR {.winapi, dynlib: "rpcrt4", importc.}
proc NdrSH_StringUnMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: int32): RPC_BUFPTR {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsAllocate*(P1: uint32): pointer {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsDisableAllocate*(): void {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsEnableAllocate*(): void {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsFree*(P1: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsGetThreadHandle*(): RPC_SS_THREAD_HANDLE {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsSetClientAllocFree*(P1: PRPC_CLIENT_ALLOC, P2: PRPC_CLIENT_FREE): void {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsSetThreadHandle*(P1: RPC_SS_THREAD_HANDLE): void {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSsSwapClientAllocFree*(P1: PRPC_CLIENT_ALLOC, P2: PRPC_CLIENT_FREE, P3: ptr PRPC_CLIENT_ALLOC, P4: ptr PRPC_CLIENT_FREE): void {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmAllocate*(P1: uint32, P2: ptr RPC_STATUS): pointer {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmClientFree*(P1: pointer): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmDestroyClientContext*(P1: ptr pointer): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmDisableAllocate*(): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmEnableAllocate*(): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmFree*(P1: pointer): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmGetThreadHandle*(P1: ptr RPC_STATUS): RPC_SS_THREAD_HANDLE {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmSetClientAllocFree*(P1: PRPC_CLIENT_ALLOC, P2: PRPC_CLIENT_FREE): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmSetThreadHandle*(P1: RPC_SS_THREAD_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc RpcSmSwapClientAllocFree*(P1: PRPC_CLIENT_ALLOC, P2: PRPC_CLIENT_FREE, P3: ptr PRPC_CLIENT_ALLOC, P4: ptr PRPC_CLIENT_FREE): RPC_STATUS {.winapi, dynlib: "rpcrt4", importc.}
proc NdrRpcSsEnableAllocate*(P1: PMIDL_STUB_MESSAGE): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrRpcSsDisableAllocate*(P1: PMIDL_STUB_MESSAGE): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrRpcSmSetClientToOsf*(P1: PMIDL_STUB_MESSAGE): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrRpcSmClientAllocate*(P1: uint32): pointer {.winapi, dynlib: "rpcrt4", importc.}
proc NdrRpcSmClientFree*(P1: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrRpcSsDefaultAllocate*(P1: uint32): pointer {.winapi, dynlib: "rpcrt4", importc.}
proc NdrRpcSsDefaultFree*(P1: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFullPointerXlatInit*(P1: uint32, P2: XLAT_SIDE): PFULL_PTR_XLAT_TABLES {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFullPointerXlatFree*(P1: PFULL_PTR_XLAT_TABLES): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFullPointerQueryPointer*(P1: PFULL_PTR_XLAT_TABLES, P2: pointer, P3: uint8, P4: ptr uint32): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFullPointerQueryRefId*(P1: PFULL_PTR_XLAT_TABLES, P2: uint32, P3: uint8, P4: ptr pointer): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFullPointerInsertRefId*(P1: PFULL_PTR_XLAT_TABLES, P2: uint32, P3: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrFullPointerFree*(P1: PFULL_PTR_XLAT_TABLES, P2: pointer): int32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrAllocate*(P1: PMIDL_STUB_MESSAGE, P2: uint32): pointer {.winapi, dynlib: "rpcrt4", importc.}
proc NdrClearOutParameters*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING, P3: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrOleAllocate*(P1: uint32): pointer {.winapi, dynlib: "rpcrt4", importc.}
proc NdrOleFree*(P1: pointer): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalMarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalUnmarshall*(P1: PMIDL_STUB_MESSAGE, P2: ptr ptr uint8, P3: PFORMAT_STRING, P4: uint8): ptr uint8 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalBufferSize*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalMemorySize*(P1: PMIDL_STUB_MESSAGE, P2: PFORMAT_STRING): uint32 {.winapi, dynlib: "rpcrt4", importc.}
proc NdrUserMarshalFree*(P1: PMIDL_STUB_MESSAGE, P2: ptr uint8, P3: PFORMAT_STRING): void {.winapi, dynlib: "rpcrt4", importc.}

# misc/rpcnsi.nim

type
  RPC_NS_HANDLE* = HANDLE

const
  RPC_C_NS_SYNTAX_DEFAULT* = 0
  RPC_C_NS_SYNTAX_DCE* = 3
  RPC_C_PROFILE_DEFAULT_ELT* = 0
  RPC_C_PROFILE_ALL_ELT* = 1
  RPC_C_PROFILE_MATCH_BY_IF* = 2
  RPC_C_PROFILE_MATCH_BY_MBR* = 3
  RPC_C_PROFILE_MATCH_BY_BOTH* = 4
  RPC_C_NS_DEFAULT_EXP_AGE* = -1

proc RpcNsBindingExportA*(P1: uint32, P2: ptr uint8, P3: RPC_IF_HANDLE, P4: ptr RPC_BINDING_VECTOR, P5: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingUnexportA*(P1: uint32, P2: ptr uint8, P3: RPC_IF_HANDLE, P4: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingLookupBeginA*(P1: uint32, P2: ptr uint8, P3: RPC_IF_HANDLE, P4: ptr UUID, P5: uint32, P6: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingLookupNext*(P1: RPC_NS_HANDLE, P2: ptr ptr RPC_BINDING_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingLookupDone*(P1: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupDeleteA*(P1: uint32, P2: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrAddA*(P1: uint32, P2: ptr uint8, P3: uint32, P4: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrRemoveA*(P1: uint32, P2: ptr uint8, P3: uint32, P4: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqBeginA*(P1: uint32, P2: ptr uint8, P3: uint32, P4: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqNextA*(P1: RPC_NS_HANDLE, P2: ptr ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqDone*(P1: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileDeleteA*(P1: uint32, P2: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltAddA*(P1: uint32, P2: ptr uint8, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr uint8, P6: uint32, P7: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltRemoveA*(P1: uint32, P2: ptr uint8, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqBeginA*(P1: uint32, P2: ptr uint8, P3: uint32, P4: ptr RPC_IF_ID, P5: uint32, P6: uint32, P7: ptr uint8, P8: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqNextA*(P1: RPC_NS_HANDLE, P2: ptr RPC_IF_ID, P3: ptr ptr uint8, P4: ptr uint32, P5: ptr ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqDone*(P1: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsEntryObjectInqNext*(P1: RPC_NS_HANDLE, P2: ptr UUID): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsEntryObjectInqDone*(P1: var ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsEntryExpandNameA*(P1: uint32, P2: ptr uint8, P3: ptr ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtBindingUnexportA*(P1: uint32, P2: ptr uint8, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryCreateA*(P1: uint32, P2: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryDeleteA*(P1: uint32, P2: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryInqIfIdsA*(P1: uint32, P2: ptr uint8, P3: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtHandleSetExpAge*(P1: RPC_NS_HANDLE, P2: uint32): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtInqExpAge*(P1: ptr uint32): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtSetExpAge*(P1: uint32): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingImportNext*(P1: RPC_NS_HANDLE, P2: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingImportDone*(P1: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingSelect*(P1: ptr RPC_BINDING_VECTOR, P2: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsEntryObjectInqBeginA*(P1: uint32, P2: ptr uint8, P3: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingImportBeginA*(P1: uint32, P2: ptr uint8, P3: RPC_IF_HANDLE, P4: ptr UUID, P5: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingExportW*(P1: uint32, P2: ptr uint16, P3: RPC_IF_HANDLE, P4: ptr RPC_BINDING_VECTOR, P5: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingUnexportW*(P1: uint32, P2: ptr uint16, P3: RPC_IF_HANDLE, P4: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingLookupBeginW*(P1: uint32, P2: ptr uint16, P3: RPC_IF_HANDLE, P4: ptr UUID, P5: uint32, P6: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupDeleteW*(P1: uint32, P2: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrAddW*(P1: uint32, P2: ptr uint16, P3: uint32, P4: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrRemoveW*(P1: uint32, P2: ptr uint16, P3: uint32, P4: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqBeginW*(P1: uint32, P2: ptr uint16, P3: uint32, P4: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsGroupMbrInqNextW*(P1: RPC_NS_HANDLE, P2: ptr ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileDeleteW*(P1: uint32, P2: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltAddW*(P1: uint32, P2: ptr uint16, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr uint16, P6: uint32, P7: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltRemoveW*(P1: uint32, P2: ptr uint16, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqBeginW*(P1: uint32, P2: ptr uint16, P3: uint32, P4: ptr RPC_IF_ID, P5: uint32, P6: uint32, P7: ptr uint16, P8: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsProfileEltInqNextW*(P1: RPC_NS_HANDLE, P2: ptr RPC_IF_ID, P3: ptr ptr uint16, P4: ptr uint32, P5: ptr ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsEntryObjectInqBeginW*(P1: uint32, P2: ptr uint16, P3: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsEntryExpandNameW*(P1: uint32, P2: ptr uint16, P3: ptr ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtBindingUnexportW*(P1: uint32, P2: ptr uint16, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryCreateW*(P1: uint32, P2: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryDeleteW*(P1: uint32, P2: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsMgmtEntryInqIfIdsW*(P1: uint32, P2: uint16, P3: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc RpcNsBindingImportBeginW*(P1: uint32, P2: ptr uint16, P3: RPC_IF_HANDLE, P4: ptr UUID, P5: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}

when not defined(winansi):
  proc RpcNsBindingLookupBegin*(P1: uint32, P2: ptr uint16, P3: RPC_IF_HANDLE, P4: ptr UUID, P5: uint32, P6: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsBindingLookupBeginW".}
  proc RpcNsBindingImportBegin*(P1: uint32, P2: ptr uint16, P3: RPC_IF_HANDLE, P4: ptr UUID, P5: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsBindingImportBeginW".}
  proc RpcNsBindingExport*(P1: uint32, P2: ptr uint16, P3: RPC_IF_HANDLE, P4: ptr RPC_BINDING_VECTOR, P5: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsBindingExportW".}
  proc RpcNsBindingUnexport*(P1: uint32, P2: ptr uint16, P3: RPC_IF_HANDLE, P4: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsBindingUnexportW".}
  proc RpcNsGroupDelete*(P1: uint32, P2: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupDeleteW".}
  proc RpcNsGroupMbrAdd*(P1: uint32, P2: ptr uint16, P3: uint32, P4: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupMbrAddW".}
  proc RpcNsGroupMbrRemove*(P1: uint32, P2: ptr uint16, P3: uint32, P4: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupMbrRemoveW".}
  proc RpcNsGroupMbrInqBegin*(P1: uint32, P2: ptr uint16, P3: uint32, P4: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupMbrInqBeginW".}
  proc RpcNsGroupMbrInqNext*(P1: RPC_NS_HANDLE, P2: ptr ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupMbrInqNextW".}
  proc RpcNsEntryExpandName*(P1: uint32, P2: ptr uint16, P3: ptr ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsEntryExpandNameW".}
  proc RpcNsEntryObjectInqBegin*(P1: uint32, P2: ptr uint16, P3: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsEntryObjectInqBeginW".}
  proc RpcNsMgmtBindingUnexport*(P1: uint32, P2: ptr uint16, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsMgmtBindingUnexportW".}
  proc RpcNsMgmtEntryCreate*(P1: uint32, P2: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsMgmtEntryCreateW".}
  proc RpcNsMgmtEntryDelete*(P1: uint32, P2: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsMgmtEntryDeleteW".}
  proc RpcNsMgmtEntryInqIfIds*(P1: uint32, P2: uint16, P3: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsMgmtEntryInqIfIdsW".}
  proc RpcNsProfileDelete*(P1: uint32, P2: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileDeleteW".}
  proc RpcNsProfileEltAdd*(P1: uint32, P2: ptr uint16, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr uint16, P6: uint32, P7: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileEltAddW".}
  proc RpcNsProfileEltRemove*(P1: uint32, P2: ptr uint16, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileEltRemoveW".}
  proc RpcNsProfileEltInqBegin*(P1: uint32, P2: ptr uint16, P3: uint32, P4: ptr RPC_IF_ID, P5: uint32, P6: uint32, P7: ptr uint16, P8: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileEltInqBeginW".}
  proc RpcNsProfileEltInqNext*(P1: RPC_NS_HANDLE, P2: ptr RPC_IF_ID, P3: ptr ptr uint16, P4: ptr uint32, P5: ptr ptr uint16): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileEltInqNextW".}
else:
  proc RpcNsBindingLookupBegin*(P1: uint32, P2: ptr uint8, P3: RPC_IF_HANDLE, P4: ptr UUID, P5: uint32, P6: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsBindingLookupBeginA".}
  proc RpcNsBindingImportBegin*(P1: uint32, P2: ptr uint8, P3: RPC_IF_HANDLE, P4: ptr UUID, P5: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsBindingImportBeginA".}
  proc RpcNsBindingExport*(P1: uint32, P2: ptr uint8, P3: RPC_IF_HANDLE, P4: ptr RPC_BINDING_VECTOR, P5: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsBindingExportA".}
  proc RpcNsBindingUnexport*(P1: uint32, P2: ptr uint8, P3: RPC_IF_HANDLE, P4: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsBindingUnexportA".}
  proc RpcNsGroupDelete*(P1: uint32, P2: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupDeleteA".}
  proc RpcNsGroupMbrAdd*(P1: uint32, P2: ptr uint8, P3: uint32, P4: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupMbrAddA".}
  proc RpcNsGroupMbrRemove*(P1: uint32, P2: ptr uint8, P3: uint32, P4: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupMbrRemoveA".}
  proc RpcNsGroupMbrInqBegin*(P1: uint32, P2: ptr uint8, P3: uint32, P4: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupMbrInqBeginA".}
  proc RpcNsGroupMbrInqNext*(P1: RPC_NS_HANDLE, P2: ptr ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsGroupMbrInqNextA".}
  proc RpcNsEntryExpandName*(P1: uint32, P2: ptr uint8, P3: ptr ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsEntryExpandNameA".}
  proc RpcNsEntryObjectInqBegin*(P1: uint32, P2: ptr uint8, P3: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsEntryObjectInqBeginA".}
  proc RpcNsMgmtBindingUnexport*(P1: uint32, P2: ptr uint8, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr UUID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsMgmtBindingUnexportA".}
  proc RpcNsMgmtEntryCreate*(P1: uint32, P2: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsMgmtEntryCreateA".}
  proc RpcNsMgmtEntryDelete*(P1: uint32, P2: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsMgmtEntryDeleteA".}
  proc RpcNsMgmtEntryInqIfIds*(P1: uint32, P2: ptr uint8, P3: ptr ptr RPC_IF_ID_VECTOR): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsMgmtEntryInqIfIdsA".}
  proc RpcNsProfileDelete*(P1: uint32, P2: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileDeleteA".}
  proc RpcNsProfileEltAdd*(P1: uint32, P2: ptr uint8, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr uint8, P6: uint32, P7: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileEltAddA".}
  proc RpcNsProfileEltRemove*(P1: uint32, P2: ptr uint8, P3: ptr RPC_IF_ID, P4: uint32, P5: ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileEltRemoveA".}
  proc RpcNsProfileEltInqBegin*(P1: uint32, P2: ptr uint8, P3: uint32, P4: ptr RPC_IF_ID, P5: uint32, P6: uint32, P7: ptr uint8, P8: ptr RPC_NS_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileEltInqBeginA".}
  proc RpcNsProfileEltInqNext*(P1: RPC_NS_HANDLE, P2: ptr RPC_IF_ID, P3: ptr ptr uint8, P4: ptr uint32, P5: ptr ptr uint8): RPC_STATUS {.winapi, dynlib: "rpcns4", importc: "RpcNsProfileEltInqNextA".}

# misc/rpcnsip.nim

type
  RPC_IMPORT_CONTEXT_P* {.final, pure.} = object
    LookupContext*: RPC_NS_HANDLE
    ProposedHandle*: RPC_BINDING_HANDLE
    Bindings*: ptr RPC_BINDING_VECTOR
  PRPC_IMPORT_CONTEXT_P* = ptr RPC_IMPORT_CONTEXT_P

proc I_RpcNsGetBuffer*(P1: PRPC_MESSAGE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc I_RpcNsSendReceive*(P1: PRPC_MESSAGE, P2: ptr RPC_BINDING_HANDLE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc I_RpcNsRaiseException*(P1: PRPC_MESSAGE, P2: RPC_STATUS): void {.winapi, dynlib: "rpcns4", importc.}
proc I_RpcReBindBuffer*(P1: PRPC_MESSAGE): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc I_NsServerBindSearch*(): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc I_NsClientBindSearch*(): RPC_STATUS {.winapi, dynlib: "rpcns4", importc.}
proc I_NsClientBindDone*(): void {.winapi, dynlib: "rpcns4", importc.}

# misc/rpcnterr.nim

const
  RPC_S_OK* = ERROR_SUCCESS
  RPC_S_INVALID_ARG* = ERROR_INVALID_PARAMETER
  RPC_S_OUT_OF_MEMORY* = ERROR_OUTOFMEMORY
  RPC_S_OUT_OF_THREADS* = ERROR_MAX_THRDS_REACHED
  RPC_S_INVALID_LEVEL* = ERROR_INVALID_PARAMETER
  RPC_S_BUFFER_TOO_SMALL* = ERROR_INSUFFICIENT_BUFFER
  RPC_S_INVALID_SECURITY_DESC* = ERROR_INVALID_SECURITY_DESCR
  RPC_S_ACCESS_DENIED* = ERROR_ACCESS_DENIED
  RPC_S_SERVER_OUT_OF_MEMORY* = ERROR_NOT_ENOUGH_SERVER_MEMORY
  RPC_X_NO_MEMORY* = RPC_S_OUT_OF_MEMORY
  RPC_X_INVALID_BOUND* = RPC_S_INVALID_BOUND
  RPC_X_INVALID_TAG* = RPC_S_INVALID_TAG
  RPC_X_ENUM_VALUE_TOO_LARGE* = RPC_X_ENUM_VALUE_OUT_OF_RANGE
  RPC_X_SS_CONTEXT_MISMATCH* = ERROR_INVALID_HANDLE
  RPC_X_INVALID_BUFFER* = ERROR_INVALID_USER_BUFFER
  RPC_X_INVALID_PIPE_OPERATION* = RPC_X_WRONG_PIPE_ORDER

# misc/secext.nim
const
  # EXTENDED_NAME_FORMAT* = enum
  NameUnknown* = 0
  NameFullyQualifiedDN* = 1
  NameSamCompatible* = 2
  NameDisplay* = 3
  NameUniqueId* = 6
  NameCanonical* = 7
  NameUserPrincipal* = 8
  NameCanonicalEx* = 9
  NameServicePrincipal* = 10
  NameDnsDomain* = 12

type
  EXTENDED_NAME_FORMAT* = int32
  PEXTENDED_NAME_FORMAT* = ptr EXTENDED_NAME_FORMAT

proc GetComputerObjectNameA*(P1: EXTENDED_NAME_FORMAT, P2: LPSTR, P3: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc.}
proc GetComputerObjectNameW*(P1: EXTENDED_NAME_FORMAT, P2: LPWSTR, P3: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc.}
proc GetUserNameExA*(P1: EXTENDED_NAME_FORMAT, P2: LPSTR, P3: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc.}
proc GetUserNameExW*(P1: EXTENDED_NAME_FORMAT, P2: LPWSTR, P3: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc.}
proc TranslateNameA*(P1: LPCSTR, P2: EXTENDED_NAME_FORMAT, P3: EXTENDED_NAME_FORMAT, P4: LPSTR, P5: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc.}
proc TranslateNameW*(P1: LPCWSTR, P2: EXTENDED_NAME_FORMAT, P3: EXTENDED_NAME_FORMAT, P4: LPWSTR, P5: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc.}

when not defined(winansi):
  proc GetComputerObjectName*(P1: EXTENDED_NAME_FORMAT, P2: LPWSTR, P3: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc: "GetComputerObjectNameW".}
  proc GetUserNameEx*(P1: EXTENDED_NAME_FORMAT, P2: LPWSTR, P3: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc: "GetUserNameExW".}
  proc TranslateName*(P1: LPCWSTR, P2: EXTENDED_NAME_FORMAT, P3: EXTENDED_NAME_FORMAT, P4: LPWSTR, P5: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc: "TranslateNameW".}

else:
  proc GetComputerObjectName*(P1: EXTENDED_NAME_FORMAT, P2: LPSTR, P3: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc: "GetComputerObjectNameA".}
  proc GetUserNameEx*(P1: EXTENDED_NAME_FORMAT, P2: LPSTR, P3: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc: "GetUserNameExA".}
  proc TranslateName*(P1: LPCSTR, P2: EXTENDED_NAME_FORMAT, P3: EXTENDED_NAME_FORMAT, P4: LPSTR, P5: PULONG): BOOLEAN {.winapi, dynlib: "secur32", importc: "TranslateNameA".}

# misc/usp10.nim
const
  # SCRIPT_JUSTIFY* = enum
  SCRIPT_JUSTIFY_NONE* = 0
  SCRIPT_JUSTIFY_ARABIC_BLANK* = 1
  SCRIPT_JUSTIFY_CHARACTER* = 2
  SCRIPT_JUSTIFY_RESERVED1* = 3
  SCRIPT_JUSTIFY_BLANK* = 4
  SCRIPT_JUSTIFY_RESERVED2* = 5
  SCRIPT_JUSTIFY_RESERVED3* = 6
  SCRIPT_JUSTIFY_ARABIC_NORMAL* = 7
  SCRIPT_JUSTIFY_ARABIC_KASHIDA* = 8
  SCRIPT_JUSTIFY_ARABIC_ALEF* = 9
  SCRIPT_JUSTIFY_ARABIC_HA* = 10
  SCRIPT_JUSTIFY_ARABIC_RA* = 11
  SCRIPT_JUSTIFY_ARABIC_BA* = 12
  SCRIPT_JUSTIFY_ARABIC_BARA* = 13
  SCRIPT_JUSTIFY_ARABIC_SEEN* = 14
  SCRIPT_JUSTIFY_ARABIC_SEEN_M* = 15

const
  SCRIPT_UNDEFINED* = 0
  SGCM_RTL* = 0x00000001
  SSA_PASSWORD* = 0x00000001
  SSA_TAB* = 0x00000002
  SSA_CLIP* = 0x00000004
  SSA_FIT* = 0x00000008
  SSA_DZWG* = 0x00000010
  SSA_FALLBACK* = 0x00000020
  SSA_BREAK* = 0x00000040
  SSA_GLYPHS* = 0x00000080
  SSA_RTL* = 0x00000100
  SSA_GCP* = 0x00000200
  SSA_HOTKEY* = 0x00000400
  SSA_METAFILE* = 0x00000800
  SSA_LINK* = 0x00001000
  SSA_HIDEHOTKEY* = 0x00002000
  SSA_HOTKEYONLY* = 0x00002400
  SSA_FULLMEASURE* = 0x04000000
  SSA_LPKANSIFALLBACK* = 0x08000000
  SSA_PIDX* = 0x10000000
  SSA_LAYOUTRTL* = 0x20000000
  SSA_DONTGLYPH* = 0x40000000
  SSA_NOKASHIDA* = 0x80000000'u32
  SIC_COMPLEX* = 1
  SIC_ASCIIDIGIT* = 2
  SIC_NEUTRAL* = 4
  SCRIPT_DIGITSUBSTITUTE_CONTEXT* = 0
  SCRIPT_DIGITSUBSTITUTE_NONE* = 1
  SCRIPT_DIGITSUBSTITUTE_NATIONAL* = 2
  SCRIPT_DIGITSUBSTITUTE_TRADITIONAL* = 3

type
  # SCRIPT_JUSTIFY* = int32
  SCRIPT_CACHE* = pointer
  SCRIPT_STRING_ANALYSIS* = pointer

type
  SCRIPT_CONTROL* {.final, pure.} = object
    uDefaultLanguage* {.bitsize: 16.}: DWORD
    fContextDigits* {.bitsize: 1.}: DWORD
    fInvertPreBoundDir* {.bitsize: 1.}: DWORD
    fInvertPostBoundDir* {.bitsize: 1.}: DWORD
    fLinkStringBefore* {.bitsize: 1.}: DWORD
    fLinkStringAfter* {.bitsize: 1.}: DWORD
    fNeutralOverride* {.bitsize: 1.}: DWORD
    fNumericOverride* {.bitsize: 1.}: DWORD
    fLegacyBidiClass* {.bitsize: 1.}: DWORD
    fMergeNeutralItems* {.bitsize: 1.}: DWORD
    fUseStandardBidi* {.bitsize: 1.}: DWORD
    fReserved* {.bitsize: 6.}: DWORD
  SCRIPT_STATE* {.final, pure.} = object
    uBidiLevel* {.bitsize: 5.}: WORD
    fOverrideDirection* {.bitsize: 1.}: WORD
    fInhibitSymSwap* {.bitsize: 1.}: WORD
    fCharShape* {.bitsize: 1.}: WORD
    fDigitSubstitute* {.bitsize: 1.}: WORD
    fInhibitLigate* {.bitsize: 1.}: WORD
    fDisplayZWG* {.bitsize: 1.}: WORD
    fArabicNumContext* {.bitsize: 1.}: WORD
    fGcpClusters* {.bitsize: 1.}: WORD
    fReserved* {.bitsize: 1.}: WORD
    fEngineReserved* {.bitsize: 2.}: WORD
  SCRIPT_ANALYSIS* {.final, pure.} = object
    eScript* {.bitsize: 10.}: WORD
    fRTL* {.bitsize: 1.}: WORD
    fLayoutRTL* {.bitsize: 1.}: WORD
    fLinkBefore* {.bitsize: 1.}: WORD
    fLinkAfter* {.bitsize: 1.}: WORD
    fLogicalOrder* {.bitsize: 1.}: WORD
    fNoGlyphIndex* {.bitsize: 1.}: WORD
    s*: SCRIPT_STATE
  SCRIPT_ITEM* {.final, pure.} = object
    iCharPos*: int32
    a*: SCRIPT_ANALYSIS
  SCRIPT_VISATTR* {.final, pure.} = object
    uJustification* {.bitsize: 4.}: WORD
    fClusterStart* {.bitsize: 1.}: WORD
    fDiacritic* {.bitsize: 1.}: WORD
    fZeroWidth* {.bitsize: 1.}: WORD
    fReserved* {.bitsize: 1.}: WORD
    fShapeReserved* {.bitsize: 8.}: WORD
  GOFFSET* {.final, pure.} = object
    du*: LONG
    dv*: LONG
  SCRIPT_LOGATTR* {.final, pure.} = object
    fSoftBreak* {.bitsize: 1.}: BYTE
    fWhiteSpace* {.bitsize: 1.}: BYTE
    fCharStop* {.bitsize: 1.}: BYTE
    fWordStop* {.bitsize: 1.}: BYTE
    fInvalid* {.bitsize: 1.}: BYTE
    fReserved* {.bitsize: 3.}: BYTE
  SCRIPT_PROPERTIES* {.final, pure.} = object
    langid* {.bitsize: 16.}: DWORD
    fNumeric* {.bitsize: 1.}: DWORD
    fComplex* {.bitsize: 1.}: DWORD
    fNeedsWordBreaking* {.bitsize: 1.}: DWORD
    fNeedsCaretInfo* {.bitsize: 1.}: DWORD
    bCharSet* {.bitsize: 8.}: DWORD
    fControl* {.bitsize: 1.}: DWORD
    fPrivateUseArea* {.bitsize: 1.}: DWORD
    fNeedsCharacterJustify* {.bitsize: 1.}: DWORD
    fInvalidGlyph* {.bitsize: 1.}: DWORD
    fInvalidLogAttr* {.bitsize: 1.}: DWORD
    fCDM* {.bitsize: 1.}: DWORD
    fAmbiguousCharSet* {.bitsize: 1.}: DWORD
    fClusterSizeVaries* {.bitsize: 1.}: DWORD
    fRejectInvalid* {.bitsize: 1.}: DWORD
  SCRIPT_FONTPROPERTIES* {.final, pure.} = object
    cBytes*: int32
    wgBlank*: WORD
    wgDefault*: WORD
    wgInvalid*: WORD
    wgKashida*: WORD
    iKashidaWidth*: int32
  SCRIPT_TABDEF* {.final, pure.} = object
    cTabStops*: int32
    iScale*: int32
    pTabStops*: ptr int32
    iTabOrigin*: int32
  SCRIPT_DIGITSUBSTITUTE* {.final, pure.} = object
    NationalDigitLanguage* {.bitsize: 16.}: DWORD
    TraditionalDigitLanguage* {.bitsize: 16.}: DWORD
    DigitSubstitute* {.bitsize: 8.}: DWORD
    dwReserved*: DWORD

proc ScriptFreeCache*(P1: ptr SCRIPT_CACHE): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptItemize*(P1: ptr WCHAR, P2: int32, P3: int32, P4: ptr SCRIPT_CONTROL, P5: ptr SCRIPT_STATE, P6: ptr SCRIPT_ITEM, P7: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptLayout*(P1: int32, P2: ptr BYTE, P3: ptr int32, P4: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptShape*(P1: HDC, P2: ptr SCRIPT_CACHE, P3: ptr WCHAR, P4: int32, P5: int32, P6: ptr SCRIPT_ANALYSIS, P7: ptr WORD, P8: ptr WORD, P9: ptr SCRIPT_VISATTR, P10: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptPlace*(P1: HDC, P2: ptr SCRIPT_CACHE, P3: ptr WORD, P4: int32, P5: ptr SCRIPT_VISATTR, P6: ptr SCRIPT_ANALYSIS, P7: ptr int32, P8: ptr GOFFSET, P9: ptr ABC): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptTextOut*(P1: HDC, P2: ptr SCRIPT_CACHE, P3: int32, P4: int32, P5: UINT, P6: ptr RECT, P7: ptr SCRIPT_ANALYSIS, P8: ptr WCHAR, P9: int32, P10: ptr WORD, P11: int32, P12: ptr int32, P13: ptr int32, P14: ptr GOFFSET): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptJustify*(P1: ptr SCRIPT_VISATTR, P2: ptr int32, P3: int32, P4: int32, P5: int32, P6: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptBreak*(P1: ptr WCHAR, P2: int32, P3: ptr SCRIPT_ANALYSIS, P4: ptr SCRIPT_LOGATTR): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptCPtoX*(P1: int32, P2: BOOL, P3: int32, P4: int32, P5: ptr WORD, P6: ptr SCRIPT_VISATTR, P7: ptr int32, P8: ptr SCRIPT_ANALYSIS, P9: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptXtoCP*(P1: int32, P2: int32, P3: int32, P4: ptr WORD, P5: ptr SCRIPT_VISATTR, P6: ptr int32, P7: ptr SCRIPT_ANALYSIS, P8: ptr int32, P9: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptGetLogicalWidths*(P1: ptr SCRIPT_ANALYSIS, P2: int32, P3: int32, P4: ptr int32, P5: ptr WORD, P6: ptr SCRIPT_VISATTR, P7: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptApplyLogicalWidth*(P1: ptr int32, P2: int32, P3: int32, P4: ptr WORD, P5: ptr SCRIPT_VISATTR, P6: ptr int32, P7: ptr SCRIPT_ANALYSIS, P8: ptr ABC, P9: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptGetCMap*(P1: HDC, P2: ptr SCRIPT_CACHE, P3: ptr WCHAR, P4: int32, P5: DWORD, P6: ptr WORD): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptGetGlyphABCWidth*(P1: HDC, P2: ptr SCRIPT_CACHE, P3: WORD, P4: ptr ABC): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptGetProperties*(P1: ptr ptr SCRIPT_PROPERTIES): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptGetFontProperties*(P1: HDC, P2: ptr SCRIPT_CACHE, P3: ptr SCRIPT_FONTPROPERTIES): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptCacheGetHeight*(P1: HDC, P2: ptr SCRIPT_CACHE, P3: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptIsComplex*(P1: ptr WCHAR, P2: int32, P3: DWORD): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptRecordDigitSubstitution*(P1: LCID, P2: ptr SCRIPT_DIGITSUBSTITUTE): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptApplyDigitSubstitution*(P1: ptr SCRIPT_DIGITSUBSTITUTE, P2: ptr SCRIPT_CONTROL, P3: ptr SCRIPT_STATE): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptStringAnalyse*(P1: HDC, P2: pointer, P3: int32, P4: int32, P5: int32, P6: DWORD, P7: int32, P8: ptr SCRIPT_CONTROL, P9: ptr SCRIPT_STATE, P10: ptr int32, P11: ptr SCRIPT_TABDEF, P12: ptr BYTE, P13: ptr SCRIPT_STRING_ANALYSIS): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptStringFree*(P1: ptr SCRIPT_STRING_ANALYSIS): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptStringGetOrder*(P1: SCRIPT_STRING_ANALYSIS, P2: ptr UINT): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptStringCPtoX*(P1: SCRIPT_STRING_ANALYSIS, P2: int32, P3: BOOL, P4: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptStringXtoCP*(P1: SCRIPT_STRING_ANALYSIS, P2: int32, P3: ptr int32, P4: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptStringGetLogicalWidths*(P1: SCRIPT_STRING_ANALYSIS, P2: ptr int32): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptStringValidate*(P1: SCRIPT_STRING_ANALYSIS): HRESULT {.winapi, dynlib: "usp10", importc.}
proc ScriptStringOut*(P1: SCRIPT_STRING_ANALYSIS, P2: int32, P3: int32, P4: UINT, P5: ptr RECT, P6: int32, P7: int32, P8: BOOL): HRESULT {.winapi, dynlib: "usp10", importc.}

# misc/winperf.nim

const
  PERF_DATA_VERSION* = 1
  PERF_DATA_REVISION* = 1
  PERF_NO_INSTANCES* = -1
  PERF_SIZE_DWORD* = 0
  PERF_SIZE_LARGE* = 256
  PERF_SIZE_ZERO* = 512
  PERF_SIZE_VARIABLE_LEN* = 768
  PERF_TYPE_NUMBER* = 0
  PERF_TYPE_COUNTER* = 1024
  PERF_TYPE_TEXT* = 2048
  PERF_TYPE_ZERO* = 0xC00
  PERF_NUMBER_HEX* = 0
  PERF_NUMBER_DECIMAL* = 0x10000
  PERF_NUMBER_DEC_1000* = 0x20000
  PERF_COUNTER_VALUE* = 0
  PERF_COUNTER_RATE* = 0x10000
  PERF_COUNTER_FRACTION* = 0x20000
  PERF_COUNTER_BASE* = 0x30000
  PERF_COUNTER_ELAPSED* = 0x40000
  PERF_COUNTER_QUEUELEN* = 0x50000
  PERF_COUNTER_HISTOGRAM* = 0x60000
  PERF_TEXT_UNICODE* = 0
  PERF_TEXT_ASCII* = 0x10000
  PERF_TIMER_TICK* = 0
  PERF_TIMER_100NS* = 0x100000
  PERF_OBJECT_TIMER* = 0x200000
  PERF_DELTA_COUNTER* = 0x400000
  PERF_DELTA_BASE* = 0x800000
  PERF_INVERSE_COUNTER* = 0x1000000
  PERF_MULTI_COUNTER* = 0x2000000
  PERF_DISPLAY_NO_SUFFIX* = 0
  PERF_DISPLAY_PER_SEC* = 0x10000000
  PERF_DISPLAY_PERCENT* = 0x20000000
  PERF_DISPLAY_SECONDS* = 0x30000000
  PERF_DISPLAY_NOSHOW* = 0x40000000
  PERF_COUNTER_HISTOGRAM_TYPE* = 0x80000000'i32
  PERF_NO_UNIQUE_ID* = ( -1 )
  PERF_DETAIL_NOVICE* = 100
  PERF_DETAIL_ADVANCED* = 200
  PERF_DETAIL_EXPERT* = 300
  PERF_DETAIL_WIZARD* = 400
  PERF_COUNTER_COUNTER* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_TICK or PERF_DELTA_COUNTER or PERF_DISPLAY_PER_SEC )
  PERF_COUNTER_TIMER* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_TICK or PERF_DELTA_COUNTER or PERF_DISPLAY_PERCENT )
  PERF_COUNTER_QUEUELEN_TYPE* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_QUEUELEN or PERF_TIMER_TICK or PERF_DELTA_COUNTER or PERF_DISPLAY_NO_SUFFIX )
  PERF_COUNTER_BULK_COUNT* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_TICK or PERF_DELTA_COUNTER or PERF_DISPLAY_PER_SEC )
  PERF_COUNTER_TEXT* = ( PERF_SIZE_VARIABLE_LEN or PERF_TYPE_TEXT or PERF_TEXT_UNICODE or PERF_DISPLAY_NO_SUFFIX )
  PERF_COUNTER_RAWCOUNT* = ( PERF_SIZE_DWORD or PERF_TYPE_NUMBER or PERF_NUMBER_DECIMAL or PERF_DISPLAY_NO_SUFFIX )
  PERF_COUNTER_LARGE_RAWCOUNT* = ( PERF_SIZE_LARGE or PERF_TYPE_NUMBER or PERF_NUMBER_DECIMAL or PERF_DISPLAY_NO_SUFFIX )
  PERF_COUNTER_RAWCOUNT_HEX* = ( PERF_SIZE_DWORD or PERF_TYPE_NUMBER or PERF_NUMBER_HEX or PERF_DISPLAY_NO_SUFFIX )
  PERF_COUNTER_LARGE_RAWCOUNT_HEX* = ( PERF_SIZE_LARGE or PERF_TYPE_NUMBER or PERF_NUMBER_HEX or PERF_DISPLAY_NO_SUFFIX )
  PERF_SAMPLE_FRACTION* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_FRACTION or PERF_DELTA_COUNTER or PERF_DELTA_BASE or PERF_DISPLAY_PERCENT )
  PERF_SAMPLE_COUNTER* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_TICK or PERF_DELTA_COUNTER or PERF_DISPLAY_NO_SUFFIX )
  PERF_COUNTER_NODATA* = ( PERF_SIZE_ZERO or PERF_DISPLAY_NOSHOW )
  PERF_COUNTER_TIMER_INV* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_TICK or PERF_DELTA_COUNTER or PERF_INVERSE_COUNTER or PERF_DISPLAY_PERCENT )
  PERF_SAMPLE_BASE* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_BASE or PERF_DISPLAY_NOSHOW or 1 )
  PERF_AVERAGE_TIMER* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_FRACTION or PERF_DISPLAY_SECONDS )
  PERF_AVERAGE_BASE* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_BASE or PERF_DISPLAY_NOSHOW or 2 )
  PERF_AVERAGE_BULK* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_FRACTION or PERF_DISPLAY_NOSHOW )
  PERF_100NSEC_TIMER* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_100NS or PERF_DELTA_COUNTER or PERF_DISPLAY_PERCENT )
  PERF_100NSEC_TIMER_INV* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_100NS or PERF_DELTA_COUNTER or PERF_INVERSE_COUNTER or PERF_DISPLAY_PERCENT )
  PERF_COUNTER_MULTI_TIMER* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_DELTA_COUNTER or PERF_TIMER_TICK or PERF_MULTI_COUNTER or PERF_DISPLAY_PERCENT )
  PERF_COUNTER_MULTI_TIMER_INV* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_RATE or PERF_DELTA_COUNTER or PERF_MULTI_COUNTER or PERF_TIMER_TICK or PERF_INVERSE_COUNTER or PERF_DISPLAY_PERCENT )
  PERF_COUNTER_MULTI_BASE* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_BASE or PERF_MULTI_COUNTER or PERF_DISPLAY_NOSHOW )
  PERF_100NSEC_MULTI_TIMER* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_DELTA_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_100NS or PERF_MULTI_COUNTER or PERF_DISPLAY_PERCENT )
  PERF_100NSEC_MULTI_TIMER_INV* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_DELTA_COUNTER or PERF_COUNTER_RATE or PERF_TIMER_100NS or PERF_MULTI_COUNTER or PERF_INVERSE_COUNTER or PERF_DISPLAY_PERCENT )
  PERF_RAW_FRACTION* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_FRACTION or PERF_DISPLAY_PERCENT )
  PERF_RAW_BASE* = ( PERF_SIZE_DWORD or PERF_TYPE_COUNTER or PERF_COUNTER_BASE or PERF_DISPLAY_NOSHOW or 3 )
  PERF_ELAPSED_TIME* = ( PERF_SIZE_LARGE or PERF_TYPE_COUNTER or PERF_COUNTER_ELAPSED or PERF_OBJECT_TIMER or PERF_DISPLAY_SECONDS )

type
  PERF_DATA_BLOCK* {.final, pure.} = object
    Signature*: array[4, WCHAR]
    LittleEndian*: DWORD
    Version*: DWORD
    Revision*: DWORD
    TotalByteLength*: DWORD
    HeaderLength*: DWORD
    NumObjectTypes*: DWORD
    DefaultObject*: LONG
    SystemTime*: SYSTEMTIME
    PerfTime*: LARGE_INTEGER
    PerfFreq*: LARGE_INTEGER
    PerfTime100nSec*: LARGE_INTEGER
    SystemNameLength*: DWORD
    SystemNameOffset*: DWORD
  PPERF_DATA_BLOCK* = ptr PERF_DATA_BLOCK
  PERF_OBJECT_TYPE* {.final, pure.} = object
    TotalByteLength*: DWORD
    DefinitionLength*: DWORD
    HeaderLength*: DWORD
    ObjectNameTitleIndex*: DWORD
    ObjectNameTitle*: LPWSTR
    ObjectHelpTitleIndex*: DWORD
    ObjectHelpTitle*: LPWSTR
    DetailLevel*: DWORD
    NumCounters*: DWORD
    DefaultCounter*: LONG
    NumInstances*: LONG
    CodePage*: DWORD
    PerfTime*: LARGE_INTEGER
    PerfFreq*: LARGE_INTEGER
  PPERF_OBJECT_TYPE* = ptr PERF_OBJECT_TYPE
  PERF_COUNTER_DEFINITION* {.final, pure.} = object
    ByteLength*: DWORD
    CounterNameTitleIndex*: DWORD
    CounterNameTitle*: LPWSTR
    CounterHelpTitleIndex*: DWORD
    CounterHelpTitle*: LPWSTR
    DefaultScale*: LONG
    DetailLevel*: DWORD
    CounterType*: DWORD
    CounterSize*: DWORD
    CounterOffset*: DWORD
  PPERF_COUNTER_DEFINITION* = ptr PERF_COUNTER_DEFINITION
  PERF_INSTANCE_DEFINITION* {.final, pure.} = object
    ByteLength*: DWORD
    ParentObjectTitleIndex*: DWORD
    ParentObjectInstance*: DWORD
    UniqueID*: LONG
    NameOffset*: DWORD
    NameLength*: DWORD
  PPERF_INSTANCE_DEFINITION* = ptr PERF_INSTANCE_DEFINITION
  PERF_COUNTER_BLOCK* {.final, pure.} = object
    ByteLength*: DWORD
  PPERF_COUNTER_BLOCK* = ptr PERF_COUNTER_BLOCK
  PM_OPEN_PROC* = proc (P1: LPWSTR): DWORD {.stdcall.}
  PM_COLLECT_PROC* = proc (P1: LPWSTR, P2: ptr PVOID, P3: PDWORD, P4: PDWORD): DWORD {.cdecl.}
  PM_CLOSE_PROC* = proc (): DWORD {.cdecl.}

/* Auto generated by make_method_table.rb */
#include "symbol_builtin.h"
struct RClass *mrbc_init_class_hash(struct VM *vm)
{
  static const mrbc_sym method_symbols[] = {
    MRBC_SYMID_BLL_BLR,
    MRBC_SYMID_BLL_BLR_EQ,
    MRBC_SYMID_clear,
    MRBC_SYMID_count,
    MRBC_SYMID_delete,
    MRBC_SYMID_dup,
    MRBC_SYMID_empty_Q,
    MRBC_SYMID_has_key_Q,
    MRBC_SYMID_has_value_Q,
#if MRBC_USE_STRING
    MRBC_SYMID_inspect,
#endif
    MRBC_SYMID_key,
    MRBC_SYMID_keys,
    MRBC_SYMID_length,
    MRBC_SYMID_merge,
    MRBC_SYMID_merge_EXC,
    MRBC_SYMID_new,
    MRBC_SYMID_size,
    MRBC_SYMID_to_h,
#if MRBC_USE_STRING
    MRBC_SYMID_to_s,
#endif
    MRBC_SYMID_values,
  };
  static const mrbc_func_t method_functions[] = {
    c_hash_get,
    c_hash_set,
    c_hash_clear,
    c_hash_size,
    c_hash_delete,
    c_hash_dup,
    c_hash_empty,
    c_hash_has_key,
    c_hash_has_value,
#if MRBC_USE_STRING
    c_hash_inspect,
#endif
    c_hash_key,
    c_hash_keys,
    c_hash_size,
    c_hash_merge,
    c_hash_merge_self,
    c_hash_new,
    c_hash_size,
    c_ineffect,
#if MRBC_USE_STRING
    c_hash_inspect,
#endif
    c_hash_values,
  };

  return mrbc_define_builtin_class("Hash", mrbc_class_object, method_symbols, method_functions, sizeof(method_symbols)/sizeof(mrbc_sym) );
}

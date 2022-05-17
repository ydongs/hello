; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-unknown | FileCheck %s

define i64 @sub1_disguised_constant(i64 %x) {
; CHECK-LABEL: sub1_disguised_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w8, w0, #1
; CHECK-NEXT:    and w8, w0, w8
; CHECK-NEXT:    and x0, x8, #0xffff
; CHECK-NEXT:    ret
  %a1 = and i64 %x, 65535
  %a2 = add i64 %x, 65535
  %r = and i64 %a1, %a2
  ret i64 %r
}

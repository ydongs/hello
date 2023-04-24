; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -o - %s -mtriple=aarch64-none-linux-gnu | FileCheck %s

define <16 x i8> @test1(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b) {
; CHECK-LABEL: test1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldrb w8, [x0]
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov v0.b[1], w8
; CHECK-NEXT:    mov v0.b[2], w8
; CHECK-NEXT:    mov v0.b[3], w8
; CHECK-NEXT:    mov v0.b[4], w8
; CHECK-NEXT:    mov v0.b[5], w8
; CHECK-NEXT:    mov v0.b[6], w8
; CHECK-NEXT:    mov v0.b[7], w8
; CHECK-NEXT:    ldrb w8, [x1]
; CHECK-NEXT:    mov v0.b[8], w8
; CHECK-NEXT:    mov v0.b[9], w8
; CHECK-NEXT:    mov v0.b[10], w8
; CHECK-NEXT:    mov v0.b[11], w8
; CHECK-NEXT:    mov v0.b[12], w8
; CHECK-NEXT:    mov v0.b[13], w8
; CHECK-NEXT:    mov v0.b[14], w8
; CHECK-NEXT:    mov v0.b[15], w8
; CHECK-NEXT:    ret
entry:
  %0 = load i8, ptr %a, align 1
  %1 = insertelement <8 x i8> poison, i8 %0, i64 0
  %lane = shufflevector <8 x i8> %1, <8 x i8> poison, <8 x i32> zeroinitializer
  %2 = load i8, ptr %b, align 1
  %3 = insertelement <8 x i8> poison, i8 %2, i64 0
  %lane2 = shufflevector <8 x i8> %3, <8 x i8> poison, <8 x i32> zeroinitializer
  %shuffle.i = shufflevector <8 x i8> %lane, <8 x i8> %lane2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  ret <16 x i8> %shuffle.i
}

define <16 x i8> @test2(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b) {
; CHECK-LABEL: test2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ld1r { v1.8b }, [x1]
; CHECK-NEXT:    ldrb w8, [x0]
; CHECK-NEXT:    dup v0.8b, w8
; CHECK-NEXT:    mov v1.b[7], w8
; CHECK-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-NEXT:    ret
entry:
  %0 = load i8, ptr %a, align 1
  %1 = insertelement <8 x i8> poison, i8 %0, i64 0
  %lane = shufflevector <8 x i8> %1, <8 x i8> poison, <8 x i32> zeroinitializer
  %2 = load i8, ptr %b, align 1
  %3 = insertelement <8 x i8> poison, i8 %2, i64 0
  %lane2 = shufflevector <8 x i8> %3, <8 x i8> poison, <8 x i32> zeroinitializer
  %shuffle.i = shufflevector <8 x i8> %lane, <8 x i8> %lane2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 0>
  ret <16 x i8> %shuffle.i
}

define <16 x i8> @test3(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b) {
; CHECK-LABEL: test3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ld1r { v0.8b }, [x0]
; CHECK-NEXT:    ld1r { v1.8b }, [x1]
; CHECK-NEXT:    zip1 v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
entry:
  %0 = load i8, ptr %a, align 1
  %1 = insertelement <8 x i8> poison, i8 %0, i64 0
  %lane = shufflevector <8 x i8> %1, <8 x i8> poison, <8 x i32> zeroinitializer
  %2 = load i8, ptr %b, align 1
  %3 = insertelement <8 x i8> poison, i8 %2, i64 0
  %lane2 = shufflevector <8 x i8> %3, <8 x i8> poison, <8 x i32> zeroinitializer
  %shuffle.i = shufflevector <8 x i8> %lane, <8 x i8> %lane2, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  ret <16 x i8> %shuffle.i
}

define <16 x i8> @test4(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b) {
; CHECK-LABEL: test4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldrb w8, [x1]
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov v0.b[1], w8
; CHECK-NEXT:    mov v0.b[2], w8
; CHECK-NEXT:    mov v0.b[3], w8
; CHECK-NEXT:    mov v0.b[4], w8
; CHECK-NEXT:    mov v0.b[5], w8
; CHECK-NEXT:    mov v0.b[6], w8
; CHECK-NEXT:    mov v0.b[7], w8
; CHECK-NEXT:    ldrb w8, [x0]
; CHECK-NEXT:    mov v0.b[8], w8
; CHECK-NEXT:    mov v0.b[9], w8
; CHECK-NEXT:    mov v0.b[10], w8
; CHECK-NEXT:    mov v0.b[11], w8
; CHECK-NEXT:    mov v0.b[12], w8
; CHECK-NEXT:    mov v0.b[13], w8
; CHECK-NEXT:    mov v0.b[14], w8
; CHECK-NEXT:    mov v0.b[15], w8
; CHECK-NEXT:    ret
entry:
  %0 = load i8, ptr %a, align 1
  %1 = insertelement <8 x i8> poison, i8 %0, i64 0
  %lane = shufflevector <8 x i8> %1, <8 x i8> poison, <8 x i32> zeroinitializer
  %2 = load i8, ptr %b, align 1
  %3 = insertelement <8 x i8> poison, i8 %2, i64 0
  %lane2 = shufflevector <8 x i8> %3, <8 x i8> poison, <8 x i32> zeroinitializer
  %shuffle.i = shufflevector <8 x i8> %lane, <8 x i8> %lane2, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <16 x i8> %shuffle.i
}

define <16 x i8> @test5(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b) {
; CHECK-LABEL: test5:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    adrp x8, .LCPI4_0
; CHECK-NEXT:    ldr b0, [x0]
; CHECK-NEXT:    ld1r { v1.16b }, [x1]
; CHECK-NEXT:    ldr q2, [x8, :lo12:.LCPI4_0]
; CHECK-NEXT:    tbl v0.16b, { v0.16b, v1.16b }, v2.16b
; CHECK-NEXT:    ret
entry:
  %0 = load i8, ptr %a, align 1
  %1 = insertelement <8 x i8> poison, i8 %0, i64 0
  %lane = shufflevector <8 x i8> %1, <8 x i8> poison, <8 x i32> zeroinitializer
  %2 = load i8, ptr %b, align 1
  %3 = insertelement <8 x i8> poison, i8 %2, i64 0
  %lane2 = shufflevector <8 x i8> %3, <8 x i8> poison, <8 x i32> zeroinitializer
  %shuffle.i = shufflevector <8 x i8> %lane, <8 x i8> %lane2, <16 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 15>
  ret <16 x i8> %shuffle.i
}

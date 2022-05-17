; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main %s -o - | FileCheck %s

define void @cbz_exit(i32* %in, i32* %res) {
; CHECK-LABEL: cbz_exit:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    subs r2, r0, #4
; CHECK-NEXT:    mov.w r0, #-1
; CHECK-NEXT:  .LBB0_1: @ %loop
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr r3, [r2, #4]!
; CHECK-NEXT:    adds r0, #1
; CHECK-NEXT:    cbz r3, .LBB0_2
; CHECK-NEXT:    le .LBB0_1
; CHECK-NEXT:  .LBB0_2: @ %exit
; CHECK-NEXT:    str r0, [r1]
; CHECK-NEXT:    bx lr
entry:
  br label %loop

loop:
  %offset = phi i32 [ 0, %entry ], [ %next, %loop ]
  %ptr = getelementptr i32, i32* %in, i32 %offset
  %val = load i32, i32* %ptr
  %next = add i32 %offset, 1
  %cmp = icmp eq i32 %val, 0
  br i1 %cmp, label %exit, label %loop

exit:
  store i32 %offset, i32* %res
  ret void
}

define void @cbnz_exit(i32* %in, i32* %res) {
; CHECK-LABEL: cbnz_exit:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    subs r2, r0, #4
; CHECK-NEXT:    mov.w r0, #-1
; CHECK-NEXT:  .LBB1_1: @ %loop
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr r3, [r2, #4]!
; CHECK-NEXT:    adds r0, #1
; CHECK-NEXT:    cbnz r3, .LBB1_2
; CHECK-NEXT:    le .LBB1_1
; CHECK-NEXT:  .LBB1_2: @ %exit
; CHECK-NEXT:    str r0, [r1]
; CHECK-NEXT:    bx lr
entry:
  br label %loop

loop:
  %offset = phi i32 [ 0, %entry ], [ %next, %loop ]
  %ptr = getelementptr i32, i32* %in, i32 %offset
  %val = load i32, i32* %ptr
  %next = add i32 %offset, 1
  %cmp = icmp ne i32 %val, 0
  br i1 %cmp, label %exit, label %loop

exit:
  store i32 %offset, i32* %res
  ret void
}

define void @cbnz_exit_too_large(i32* %in, i32* %res) {
; CHECK-LABEL: cbnz_exit_too_large:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    subs r2, r0, #4
; CHECK-NEXT:    mov.w r0, #-1
; CHECK-NEXT:  .LBB2_1: @ %loop
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr r12, [r2, #4]!
; CHECK-NEXT:    .zero 4090
; CHECK-NEXT:    adds r0, #1
; CHECK-NEXT:    cmp.w r12, #0
; CHECK-NEXT:    beq.w .LBB2_1
; CHECK-NEXT:  @ %bb.2: @ %exit
; CHECK-NEXT:    str r0, [r1]
; CHECK-NEXT:    bx lr
entry:
  br label %loop

loop:
  %offset = phi i32 [ 0, %entry ], [ %next, %loop ]
  %ptr = getelementptr i32, i32* %in, i32 %offset
  %val = load i32, i32* %ptr
  %next = add i32 %offset, 1
  %cmp = icmp ne i32 %val, 0
  %size = call i32 @llvm.arm.space(i32 4090, i32 undef)
  br i1 %cmp, label %exit, label %loop

exit:
  store i32 %offset, i32* %res
  ret void
}

define void @cbz_exit_minsize(i32* %in, i32* %res) #0 {
; CHECK-LABEL: cbz_exit_minsize:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    movs r2, #0
; CHECK-NEXT:  .LBB3_1: @ %loop
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr.w r3, [r0, r2, lsl #2]
; CHECK-NEXT:    adds r2, #1
; CHECK-NEXT:    cmp r3, #0
; CHECK-NEXT:    bne .LBB3_1
; CHECK-NEXT:  @ %bb.2: @ %exit
; CHECK-NEXT:    subs r0, r2, #1
; CHECK-NEXT:    str r0, [r1]
; CHECK-NEXT:    bx lr
entry:
  br label %loop

loop:
  %offset = phi i32 [ 0, %entry ], [ %next, %loop ]
  %ptr = getelementptr i32, i32* %in, i32 %offset
  %val = load i32, i32* %ptr
  %next = add i32 %offset, 1
  %cmp = icmp eq i32 %val, 0
  br i1 %cmp, label %exit, label %loop

exit:
  store i32 %offset, i32* %res
  ret void
}

define void @cbnz_exit_minsize(i32* %in, i32* %res) #0 {
; CHECK-LABEL: cbnz_exit_minsize:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    movs r2, #0
; CHECK-NEXT:  .LBB4_1: @ %loop
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr.w r3, [r0, r2, lsl #2]
; CHECK-NEXT:    adds r2, #1
; CHECK-NEXT:    cmp r3, #0
; CHECK-NEXT:    beq .LBB4_1
; CHECK-NEXT:  @ %bb.2: @ %exit
; CHECK-NEXT:    subs r0, r2, #1
; CHECK-NEXT:    str r0, [r1]
; CHECK-NEXT:    bx lr
entry:
  br label %loop

loop:
  %offset = phi i32 [ 0, %entry ], [ %next, %loop ]
  %ptr = getelementptr i32, i32* %in, i32 %offset
  %val = load i32, i32* %ptr
  %next = add i32 %offset, 1
  %cmp = icmp ne i32 %val, 0
  br i1 %cmp, label %exit, label %loop

exit:
  store i32 %offset, i32* %res
  ret void
}

attributes #0 = { minsize optsize }

declare i32 @llvm.arm.space(i32 immarg, i32);
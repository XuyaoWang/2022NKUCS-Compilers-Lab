declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @if_ifElse_() {
B3:
  %t5 = alloca i0, align 4
  %t4 = alloca i0, align 4
  store i0 5, i0* %t4, align 4
  store i0 10, i0* %t5, align 4
  %t9 = load i0, i0* %t4, align 4
  %t8 = icmp eq i0 %t9, 5
  br i0 %t8, label %B6, label %B12
B6:                               	; preds = %B3
  %t17 = load i0, i0* %t5, align 4
  %t16 = icmp eq i0 %t17, 10
  br i0 %t16, label %B13, label %B20
B12:                               	; preds = %B3
  br label %B7
B13:                               	; preds = %B6
  store i0 25, i0* %t4, align 4
  br label %B15
B20:                               	; preds = %B6
  br label %B14
B7:                               	; preds = %B12, %B15
  %t23 = load i0, i0* %t4, align 4
  ret i0 %t23
B15:                               	; preds = %B13, %B14
  br label %B7
B14:                               	; preds = %B20
  %t22 = load i0, i0* %t4, align 4
  %t21 = add i0 %t22, 15
  store i0 %t21, i0* %t4, align 4
  br label %B15
}
define i0 @main() {
B24:
  %t25 = call i0 @if_ifElse_(i0 %t25)
  ret i0 %t25
}

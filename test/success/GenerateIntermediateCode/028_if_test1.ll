declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @ifElse() {
B2:
  %t3 = alloca i0, align 4
  store i0 5, i0* %t3, align 4
  %t8 = load i0, i0* %t3, align 4
  %t7 = icmp eq i0 %t8, 5
  br i0 %t7, label %B4, label %B11
B4:                               	; preds = %B2
  store i0 25, i0* %t3, align 4
  br label %B6
B11:                               	; preds = %B2
  br label %B5
B6:                               	; preds = %B4, %B5
  %t14 = load i0, i0* %t3, align 4
  ret i0 %t14
B5:                               	; preds = %B11
  %t13 = load i0, i0* %t3, align 4
  %t12 = mul i0 %t13, 2
  store i0 %t12, i0* %t3, align 4
  br label %B6
}
define i0 @main() {
B15:
  %t16 = call i0 @ifElse(i0 %t16)
  ret i0 %t16
}

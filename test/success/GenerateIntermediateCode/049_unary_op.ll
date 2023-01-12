declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @main() {
B15:
  %t16 = alloca i0, align 4
  store i0 10, i0* %t16, align 4
  %t20 = load i0, i0* %t16, align 4
  %t22 = icmp ne i0 %t20, 0
  %t21 = xor i0 %t22, true
  %t23 = xor i0 %t21, true
  %t24 = xor i0 %t23, true
  %t25 = zext i0 %t24 to i32
  %t10 = sub i0 0, %t25
  %t11 = icmp ne i0 %t10, 0
  br i0 %t11, label %B17, label %B27
B17:                               	; preds = %B15
  %t12 = sub i0 0, 1
  %t13 = sub i0 0, %t12
  %t14 = sub i0 0, %t13
  store i0 %t14, i0* %t16, align 4
  br label %B19
B27:                               	; preds = %B15
  br label %B18
B19:                               	; preds = %B17, %B18
  %t29 = load i0, i0* %t16, align 4
  ret i0 %t29
B18:                               	; preds = %B27
  store i0 0, i0* %t16, align 4
  br label %B19
}

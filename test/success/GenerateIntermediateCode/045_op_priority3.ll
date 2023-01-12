declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @main() {
B7:
  %t9 = alloca i0, align 4
  %t8 = alloca i0, align 4
  store i0 10, i0* %t8, align 4
  store i0 30, i0* %t9, align 4
  %t13 = load i0, i0* %t8, align 4
  %t5 = sub i0 0, 5
  %t12 = sub i0 %t13, %t5
  %t14 = load i0, i0* %t9, align 4
  %t11 = add i0 %t12, %t14
  %t6 = sub i0 0, 5
  %t10 = add i0 %t11, %t6
  ret i0 %t10
}

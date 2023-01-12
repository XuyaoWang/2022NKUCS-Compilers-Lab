declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @main() {
B2:
  %t4 = alloca i0, align 4
  %t3 = alloca i0, align 4
  store i0 15, i0* %t3, align 4
  store i0 12, i0* %t4, align 4
  %t7 = load i0, i0* %t3, align 4
  %t8 = load i0, i0* %t4, align 4
  %t6 = add i0 %t7, %t8
  %t5 = add i0 %t6, 61
  ret i0 %t5
}

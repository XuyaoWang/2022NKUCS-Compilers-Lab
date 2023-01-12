declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @main() {
B1:
  %t4 = alloca i0, align 4
  %t3 = alloca i0, align 4
  %t2 = alloca i0, align 4
  store i0 1, i0* %t2, align 4
  store i0 2, i0* %t3, align 4
  store i0 3, i0* %t4, align 4
  %t6 = load i0, i0* %t3, align 4
  %t7 = load i0, i0* %t4, align 4
  %t5 = add i0 %t6, %t7
  ret i0 %t5
}

declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @main() {
B1:
  %t2 = alloca i0, align 4
  store i0 10, i0* %t2, align 4
  %t4 = load i0, i0* %t2, align 4
  %t3 = srem i0 %t4, 3
  ret i0 %t3
}

declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @main() {
B0:
  %t1 = alloca i0, align 4
  store i0 15, i0* %t1, align 4
  %t2 = load i0, i0* %t1, align 4
  ret i0 %t2
}

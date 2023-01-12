declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i0 10, align 4
define i0 @main() {
B0:
  %t1 = load i0, i0* @a, align 4
  ret i0 %t1
}

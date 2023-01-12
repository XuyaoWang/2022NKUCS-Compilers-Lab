declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i0 10, align 4
define i0 @main() {
B1:
  %t3 = load i0, i0* @a, align 4
  %t2 = sdiv i0 %t3, 5
  ret i0 %t2
}

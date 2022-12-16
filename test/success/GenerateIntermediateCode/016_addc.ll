declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i32 10, align 4
define i32 @main() {
B1:
  %fail3 = load i32, i32* @a, align 4
  %fail2 = add i32 %fail3, 5
  ret i32 %fail2
}

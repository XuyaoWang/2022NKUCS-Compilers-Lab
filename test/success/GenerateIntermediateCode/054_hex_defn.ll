declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B0:
  %fail1 = alloca i32, align 4
  store i32 15, i32* %fail1, align 4
  %fail2 = load i32, i32* %fail1, align 4
  ret i32 %fail2
}

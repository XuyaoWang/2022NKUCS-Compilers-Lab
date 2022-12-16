declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B0:
  %fail2 = alloca i32, align 4
  %fail1 = alloca i32, align 4
  store i32 10, i32* %fail1, align 4
  store i32 5, i32* %fail2, align 4
  %fail3 = load i32, i32* %fail2, align 4
  ret i32 %fail3
}

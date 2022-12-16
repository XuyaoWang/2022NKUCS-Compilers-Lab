declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B1:
  %fail4 = alloca i32, align 4
  %fail3 = alloca i32, align 4
  %fail2 = alloca i32, align 4
  store i32 1, i32* %fail2, align 4
  store i32 2, i32* %fail3, align 4
  store i32 3, i32* %fail4, align 4
  %fail6 = load i32, i32* %fail3, align 4
  %fail7 = load i32, i32* %fail4, align 4
  %fail5 = add i32 %fail6, %fail7
  ret i32 %fail5
}

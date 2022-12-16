declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i32 10, align 4
define i32 @main() {
B1:
  %fail2 = alloca i32, align 4
  store i32 2, i32* %fail2, align 4
  %fail4 = load i32, i32* %fail2, align 4
  %fail5 = load i32, i32* @a, align 4
  %fail3 = sub i32 %fail4, %fail5
  ret i32 %fail3
}

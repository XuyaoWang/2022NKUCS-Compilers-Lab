declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B2:
  %fail3 = alloca i32, align 4
  store i32 10, i32* %fail3, align 4
  %fail6 = load i32, i32* %fail3, align 4
  %fail5 = mul i32 %fail6, 2
  %fail4 = add i32 %fail5, 1
  ret i32 %fail4
}

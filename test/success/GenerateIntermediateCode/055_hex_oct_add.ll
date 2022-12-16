declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B2:
  %fail4 = alloca i32, align 4
  %fail3 = alloca i32, align 4
  store i32 15, i32* %fail3, align 4
  store i32 12, i32* %fail4, align 4
  %fail7 = load i32, i32* %fail3, align 4
  %fail8 = load i32, i32* %fail4, align 4
  %fail6 = add i32 %fail7, %fail8
  %fail5 = add i32 %fail6, 61
  ret i32 %fail5
}

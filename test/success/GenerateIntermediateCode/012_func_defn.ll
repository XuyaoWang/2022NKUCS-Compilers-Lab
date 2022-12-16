declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i32 0, align 4
define i32 @func(i32 %fail3) {
B2:
  %fail4 = alloca i32, align 4
  store i32 %fail3, i32* %fail4, align 4
  %fail6 = load i32, i32* %fail4, align 4
  %fail5 = sub i32 %fail6, 1
  store i32 %fail5, i32* %fail4, align 4
  %fail7 = load i32, i32* %fail4, align 4
  ret i32 %fail7
}
define i32 @main() {
B8:
  %fail9 = alloca i32, align 4
  store i32 10, i32* @a, align 4
  %fail10 = load i32, i32* @a, align 4
  %fail11 = call i32 @func(i32 %fail10)
  store i32 %fail11, i32* %fail9, align 4
  %fail12 = load i32, i32* %fail9, align 4
  ret i32 %fail12
}

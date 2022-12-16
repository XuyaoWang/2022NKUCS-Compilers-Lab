declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B5:
  %fail7 = alloca i32, align 4
  %fail6 = alloca i32, align 4
  store i32 10, i32* %fail6, align 4
  store i32 30, i32* %fail7, align 4
  %fail11 = load i32, i32* %fail6, align 4
  %fail12 = sub i32 0, 5
  %fail10 = sub i32 %fail11, %fail12
  %fail13 = load i32, i32* %fail7, align 4
  %fail9 = add i32 %fail10, %fail13
  %fail14 = sub i32 0, 5
  %fail8 = add i32 %fail9, %fail14
  ret i32 %fail8
}

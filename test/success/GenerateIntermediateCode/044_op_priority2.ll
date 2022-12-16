declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B3:
  %fail7 = alloca i32, align 4
  %fail6 = alloca i32, align 4
  %fail5 = alloca i32, align 4
  %fail4 = alloca i32, align 4
  store i32 10, i32* %fail4, align 4
  store i32 4, i32* %fail5, align 4
  store i32 2, i32* %fail6, align 4
  store i32 2, i32* %fail7, align 4
  %fail10 = load i32, i32* %fail6, align 4
  %fail11 = load i32, i32* %fail4, align 4
  %fail9 = add i32 %fail10, %fail11
  %fail13 = load i32, i32* %fail5, align 4
  %fail14 = load i32, i32* %fail7, align 4
  %fail12 = sub i32 %fail13, %fail14
  %fail8 = mul i32 %fail9, %fail12
  ret i32 %fail8
}

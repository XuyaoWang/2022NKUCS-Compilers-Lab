declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@n = global i32 0, align 4
define i32 @main() {
B4:
  %fail9 = alloca i32, align 4
  %fail6 = alloca i32, align 4
  %fail5 = alloca i32, align 4
  %fail7 = call i32 @getint()
  store i32 %fail7, i32* %fail5, align 4
  %fail8 = call i32 @getint()
  store i32 %fail8, i32* %fail6, align 4
  %fail10 = load i32, i32* %fail5, align 4
  store i32 %fail10, i32* %fail9, align 4
  %fail11 = load i32, i32* %fail6, align 4
  store i32 %fail11, i32* %fail5, align 4
  %fail12 = load i32, i32* %fail9, align 4
  store i32 %fail12, i32* %fail6, align 4
  %fail13 = load i32, i32* %fail5, align 4
  call void @putint(i32 %fail13)
  store i32 10, i32* %fail9, align 4
  %fail14 = load i32, i32* %fail9, align 4
  call void @putch(i32 %fail14)
  %fail15 = load i32, i32* %fail6, align 4
  call void @putint(i32 %fail15)
  store i32 10, i32* %fail9, align 4
  %fail16 = load i32, i32* %fail9, align 4
  call void @putch(i32 %fail16)
  ret i32 0
}

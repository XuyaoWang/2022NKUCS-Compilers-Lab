declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @fun(i32 %fail7, i32 %fail9) {
B6:
  %fail11 = alloca i32, align 4
  %fail10 = alloca i32, align 4
  %fail8 = alloca i32, align 4
  store i32 %fail7, i32* %fail8, align 4
  store i32 %fail9, i32* %fail10, align 4
  br label %B12
B12:                               	; preds = %B6, %B13
  %fail16 = load i32, i32* %fail10, align 4
  %fail15 = icmp sgt i32 %fail16, 0
  br i1 %fail15, label %B13, label %B19
B13:                               	; preds = %B12
  %fail21 = load i32, i32* %fail8, align 4
  %fail22 = load i32, i32* %fail10, align 4
  %fail20 = srem i32 %fail21, %fail22
  store i32 %fail20, i32* %fail11, align 4
  %fail23 = load i32, i32* %fail10, align 4
  store i32 %fail23, i32* %fail8, align 4
  %fail24 = load i32, i32* %fail11, align 4
  store i32 %fail24, i32* %fail10, align 4
  br label %B12
B19:                               	; preds = %B12
  br label %B14
B14:                               	; preds = %B19
  %fail25 = load i32, i32* %fail8, align 4
  ret i32 %fail25
}
define i32 @main() {
B26:
  %fail29 = alloca i32, align 4
  %fail28 = alloca i32, align 4
  %fail27 = alloca i32, align 4
  %fail30 = call i32 @getint()
  store i32 %fail30, i32* %fail28, align 4
  %fail31 = call i32 @getint()
  store i32 %fail31, i32* %fail27, align 4
  %fail32 = load i32, i32* %fail28, align 4
  %fail33 = load i32, i32* %fail27, align 4
  %fail34 = call i32 @fun(i32 %fail32, i32 %fail33)
  store i32 %fail34, i32* %fail29, align 4
  %fail35 = load i32, i32* %fail29, align 4
  call void @putint(i32 %fail35)
  ret i32 0
}

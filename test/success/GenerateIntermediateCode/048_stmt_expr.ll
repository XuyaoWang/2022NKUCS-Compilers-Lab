declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@k = global i32 0, align 4
@n = global i32 10, align 4
define i32 @main() {
B8:
  %fail9 = alloca i32, align 4
  store i32 0, i32* %fail9, align 4
  store i32 1, i32* @k, align 4
  br label %B10
B10:                               	; preds = %B8, %B11
  %fail14 = load i32, i32* %fail9, align 4
  %fail16 = load i32, i32* @n, align 4
  %fail15 = sub i32 %fail16, 1
  %fail13 = icmp sle i32 %fail14, %fail15
  br i1 %fail13, label %B11, label %B19
B11:                               	; preds = %B10
  %fail21 = load i32, i32* %fail9, align 4
  %fail20 = add i32 %fail21, 1
  store i32 %fail20, i32* %fail9, align 4
  %fail23 = load i32, i32* @k, align 4
  %fail22 = add i32 %fail23, 1
  %fail25 = load i32, i32* @k, align 4
  %fail26 = load i32, i32* @k, align 4
  %fail24 = add i32 %fail25, %fail26
  store i32 %fail24, i32* @k, align 4
  br label %B10
B19:                               	; preds = %B10
  br label %B12
B12:                               	; preds = %B19
  %fail27 = load i32, i32* @k, align 4
  call void @putint(i32 %fail27)
  %fail28 = load i32, i32* @k, align 4
  ret i32 %fail28
}

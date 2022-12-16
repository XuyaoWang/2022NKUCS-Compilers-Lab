declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @if_if_Else() {
B7:
  %fail9 = alloca i32, align 4
  %fail8 = alloca i32, align 4
  store i32 5, i32* %fail8, align 4
  store i32 10, i32* %fail9, align 4
  %fail14 = load i32, i32* %fail8, align 4
  %fail13 = icmp eq i32 %fail14, 5
  br i1 %fail13, label %B10, label %B17
B10:                               	; preds = %B7
  %fail21 = load i32, i32* %fail9, align 4
  %fail20 = icmp eq i32 %fail21, 10
  br i1 %fail20, label %B18, label %B24
B17:                               	; preds = %B7
  br label %B11
B18:                               	; preds = %B10
  store i32 25, i32* %fail8, align 4
  br label %B19
B24:                               	; preds = %B10
  br label %B19
B11:                               	; preds = %B17
  %fail26 = load i32, i32* %fail8, align 4
  %fail25 = add i32 %fail26, 15
  store i32 %fail25, i32* %fail8, align 4
  br label %B12
B19:                               	; preds = %B18, %B24
  br label %B12
B12:                               	; preds = %B11, %B19
  %fail27 = load i32, i32* %fail8, align 4
  ret i32 %fail27
}
define i32 @main() {
B28:
  %fail29 = call i32 @if_if_Else()
  ret i32 %fail29
}

declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @if_ifElse_() {
B7:
  %fail9 = alloca i32, align 4
  %fail8 = alloca i32, align 4
  store i32 5, i32* %fail8, align 4
  store i32 10, i32* %fail9, align 4
  %fail13 = load i32, i32* %fail8, align 4
  %fail12 = icmp eq i32 %fail13, 5
  br i1 %fail12, label %B10, label %B16
B10:                               	; preds = %B7
  %fail21 = load i32, i32* %fail9, align 4
  %fail20 = icmp eq i32 %fail21, 10
  br i1 %fail20, label %B17, label %B24
B16:                               	; preds = %B7
  br label %B11
B17:                               	; preds = %B10
  store i32 25, i32* %fail8, align 4
  br label %B19
B24:                               	; preds = %B10
  br label %B18
B11:                               	; preds = %B16, %B19
  %fail27 = load i32, i32* %fail8, align 4
  ret i32 %fail27
B19:                               	; preds = %B17, %B18
  br label %B11
B18:                               	; preds = %B24
  %fail26 = load i32, i32* %fail8, align 4
  %fail25 = add i32 %fail26, 15
  store i32 %fail25, i32* %fail8, align 4
  br label %B19
}
define i32 @main() {
B28:
  %fail29 = call i32 @if_ifElse_()
  ret i32 %fail29
}

declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B6:
  %fail8 = alloca i32, align 4
  %fail7 = alloca i32, align 4
  store i32 0, i32* %fail8, align 4
  store i32 0, i32* %fail7, align 4
  br label %B9
B9:                               	; preds = %B6, %B10
  %fail13 = load i32, i32* %fail7, align 4
  %fail12 = icmp slt i32 %fail13, 21
  br i1 %fail12, label %B10, label %B16
B10:                               	; preds = %B9
  %fail18 = load i32, i32* %fail8, align 4
  %fail19 = load i32, i32* %fail7, align 4
  %fail17 = mul i32 %fail18, %fail19
  store i32 %fail17, i32* %fail8, align 4
  %fail21 = load i32, i32* %fail7, align 4
  %fail20 = add i32 %fail21, 1
  store i32 %fail20, i32* %fail7, align 4
  br label %B9
B16:                               	; preds = %B9
  br label %B11
B11:                               	; preds = %B16
  %fail22 = load i32, i32* %fail8, align 4
  call void @putint(i32 %fail22)
  ret i32 0
}

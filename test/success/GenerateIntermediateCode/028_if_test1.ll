declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @ifElse() {
B4:
  %fail5 = alloca i32, align 4
  store i32 5, i32* %fail5, align 4
  %fail10 = load i32, i32* %fail5, align 4
  %fail9 = icmp eq i32 %fail10, 5
  br i1 %fail9, label %B6, label %B13
B6:                               	; preds = %B4
  store i32 25, i32* %fail5, align 4
  br label %B8
B13:                               	; preds = %B4
  br label %B7
B8:                               	; preds = %B6, %B7
  %fail16 = load i32, i32* %fail5, align 4
  ret i32 %fail16
B7:                               	; preds = %B13
  %fail15 = load i32, i32* %fail5, align 4
  %fail14 = mul i32 %fail15, 2
  store i32 %fail14, i32* %fail5, align 4
  br label %B8
}
define i32 @main() {
B17:
  %fail18 = call i32 @ifElse()
  ret i32 %fail18
}

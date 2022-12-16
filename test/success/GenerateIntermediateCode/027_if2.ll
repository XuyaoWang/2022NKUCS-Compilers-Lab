declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i32 0, align 4
define i32 @main() {
B3:
  store i32 10, i32* @a, align 4
  %fail8 = load i32, i32* @a, align 4
  %fail7 = icmp sgt i32 %fail8, 0
  br i1 %fail7, label %B4, label %B11
B4:                               	; preds = %B3
  ret i32 1
  br label %B6
B11:                               	; preds = %B3
  br label %B5
B6:                               	; preds = %B4, %B5
  ret i32 0
B5:                               	; preds = %B11
  ret i32 0
  br label %B6
}

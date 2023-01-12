declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B5:
  %t9 = icmp slt i32 1, 8
  %t13 = srem i32 7, 2
  %t14 = zext i1 %t9 to i32
  %t8 = icmp ne i32 %t14, %t13
  br i1 %t8, label %B6, label %B17
B6:                               	; preds = %B5
  call void @putch(i32 67)
  br label %B7
B17:                               	; preds = %B5
  br label %B7
B7:                               	; preds = %B6, %B17
  ret i32 0
}

declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B7:
  %fail8 = alloca i32, align 4
  store i32 10, i32* %fail8, align 4
  %fail12 = load i32, i32* %fail8, align 4
  %fail13 = icmp ne i32 %fail12, 0
  %fail14 = xor i1 %fail13, true
  %fail15 = zext i1 %fail14 to i32
  %fail16 = icmp ne i32 %fail15, 0
  %fail17 = xor i1 %fail16, true
  %fail18 = zext i1 %fail17 to i32
  %fail19 = icmp ne i32 %fail18, 0
  %fail20 = xor i1 %fail19, true
  %fail21 = zext i1 %fail20 to i32
  %fail22 = sub i32 0, %fail21
  %fail23 = icmp ne i32 %fail22, 0
  br i1 %fail23, label %B9, label %B24
B9:                               	; preds = %B7
  %fail25 = sub i32 0, 1
  %fail26 = sub i32 0, %fail25
  %fail27 = sub i32 0, %fail26
  store i32 %fail27, i32* %fail8, align 4
  br label %B11
B24:                               	; preds = %B7
  br label %B10
B11:                               	; preds = %B9, %B10
  %fail28 = load i32, i32* %fail8, align 4
  ret i32 %fail28
B10:                               	; preds = %B24
  store i32 0, i32* %fail8, align 4
  br label %B11
}

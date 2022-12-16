declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i32 0, align 4
@b = global i32 0, align 4
define i32 @main() {
B7:
  %fail10 = alloca i32, align 4
  %fail8 = call i32 @getint()
  store i32 %fail8, i32* @a, align 4
  %fail9 = call i32 @getint()
  store i32 %fail9, i32* @b, align 4
  %fail17 = load i32, i32* @a, align 4
  %fail18 = load i32, i32* @b, align 4
  %fail16 = icmp eq i32 %fail17, %fail18
  br i1 %fail16, label %B15, label %B21
B15:                               	; preds = %B7
  %fail23 = load i32, i32* @a, align 4
  %fail22 = icmp ne i32 %fail23, 3
  br i1 %fail22, label %B11, label %B26
B21:                               	; preds = %B7
  br label %B12
B11:                               	; preds = %B15
  store i32 1, i32* %fail10, align 4
  br label %B13
B26:                               	; preds = %B15
  br label %B12
B12:                               	; preds = %B21, %B26
  store i32 0, i32* %fail10, align 4
  br label %B13
B13:                               	; preds = %B11, %B12
  %fail27 = load i32, i32* %fail10, align 4
  ret i32 %fail27
}

declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @whileIf() {
B11:
  %fail13 = alloca i32, align 4
  %fail12 = alloca i32, align 4
  store i32 0, i32* %fail12, align 4
  store i32 0, i32* %fail13, align 4
  br label %B14
B14:                               	; preds = %B11, %B24
  %fail18 = load i32, i32* %fail12, align 4
  %fail17 = icmp slt i32 %fail18, 100
  br i1 %fail17, label %B15, label %B21
B15:                               	; preds = %B14
  %fail26 = load i32, i32* %fail12, align 4
  %fail25 = icmp eq i32 %fail26, 5
  br i1 %fail25, label %B22, label %B29
B21:                               	; preds = %B14
  br label %B16
B22:                               	; preds = %B15
  store i32 25, i32* %fail13, align 4
  br label %B24
B29:                               	; preds = %B15
  br label %B23
B16:                               	; preds = %B21
  %fail42 = load i32, i32* %fail13, align 4
  ret i32 %fail42
B24:                               	; preds = %B22, %B32
  %fail41 = load i32, i32* %fail12, align 4
  %fail40 = add i32 %fail41, 1
  store i32 %fail40, i32* %fail12, align 4
  br label %B14
B23:                               	; preds = %B29
  %fail34 = load i32, i32* %fail12, align 4
  %fail33 = icmp eq i32 %fail34, 10
  br i1 %fail33, label %B30, label %B37
B30:                               	; preds = %B23
  store i32 42, i32* %fail13, align 4
  br label %B32
B37:                               	; preds = %B23
  br label %B31
B32:                               	; preds = %B30, %B31
  br label %B24
B31:                               	; preds = %B37
  %fail39 = load i32, i32* %fail12, align 4
  %fail38 = mul i32 %fail39, 2
  store i32 %fail38, i32* %fail13, align 4
  br label %B32
}
define i32 @main() {
B43:
  %fail44 = call i32 @whileIf()
  ret i32 %fail44
}

declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B23:
  %fail27 = alloca i32, align 4
  %fail26 = alloca i32, align 4
  %fail25 = alloca i32, align 4
  %fail24 = alloca i32, align 4
  store i32 0, i32* %fail24, align 4
  store i32 0, i32* %fail25, align 4
  store i32 0, i32* %fail26, align 4
  br label %B28
B28:                               	; preds = %B23, %B38
  %fail32 = load i32, i32* %fail24, align 4
  %fail31 = icmp slt i32 %fail32, 21
  br i1 %fail31, label %B29, label %B35
B29:                               	; preds = %B28
  br label %B36
B35:                               	; preds = %B28
  br label %B30
B36:                               	; preds = %B29, %B51
  %fail40 = load i32, i32* %fail25, align 4
  %fail42 = load i32, i32* %fail24, align 4
  %fail41 = sub i32 101, %fail42
  %fail39 = icmp slt i32 %fail40, %fail41
  br i1 %fail39, label %B37, label %B45
B30:                               	; preds = %B35
  ret i32 0
B37:                               	; preds = %B36
  %fail48 = load i32, i32* %fail24, align 4
  %fail47 = sub i32 100, %fail48
  %fail49 = load i32, i32* %fail25, align 4
  %fail46 = sub i32 %fail47, %fail49
  store i32 %fail46, i32* %fail26, align 4
  %fail56 = load i32, i32* %fail24, align 4
  %fail55 = mul i32 5, %fail56
  %fail58 = load i32, i32* %fail25, align 4
  %fail57 = mul i32 1, %fail58
  %fail54 = add i32 %fail55, %fail57
  %fail60 = load i32, i32* %fail26, align 4
  %fail59 = sdiv i32 %fail60, 2
  %fail53 = add i32 %fail54, %fail59
  %fail52 = icmp eq i32 %fail53, 100
  br i1 %fail52, label %B50, label %B63
B45:                               	; preds = %B36
  br label %B38
B50:                               	; preds = %B37
  %fail64 = load i32, i32* %fail24, align 4
  call void @putint(i32 %fail64)
  %fail65 = load i32, i32* %fail25, align 4
  call void @putint(i32 %fail65)
  %fail66 = load i32, i32* %fail26, align 4
  call void @putint(i32 %fail66)
  store i32 10, i32* %fail27, align 4
  %fail67 = load i32, i32* %fail27, align 4
  call void @putch(i32 %fail67)
  br label %B51
B63:                               	; preds = %B37
  br label %B51
B38:                               	; preds = %B45
  %fail71 = load i32, i32* %fail24, align 4
  %fail70 = add i32 %fail71, 1
  store i32 %fail70, i32* %fail24, align 4
  br label %B28
B51:                               	; preds = %B50, %B63
  %fail69 = load i32, i32* %fail25, align 4
  %fail68 = add i32 %fail69, 1
  store i32 %fail68, i32* %fail25, align 4
  br label %B36
}

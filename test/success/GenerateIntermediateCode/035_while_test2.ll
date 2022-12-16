declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @FourWhile() {
B22:
  %fail26 = alloca i32, align 4
  %fail25 = alloca i32, align 4
  %fail24 = alloca i32, align 4
  %fail23 = alloca i32, align 4
  store i32 5, i32* %fail23, align 4
  store i32 6, i32* %fail24, align 4
  store i32 7, i32* %fail25, align 4
  store i32 10, i32* %fail26, align 4
  br label %B27
B27:                               	; preds = %B22, %B39
  %fail31 = load i32, i32* %fail23, align 4
  %fail30 = icmp slt i32 %fail31, 20
  br i1 %fail30, label %B28, label %B34
B28:                               	; preds = %B27
  %fail36 = load i32, i32* %fail23, align 4
  %fail35 = add i32 %fail36, 3
  store i32 %fail35, i32* %fail23, align 4
  br label %B37
B34:                               	; preds = %B27
  br label %B29
B37:                               	; preds = %B28, %B49
  %fail41 = load i32, i32* %fail24, align 4
  %fail40 = icmp slt i32 %fail41, 10
  br i1 %fail40, label %B38, label %B44
B29:                               	; preds = %B34
  %fail75 = load i32, i32* %fail23, align 4
  %fail77 = load i32, i32* %fail24, align 4
  %fail78 = load i32, i32* %fail26, align 4
  %fail76 = add i32 %fail77, %fail78
  %fail74 = add i32 %fail75, %fail76
  %fail79 = load i32, i32* %fail25, align 4
  %fail73 = add i32 %fail74, %fail79
  ret i32 %fail73
B38:                               	; preds = %B37
  %fail46 = load i32, i32* %fail24, align 4
  %fail45 = add i32 %fail46, 1
  store i32 %fail45, i32* %fail24, align 4
  br label %B47
B44:                               	; preds = %B37
  br label %B39
B47:                               	; preds = %B38, %B59
  %fail51 = load i32, i32* %fail25, align 4
  %fail50 = icmp eq i32 %fail51, 7
  br i1 %fail50, label %B48, label %B54
B39:                               	; preds = %B44
  %fail72 = load i32, i32* %fail24, align 4
  %fail71 = sub i32 %fail72, 2
  store i32 %fail71, i32* %fail24, align 4
  br label %B27
B48:                               	; preds = %B47
  %fail56 = load i32, i32* %fail25, align 4
  %fail55 = sub i32 %fail56, 1
  store i32 %fail55, i32* %fail25, align 4
  br label %B57
B54:                               	; preds = %B47
  br label %B49
B57:                               	; preds = %B48, %B58
  %fail61 = load i32, i32* %fail26, align 4
  %fail60 = icmp slt i32 %fail61, 20
  br i1 %fail60, label %B58, label %B64
B49:                               	; preds = %B54
  %fail70 = load i32, i32* %fail25, align 4
  %fail69 = add i32 %fail70, 1
  store i32 %fail69, i32* %fail25, align 4
  br label %B37
B58:                               	; preds = %B57
  %fail66 = load i32, i32* %fail26, align 4
  %fail65 = add i32 %fail66, 3
  store i32 %fail65, i32* %fail26, align 4
  br label %B57
B64:                               	; preds = %B57
  br label %B59
B59:                               	; preds = %B64
  %fail68 = load i32, i32* %fail26, align 4
  %fail67 = sub i32 %fail68, 1
  store i32 %fail67, i32* %fail26, align 4
  br label %B47
}
define i32 @main() {
B80:
  %fail81 = call i32 @FourWhile()
  ret i32 %fail81
}

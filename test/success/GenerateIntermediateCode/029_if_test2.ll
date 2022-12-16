declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @ifElseIf() {
B25:
  %fail27 = alloca i32, align 4
  %fail26 = alloca i32, align 4
  store i32 5, i32* %fail26, align 4
  store i32 10, i32* %fail27, align 4
  %fail34 = load i32, i32* %fail26, align 4
  %fail33 = icmp eq i32 %fail34, 6
  br i1 %fail33, label %B28, label %B37
B28:                               	; preds = %B25, %B32
  %fail43 = load i32, i32* %fail26, align 4
  ret i32 %fail43
  br label %B30
B37:                               	; preds = %B25
  br label %B32
B30:                               	; preds = %B28, %B46
  %fail79 = load i32, i32* %fail26, align 4
  ret i32 %fail79
B32:                               	; preds = %B37
  %fail39 = load i32, i32* %fail27, align 4
  %fail38 = icmp eq i32 %fail39, 11
  br i1 %fail38, label %B28, label %B42
B42:                               	; preds = %B32
  br label %B29
B29:                               	; preds = %B42
  %fail50 = load i32, i32* %fail27, align 4
  %fail49 = icmp eq i32 %fail50, 10
  br i1 %fail49, label %B48, label %B53
B48:                               	; preds = %B29
  %fail55 = load i32, i32* %fail26, align 4
  %fail54 = icmp eq i32 %fail55, 1
  br i1 %fail54, label %B44, label %B58
B53:                               	; preds = %B29
  br label %B45
B44:                               	; preds = %B48
  store i32 25, i32* %fail26, align 4
  br label %B46
B58:                               	; preds = %B48
  br label %B45
B45:                               	; preds = %B53, %B58
  %fail65 = load i32, i32* %fail27, align 4
  %fail64 = icmp eq i32 %fail65, 10
  br i1 %fail64, label %B63, label %B68
B46:                               	; preds = %B44, %B61
  br label %B30
B63:                               	; preds = %B45
  %fail70 = load i32, i32* %fail26, align 4
  %fail71 = sub i32 0, 5
  %fail69 = icmp eq i32 %fail70, %fail71
  br i1 %fail69, label %B59, label %B74
B68:                               	; preds = %B45
  br label %B60
B59:                               	; preds = %B63
  %fail76 = load i32, i32* %fail26, align 4
  %fail75 = add i32 %fail76, 15
  store i32 %fail75, i32* %fail26, align 4
  br label %B61
B74:                               	; preds = %B63
  br label %B60
B60:                               	; preds = %B68, %B74
  %fail77 = load i32, i32* %fail26, align 4
  %fail78 = sub i32 0, %fail77
  store i32 %fail78, i32* %fail26, align 4
  br label %B61
B61:                               	; preds = %B59, %B60
  br label %B46
}
define i32 @main() {
B80:
  %fail81 = call i32 @ifElseIf()
  call void @putint(i32 %fail81)
  ret i32 0
}

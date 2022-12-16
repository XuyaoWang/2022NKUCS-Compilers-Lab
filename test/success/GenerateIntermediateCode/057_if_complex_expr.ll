declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B35:
  %fail40 = alloca i32, align 4
  %fail39 = alloca i32, align 4
  %fail38 = alloca i32, align 4
  %fail37 = alloca i32, align 4
  %fail36 = alloca i32, align 4
  store i32 5, i32* %fail36, align 4
  store i32 5, i32* %fail37, align 4
  store i32 1, i32* %fail38, align 4
  %fail41 = sub i32 0, 2
  store i32 %fail41, i32* %fail39, align 4
  store i32 2, i32* %fail40, align 4
  %fail49 = load i32, i32* %fail39, align 4
  %fail48 = mul i32 %fail49, 1
  %fail47 = sdiv i32 %fail48, 2
  %fail46 = icmp slt i32 %fail47, 0
  br i1 %fail46, label %B42, label %B52
B42:                               	; preds = %B35, %B54
  %fail69 = load i32, i32* %fail40, align 4
  call void @putint(i32 %fail69)
  br label %B43
B52:                               	; preds = %B35
  br label %B45
B43:                               	; preds = %B42, %B61, %B68
  %fail77 = load i32, i32* %fail39, align 4
  %fail76 = srem i32 %fail77, 2
  %fail75 = add i32 %fail76, 67
  %fail74 = icmp slt i32 %fail75, 0
  br i1 %fail74, label %B70, label %B80
B45:                               	; preds = %B52
  %fail57 = load i32, i32* %fail36, align 4
  %fail58 = load i32, i32* %fail37, align 4
  %fail56 = sub i32 %fail57, %fail58
  %fail55 = icmp ne i32 %fail56, 0
  br i1 %fail55, label %B54, label %B61
B70:                               	; preds = %B43, %B82
  store i32 4, i32* %fail40, align 4
  %fail97 = load i32, i32* %fail40, align 4
  call void @putint(i32 %fail97)
  br label %B71
B80:                               	; preds = %B43
  br label %B73
B54:                               	; preds = %B45
  %fail65 = load i32, i32* %fail38, align 4
  %fail64 = add i32 %fail65, 3
  %fail63 = srem i32 %fail64, 2
  %fail62 = icmp ne i32 %fail63, 0
  br i1 %fail62, label %B42, label %B68
B61:                               	; preds = %B45
  br label %B43
B71:                               	; preds = %B70, %B89, %B96
  ret i32 0
B73:                               	; preds = %B80
  %fail85 = load i32, i32* %fail36, align 4
  %fail86 = load i32, i32* %fail37, align 4
  %fail84 = sub i32 %fail85, %fail86
  %fail83 = icmp ne i32 %fail84, 0
  br i1 %fail83, label %B82, label %B89
B68:                               	; preds = %B54
  br label %B43
B82:                               	; preds = %B73
  %fail93 = load i32, i32* %fail38, align 4
  %fail92 = add i32 %fail93, 2
  %fail91 = srem i32 %fail92, 2
  %fail90 = icmp ne i32 %fail91, 0
  br i1 %fail90, label %B70, label %B96
B89:                               	; preds = %B73
  br label %B71
B96:                               	; preds = %B82
  br label %B71
}

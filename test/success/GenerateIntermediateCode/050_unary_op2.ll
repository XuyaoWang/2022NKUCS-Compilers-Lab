declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B12:
  %fail14 = alloca i32, align 4
  %fail13 = alloca i32, align 4
  store i32 56, i32* %fail13, align 4
  store i32 4, i32* %fail14, align 4
  %fail17 = load i32, i32* %fail13, align 4
  %fail18 = sub i32 0, 4
  %fail16 = sub i32 %fail17, %fail18
  %fail19 = load i32, i32* %fail14, align 4
  %fail15 = add i32 %fail16, %fail19
  store i32 %fail15, i32* %fail13, align 4
  %fail23 = load i32, i32* %fail13, align 4
  %fail24 = icmp ne i32 %fail23, 0
  %fail25 = xor i1 %fail24, true
  %fail26 = zext i1 %fail25 to i32
  %fail27 = icmp ne i32 %fail26, 0
  %fail28 = xor i1 %fail27, true
  %fail29 = zext i1 %fail28 to i32
  %fail30 = icmp ne i32 %fail29, 0
  %fail31 = xor i1 %fail30, true
  %fail32 = zext i1 %fail31 to i32
  %fail33 = sub i32 0, %fail32
  %fail34 = icmp ne i32 %fail33, 0
  br i1 %fail34, label %B20, label %B35
B20:                               	; preds = %B12
  %fail36 = sub i32 0, 1
  %fail37 = sub i32 0, %fail36
  %fail38 = sub i32 0, %fail37
  store i32 %fail38, i32* %fail13, align 4
  br label %B22
B35:                               	; preds = %B12
  br label %B21
B22:                               	; preds = %B20, %B21
  %fail41 = load i32, i32* %fail13, align 4
  call void @putint(i32 %fail41)
  ret i32 0
B21:                               	; preds = %B35
  %fail40 = load i32, i32* %fail14, align 4
  %fail39 = add i32 0, %fail40
  store i32 %fail39, i32* %fail13, align 4
  br label %B22
}

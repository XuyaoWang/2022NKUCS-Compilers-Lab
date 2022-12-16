declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @fsqrt(i32 %fail12) {
B11:
  %fail15 = alloca i32, align 4
  %fail14 = alloca i32, align 4
  %fail13 = alloca i32, align 4
  store i32 %fail12, i32* %fail13, align 4
  store i32 0, i32* %fail14, align 4
  %fail17 = load i32, i32* %fail13, align 4
  %fail16 = sdiv i32 %fail17, 2
  store i32 %fail16, i32* %fail15, align 4
  br label %B18
B18:                               	; preds = %B11, %B19
  %fail23 = load i32, i32* %fail14, align 4
  %fail24 = load i32, i32* %fail15, align 4
  %fail22 = sub i32 %fail23, %fail24
  %fail21 = icmp ne i32 %fail22, 0
  br i1 %fail21, label %B19, label %B27
B19:                               	; preds = %B18
  %fail28 = load i32, i32* %fail15, align 4
  store i32 %fail28, i32* %fail14, align 4
  %fail30 = load i32, i32* %fail14, align 4
  %fail32 = load i32, i32* %fail13, align 4
  %fail33 = load i32, i32* %fail14, align 4
  %fail31 = sdiv i32 %fail32, %fail33
  %fail29 = add i32 %fail30, %fail31
  store i32 %fail29, i32* %fail15, align 4
  %fail35 = load i32, i32* %fail15, align 4
  %fail34 = sdiv i32 %fail35, 2
  store i32 %fail34, i32* %fail15, align 4
  br label %B18
B27:                               	; preds = %B18
  br label %B20
B20:                               	; preds = %B27
  %fail36 = load i32, i32* %fail15, align 4
  ret i32 %fail36
}
define i32 @main() {
B37:
  %fail39 = alloca i32, align 4
  %fail38 = alloca i32, align 4
  store i32 400, i32* %fail38, align 4
  %fail40 = load i32, i32* %fail38, align 4
  %fail41 = call i32 @fsqrt(i32 %fail40)
  store i32 %fail41, i32* %fail39, align 4
  %fail42 = load i32, i32* %fail39, align 4
  call void @putint(i32 %fail42)
  store i32 10, i32* %fail39, align 4
  %fail43 = load i32, i32* %fail39, align 4
  call void @putch(i32 %fail43)
  ret i32 0
}

declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @dec2bin(i32 %fail12) {
B11:
  %fail17 = alloca i32, align 4
  %fail16 = alloca i32, align 4
  %fail15 = alloca i32, align 4
  %fail14 = alloca i32, align 4
  %fail13 = alloca i32, align 4
  store i32 %fail12, i32* %fail13, align 4
  store i32 0, i32* %fail14, align 4
  store i32 1, i32* %fail15, align 4
  %fail18 = load i32, i32* %fail13, align 4
  store i32 %fail18, i32* %fail17, align 4
  br label %B19
B19:                               	; preds = %B11, %B20
  %fail23 = load i32, i32* %fail17, align 4
  %fail22 = icmp ne i32 %fail23, 0
  br i1 %fail22, label %B20, label %B26
B20:                               	; preds = %B19
  %fail28 = load i32, i32* %fail17, align 4
  %fail27 = srem i32 %fail28, 2
  store i32 %fail27, i32* %fail16, align 4
  %fail31 = load i32, i32* %fail15, align 4
  %fail32 = load i32, i32* %fail16, align 4
  %fail30 = mul i32 %fail31, %fail32
  %fail33 = load i32, i32* %fail14, align 4
  %fail29 = add i32 %fail30, %fail33
  store i32 %fail29, i32* %fail14, align 4
  %fail35 = load i32, i32* %fail15, align 4
  %fail34 = mul i32 %fail35, 10
  store i32 %fail34, i32* %fail15, align 4
  %fail37 = load i32, i32* %fail17, align 4
  %fail36 = sdiv i32 %fail37, 2
  store i32 %fail36, i32* %fail17, align 4
  br label %B19
B26:                               	; preds = %B19
  br label %B21
B21:                               	; preds = %B26
  %fail38 = load i32, i32* %fail14, align 4
  ret i32 %fail38
}
define i32 @main() {
B39:
  %fail41 = alloca i32, align 4
  %fail40 = alloca i32, align 4
  store i32 400, i32* %fail40, align 4
  %fail42 = load i32, i32* %fail40, align 4
  %fail43 = call i32 @dec2bin(i32 %fail42)
  store i32 %fail43, i32* %fail41, align 4
  %fail44 = load i32, i32* %fail41, align 4
  call void @putint(i32 %fail44)
  store i32 10, i32* %fail41, align 4
  %fail45 = load i32, i32* %fail41, align 4
  call void @putch(i32 %fail45)
  ret i32 0
}

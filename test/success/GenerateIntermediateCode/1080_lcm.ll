declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@n = global i32 0, align 4
define i32 @gcd(i32 %fail12, i32 %fail14) {
B11:
  %fail21 = alloca i32, align 4
  %fail20 = alloca i32, align 4
  %fail17 = alloca i32, align 4
  %fail16 = alloca i32, align 4
  %fail15 = alloca i32, align 4
  %fail13 = alloca i32, align 4
  store i32 %fail12, i32* %fail13, align 4
  store i32 %fail14, i32* %fail15, align 4
  %fail18 = load i32, i32* %fail13, align 4
  store i32 %fail18, i32* %fail16, align 4
  %fail19 = load i32, i32* %fail15, align 4
  store i32 %fail19, i32* %fail17, align 4
  %fail25 = load i32, i32* %fail13, align 4
  %fail26 = load i32, i32* %fail15, align 4
  %fail24 = icmp slt i32 %fail25, %fail26
  br i1 %fail24, label %B22, label %B29
B22:                               	; preds = %B11
  %fail30 = load i32, i32* %fail13, align 4
  store i32 %fail30, i32* %fail20, align 4
  %fail31 = load i32, i32* %fail15, align 4
  store i32 %fail31, i32* %fail13, align 4
  %fail32 = load i32, i32* %fail20, align 4
  store i32 %fail32, i32* %fail15, align 4
  br label %B23
B29:                               	; preds = %B11
  br label %B23
B23:                               	; preds = %B22, %B29
  %fail34 = load i32, i32* %fail13, align 4
  %fail35 = load i32, i32* %fail15, align 4
  %fail33 = srem i32 %fail34, %fail35
  store i32 %fail33, i32* %fail21, align 4
  br label %B36
B36:                               	; preds = %B23, %B37
  %fail40 = load i32, i32* %fail21, align 4
  %fail39 = icmp ne i32 %fail40, 0
  br i1 %fail39, label %B37, label %B43
B37:                               	; preds = %B36
  %fail44 = load i32, i32* %fail15, align 4
  store i32 %fail44, i32* %fail13, align 4
  %fail45 = load i32, i32* %fail21, align 4
  store i32 %fail45, i32* %fail15, align 4
  %fail47 = load i32, i32* %fail13, align 4
  %fail48 = load i32, i32* %fail15, align 4
  %fail46 = srem i32 %fail47, %fail48
  store i32 %fail46, i32* %fail21, align 4
  br label %B36
B43:                               	; preds = %B36
  br label %B38
B38:                               	; preds = %B43
  %fail51 = load i32, i32* %fail16, align 4
  %fail52 = load i32, i32* %fail17, align 4
  %fail50 = mul i32 %fail51, %fail52
  %fail53 = load i32, i32* %fail15, align 4
  %fail49 = sdiv i32 %fail50, %fail53
  ret i32 %fail49
}
define i32 @main() {
B54:
  %fail56 = alloca i32, align 4
  %fail55 = alloca i32, align 4
  %fail57 = call i32 @getint()
  store i32 %fail57, i32* %fail55, align 4
  %fail58 = call i32 @getint()
  store i32 %fail58, i32* %fail56, align 4
  %fail59 = load i32, i32* %fail55, align 4
  %fail60 = load i32, i32* %fail56, align 4
  %fail61 = call i32 @gcd(i32 %fail59, i32 %fail60)
  ret i32 %fail61
}

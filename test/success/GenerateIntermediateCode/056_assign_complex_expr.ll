declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @main() {
B21:
  %fail26 = alloca i32, align 4
  %fail25 = alloca i32, align 4
  %fail24 = alloca i32, align 4
  %fail23 = alloca i32, align 4
  %fail22 = alloca i32, align 4
  store i32 5, i32* %fail22, align 4
  store i32 5, i32* %fail23, align 4
  store i32 1, i32* %fail24, align 4
  %fail27 = sub i32 0, 2
  store i32 %fail27, i32* %fail25, align 4
  %fail32 = load i32, i32* %fail25, align 4
  %fail31 = mul i32 %fail32, 1
  %fail30 = sdiv i32 %fail31, 2
  %fail34 = load i32, i32* %fail22, align 4
  %fail35 = load i32, i32* %fail23, align 4
  %fail33 = sub i32 %fail34, %fail35
  %fail29 = add i32 %fail30, %fail33
  %fail38 = load i32, i32* %fail24, align 4
  %fail37 = add i32 %fail38, 3
  %fail39 = sub i32 0, %fail37
  %fail36 = srem i32 %fail39, 2
  %fail28 = sub i32 %fail29, %fail36
  store i32 %fail28, i32* %fail26, align 4
  %fail40 = load i32, i32* %fail26, align 4
  call void @putint(i32 %fail40)
  %fail45 = load i32, i32* %fail25, align 4
  %fail44 = srem i32 %fail45, 2
  %fail43 = add i32 %fail44, 67
  %fail47 = load i32, i32* %fail22, align 4
  %fail48 = load i32, i32* %fail23, align 4
  %fail46 = sub i32 %fail47, %fail48
  %fail49 = sub i32 0, %fail46
  %fail42 = add i32 %fail43, %fail49
  %fail52 = load i32, i32* %fail24, align 4
  %fail51 = add i32 %fail52, 2
  %fail50 = srem i32 %fail51, 2
  %fail53 = sub i32 0, %fail50
  %fail41 = sub i32 %fail42, %fail53
  store i32 %fail41, i32* %fail26, align 4
  %fail55 = load i32, i32* %fail26, align 4
  %fail54 = add i32 %fail55, 3
  store i32 %fail54, i32* %fail26, align 4
  %fail56 = load i32, i32* %fail26, align 4
  call void @putint(i32 %fail56)
  ret i32 0
}

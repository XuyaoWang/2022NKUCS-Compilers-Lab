declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@N = global i32 0, align 4
@newline = global i32 0, align 4
define i32 @factor(i32 %fail12) {
B11:
  %fail15 = alloca i32, align 4
  %fail14 = alloca i32, align 4
  %fail13 = alloca i32, align 4
  store i32 %fail12, i32* %fail13, align 4
  store i32 0, i32* %fail15, align 4
  store i32 1, i32* %fail14, align 4
  br label %B16
B16:                               	; preds = %B11, %B27
  %fail20 = load i32, i32* %fail14, align 4
  %fail22 = load i32, i32* %fail13, align 4
  %fail21 = add i32 %fail22, 1
  %fail19 = icmp slt i32 %fail20, %fail21
  br i1 %fail19, label %B17, label %B25
B17:                               	; preds = %B16
  %fail30 = load i32, i32* %fail13, align 4
  %fail31 = load i32, i32* %fail14, align 4
  %fail29 = srem i32 %fail30, %fail31
  %fail28 = icmp eq i32 %fail29, 0
  br i1 %fail28, label %B26, label %B34
B25:                               	; preds = %B16
  br label %B18
B26:                               	; preds = %B17
  %fail36 = load i32, i32* %fail15, align 4
  %fail37 = load i32, i32* %fail14, align 4
  %fail35 = add i32 %fail36, %fail37
  store i32 %fail35, i32* %fail15, align 4
  br label %B27
B34:                               	; preds = %B17
  br label %B27
B18:                               	; preds = %B25
  %fail40 = load i32, i32* %fail15, align 4
  ret i32 %fail40
B27:                               	; preds = %B26, %B34
  %fail39 = load i32, i32* %fail14, align 4
  %fail38 = add i32 %fail39, 1
  store i32 %fail38, i32* %fail14, align 4
  br label %B16
}
define i32 @main() {
B41:
  %fail44 = alloca i32, align 4
  %fail43 = alloca i32, align 4
  %fail42 = alloca i32, align 4
  store i32 4, i32* @N, align 4
  store i32 10, i32* @newline, align 4
  store i32 1478, i32* %fail43, align 4
  %fail45 = load i32, i32* %fail43, align 4
  %fail46 = call i32 @factor(i32 %fail45)
  ret i32 %fail46
}

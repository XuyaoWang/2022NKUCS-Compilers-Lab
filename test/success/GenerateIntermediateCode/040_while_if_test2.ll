declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @ifWhile() {
B13:
  %fail15 = alloca i32, align 4
  %fail14 = alloca i32, align 4
  store i32 0, i32* %fail14, align 4
  store i32 3, i32* %fail15, align 4
  %fail20 = load i32, i32* %fail14, align 4
  %fail19 = icmp eq i32 %fail20, 5
  br i1 %fail19, label %B16, label %B23
B16:                               	; preds = %B13
  br label %B24
B23:                               	; preds = %B13
  br label %B17
B24:                               	; preds = %B16, %B25
  %fail28 = load i32, i32* %fail15, align 4
  %fail27 = icmp eq i32 %fail28, 2
  br i1 %fail27, label %B25, label %B31
B17:                               	; preds = %B23
  br label %B36
B25:                               	; preds = %B24
  %fail33 = load i32, i32* %fail15, align 4
  %fail32 = add i32 %fail33, 2
  store i32 %fail32, i32* %fail15, align 4
  br label %B24
B31:                               	; preds = %B24
  br label %B26
B36:                               	; preds = %B17, %B37
  %fail40 = load i32, i32* %fail14, align 4
  %fail39 = icmp slt i32 %fail40, 5
  br i1 %fail39, label %B37, label %B43
B26:                               	; preds = %B31
  %fail35 = load i32, i32* %fail15, align 4
  %fail34 = add i32 %fail35, 25
  store i32 %fail34, i32* %fail15, align 4
  br label %B18
B37:                               	; preds = %B36
  %fail45 = load i32, i32* %fail15, align 4
  %fail44 = mul i32 %fail45, 2
  store i32 %fail44, i32* %fail15, align 4
  %fail47 = load i32, i32* %fail14, align 4
  %fail46 = add i32 %fail47, 1
  store i32 %fail46, i32* %fail14, align 4
  br label %B36
B43:                               	; preds = %B36
  br label %B38
B18:                               	; preds = %B26, %B38
  %fail48 = load i32, i32* %fail15, align 4
  ret i32 %fail48
B38:                               	; preds = %B43
  br label %B18
}
define i32 @main() {
B49:
  %fail50 = call i32 @ifWhile()
  ret i32 %fail50
}

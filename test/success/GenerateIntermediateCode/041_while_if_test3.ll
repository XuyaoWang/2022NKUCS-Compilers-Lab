declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @deepWhileBr(i32 %fail18, i32 %fail20) {
B17:
  %fail52 = alloca i32, align 4
  %fail34 = alloca i32, align 4
  %fail22 = alloca i32, align 4
  %fail21 = alloca i32, align 4
  %fail19 = alloca i32, align 4
  store i32 %fail18, i32* %fail19, align 4
  store i32 %fail20, i32* %fail21, align 4
  %fail24 = load i32, i32* %fail19, align 4
  %fail25 = load i32, i32* %fail21, align 4
  %fail23 = add i32 %fail24, %fail25
  store i32 %fail23, i32* %fail22, align 4
  br label %B26
B26:                               	; preds = %B17, %B36
  %fail30 = load i32, i32* %fail22, align 4
  %fail29 = icmp slt i32 %fail30, 75
  br i1 %fail29, label %B27, label %B33
B27:                               	; preds = %B26
  store i32 42, i32* %fail34, align 4
  %fail38 = load i32, i32* %fail22, align 4
  %fail37 = icmp slt i32 %fail38, 100
  br i1 %fail37, label %B35, label %B41
B33:                               	; preds = %B26
  br label %B28
B35:                               	; preds = %B27
  %fail43 = load i32, i32* %fail22, align 4
  %fail44 = load i32, i32* %fail34, align 4
  %fail42 = add i32 %fail43, %fail44
  store i32 %fail42, i32* %fail22, align 4
  %fail48 = load i32, i32* %fail22, align 4
  %fail47 = icmp sgt i32 %fail48, 99
  br i1 %fail47, label %B45, label %B51
B41:                               	; preds = %B27
  br label %B36
B28:                               	; preds = %B33
  %fail63 = load i32, i32* %fail22, align 4
  ret i32 %fail63
B45:                               	; preds = %B35
  %fail54 = load i32, i32* %fail34, align 4
  %fail53 = mul i32 %fail54, 2
  store i32 %fail53, i32* %fail52, align 4
  %fail57 = icmp eq i32 1, 1
  br i1 %fail57, label %B55, label %B60
B51:                               	; preds = %B35
  br label %B46
B36:                               	; preds = %B41, %B46
  br label %B26
B55:                               	; preds = %B45
  %fail62 = load i32, i32* %fail52, align 4
  %fail61 = mul i32 %fail62, 2
  store i32 %fail61, i32* %fail22, align 4
  br label %B56
B60:                               	; preds = %B45
  br label %B56
B46:                               	; preds = %B51, %B56
  br label %B36
B56:                               	; preds = %B55, %B60
  br label %B46
}
define i32 @main() {
B64:
  %fail65 = alloca i32, align 4
  store i32 2, i32* %fail65, align 4
  %fail66 = load i32, i32* %fail65, align 4
  %fail67 = load i32, i32* %fail65, align 4
  %fail68 = call i32 @deepWhileBr(i32 %fail66, i32 %fail67)
  ret i32 %fail68
}

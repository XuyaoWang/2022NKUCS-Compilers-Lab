declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i0 @deepWhileBr(i0 @a, i0 @b) {
B9:
  %t44 = alloca i0, align 4
  %t26 = alloca i0, align 4
  %t14 = alloca i0, align 4
  %t13 = alloca i0, align 4
  %t11 = alloca i0, align 4
  store i0 %t10, i0* %t11, align 4
  store i0 %t12, i0* %t13, align 4
  %t16 = load i0, i0* %t11, align 4
  %t17 = load i0, i0* %t13, align 4
  %t15 = add i0 %t16, %t17
  store i0 %t15, i0* %t14, align 4
  br label %B18
B18:                               	; preds = %B9, %B28
  %t22 = load i0, i0* %t14, align 4
  %t21 = icmp slt i0 %t22, 75
  br i0 %t21, label %B19, label %B25
B19:                               	; preds = %B18
  store i0 42, i0* %t26, align 4
  %t30 = load i0, i0* %t14, align 4
  %t29 = icmp slt i0 %t30, 100
  br i0 %t29, label %B27, label %B33
B25:                               	; preds = %B18
  br label %B20
B27:                               	; preds = %B19
  %t35 = load i0, i0* %t14, align 4
  %t36 = load i0, i0* %t26, align 4
  %t34 = add i0 %t35, %t36
  store i0 %t34, i0* %t14, align 4
  %t40 = load i0, i0* %t14, align 4
  %t39 = icmp sgt i0 %t40, 99
  br i0 %t39, label %B37, label %B43
B33:                               	; preds = %B19
  br label %B28
B20:                               	; preds = %B25
  %t55 = load i0, i0* %t14, align 4
  ret i0 %t55
B37:                               	; preds = %B27
  %t46 = load i0, i0* %t26, align 4
  %t45 = mul i0 %t46, 2
  store i0 %t45, i0* %t44, align 4
  %t49 = icmp eq i0 1, 1
  br i0 %t49, label %B47, label %B52
B43:                               	; preds = %B27
  br label %B38
B28:                               	; preds = %B33, %B38
  br label %B18
B47:                               	; preds = %B37
  %t54 = load i0, i0* %t44, align 4
  %t53 = mul i0 %t54, 2
  store i0 %t53, i0* %t14, align 4
  br label %B48
B52:                               	; preds = %B37
  br label %B48
B38:                               	; preds = %B43, %B48
  br label %B28
B48:                               	; preds = %B47, %B52
  br label %B38
}
define i0 @main() {
B56:
  %t57 = alloca i0, align 4
  store i0 2, i0* %t57, align 4
  %t58 = load i0, i0* %t57, align 4
  %t59 = load i0, i0* %t57, align 4
  %t60 = call i0 @deepWhileBr(i0 %t60, i0 %t58, i0 %t59)
  ret i0 %t60
}

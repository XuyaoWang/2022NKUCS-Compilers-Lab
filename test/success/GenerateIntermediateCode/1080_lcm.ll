declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@n = global i0 0, align 4
define i0 @gcd(i0 @m, i0 @n) {
B7:
  %t17 = alloca i0, align 4
  %t16 = alloca i0, align 4
  %t13 = alloca i0, align 4
  %t12 = alloca i0, align 4
  %t11 = alloca i0, align 4
  %t9 = alloca i0, align 4
  store i0 %t8, i0* %t9, align 4
  store i0 %t10, i0* %t11, align 4
  %t14 = load i0, i0* %t9, align 4
  store i0 %t14, i0* %t12, align 4
  %t15 = load i0, i0* %t11, align 4
  store i0 %t15, i0* %t13, align 4
  %t21 = load i0, i0* %t9, align 4
  %t22 = load i0, i0* %t11, align 4
  %t20 = icmp slt i0 %t21, %t22
  br i0 %t20, label %B18, label %B25
B18:                               	; preds = %B7
  %t26 = load i0, i0* %t9, align 4
  store i0 %t26, i0* %t16, align 4
  %t27 = load i0, i0* %t11, align 4
  store i0 %t27, i0* %t9, align 4
  %t28 = load i0, i0* %t16, align 4
  store i0 %t28, i0* %t11, align 4
  br label %B19
B25:                               	; preds = %B7
  br label %B19
B19:                               	; preds = %B18, %B25
  %t30 = load i0, i0* %t9, align 4
  %t31 = load i0, i0* %t11, align 4
  %t29 = srem i0 %t30, %t31
  store i0 %t29, i0* %t17, align 4
  br label %B32
B32:                               	; preds = %B19, %B33
  %t36 = load i0, i0* %t17, align 4
  %t35 = icmp ne i0 %t36, 0
  br i0 %t35, label %B33, label %B39
B33:                               	; preds = %B32
  %t40 = load i0, i0* %t11, align 4
  store i0 %t40, i0* %t9, align 4
  %t41 = load i0, i0* %t17, align 4
  store i0 %t41, i0* %t11, align 4
  %t43 = load i0, i0* %t9, align 4
  %t44 = load i0, i0* %t11, align 4
  %t42 = srem i0 %t43, %t44
  store i0 %t42, i0* %t17, align 4
  br label %B32
B39:                               	; preds = %B32
  br label %B34
B34:                               	; preds = %B39
  %t47 = load i0, i0* %t12, align 4
  %t48 = load i0, i0* %t13, align 4
  %t46 = mul i0 %t47, %t48
  %t49 = load i0, i0* %t11, align 4
  %t45 = sdiv i0 %t46, %t49
  ret i0 %t45
}
define i0 @main() {
B50:
  %t52 = alloca i0, align 4
  %t51 = alloca i0, align 4
  %t53 = call i0 @getint(i0 %t53)
  store i0 %t53, i0* %t51, align 4
  %t54 = call i0 @getint(i0 %t54)
  store i0 %t54, i0* %t52, align 4
  %t55 = load i0, i0* %t51, align 4
  %t56 = load i0, i0* %t52, align 4
  %t57 = call i0 @gcd(i0 %t57, i0 %t55, i0 %t56)
  ret i0 %t57
}

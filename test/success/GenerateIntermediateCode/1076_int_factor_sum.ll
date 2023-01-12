declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@N = global i0 0, align 4
@newline = global i0 0, align 4
define i0 @factor(i0 @n) {
B7:
  %t11 = alloca i0, align 4
  %t10 = alloca i0, align 4
  %t9 = alloca i0, align 4
  store i0 %t8, i0* %t9, align 4
  store i0 0, i0* %t11, align 4
  store i0 1, i0* %t10, align 4
  br label %B12
B12:                               	; preds = %B7, %B23
  %t16 = load i0, i0* %t10, align 4
  %t18 = load i0, i0* %t9, align 4
  %t17 = add i0 %t18, 1
  %t15 = icmp slt i0 %t16, %t17
  br i0 %t15, label %B13, label %B21
B13:                               	; preds = %B12
  %t26 = load i0, i0* %t9, align 4
  %t27 = load i0, i0* %t10, align 4
  %t25 = srem i0 %t26, %t27
  %t24 = icmp eq i0 %t25, 0
  br i0 %t24, label %B22, label %B30
B21:                               	; preds = %B12
  br label %B14
B22:                               	; preds = %B13
  %t32 = load i0, i0* %t11, align 4
  %t33 = load i0, i0* %t10, align 4
  %t31 = add i0 %t32, %t33
  store i0 %t31, i0* %t11, align 4
  br label %B23
B30:                               	; preds = %B13
  br label %B23
B14:                               	; preds = %B21
  %t36 = load i0, i0* %t11, align 4
  ret i0 %t36
B23:                               	; preds = %B22, %B30
  %t35 = load i0, i0* %t10, align 4
  %t34 = add i0 %t35, 1
  store i0 %t34, i0* %t10, align 4
  br label %B12
}
define i0 @main() {
B37:
  %t40 = alloca i0, align 4
  %t39 = alloca i0, align 4
  %t38 = alloca i0, align 4
  store i0 4, i0* @N, align 4
  store i0 10, i0* @newline, align 4
  store i0 1478, i0* %t39, align 4
  %t41 = load i0, i0* %t39, align 4
  %t42 = call i0 @factor(i0 %t42, i0 %t41)
  ret i0 %t42
}

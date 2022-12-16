declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i32 0, align 4
@b = global i32 0, align 4
@c = global i32 0, align 4
@d = global i32 0, align 4
@e = global i32 0, align 4
define i32 @main() {
B21:
  %fail27 = alloca i32, align 4
  %fail22 = call i32 @getint()
  store i32 %fail22, i32* @a, align 4
  %fail23 = call i32 @getint()
  store i32 %fail23, i32* @b, align 4
  %fail24 = call i32 @getint()
  store i32 %fail24, i32* @c, align 4
  %fail25 = call i32 @getint()
  store i32 %fail25, i32* @d, align 4
  %fail26 = call i32 @getint()
  store i32 %fail26, i32* @e, align 4
  store i32 0, i32* %fail27, align 4
  %fail36 = load i32, i32* @a, align 4
  %fail38 = load i32, i32* @b, align 4
  %fail39 = load i32, i32* @c, align 4
  %fail37 = mul i32 %fail38, %fail39
  %fail35 = sub i32 %fail36, %fail37
  %fail41 = load i32, i32* @d, align 4
  %fail43 = load i32, i32* @a, align 4
  %fail44 = load i32, i32* @c, align 4
  %fail42 = sdiv i32 %fail43, %fail44
  %fail40 = sub i32 %fail41, %fail42
  %fail34 = icmp ne i32 %fail35, %fail40
  br i1 %fail34, label %B28, label %B47
B28:                               	; preds = %B21, %B31, %B33
  store i32 1, i32* %fail27, align 4
  br label %B29
B47:                               	; preds = %B21
  br label %B33
B29:                               	; preds = %B28, %B71
  %fail72 = load i32, i32* %fail27, align 4
  ret i32 %fail72
B33:                               	; preds = %B47
  %fail51 = load i32, i32* @a, align 4
  %fail52 = load i32, i32* @b, align 4
  %fail50 = mul i32 %fail51, %fail52
  %fail53 = load i32, i32* @c, align 4
  %fail49 = sdiv i32 %fail50, %fail53
  %fail55 = load i32, i32* @e, align 4
  %fail56 = load i32, i32* @d, align 4
  %fail54 = add i32 %fail55, %fail56
  %fail48 = icmp eq i32 %fail49, %fail54
  br i1 %fail48, label %B28, label %B59
B59:                               	; preds = %B33
  br label %B31
B31:                               	; preds = %B59
  %fail63 = load i32, i32* @a, align 4
  %fail64 = load i32, i32* @b, align 4
  %fail62 = add i32 %fail63, %fail64
  %fail65 = load i32, i32* @c, align 4
  %fail61 = add i32 %fail62, %fail65
  %fail67 = load i32, i32* @d, align 4
  %fail68 = load i32, i32* @e, align 4
  %fail66 = add i32 %fail67, %fail68
  %fail60 = icmp eq i32 %fail61, %fail66
  br i1 %fail60, label %B28, label %B71
B71:                               	; preds = %B31
  br label %B29
}

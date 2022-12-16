declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i32 1, align 4
@b = global i32 0, align 4
@c = global i32 1, align 4
@d = global i32 2, align 4
@e = global i32 4, align 4
define i32 @main() {
B23:
  %fail24 = alloca i32, align 4
  store i32 0, i32* %fail24, align 4
  %fail34 = load i32, i32* @a, align 4
  %fail35 = load i32, i32* @b, align 4
  %fail33 = mul i32 %fail34, %fail35
  %fail36 = load i32, i32* @c, align 4
  %fail32 = sdiv i32 %fail33, %fail36
  %fail38 = load i32, i32* @e, align 4
  %fail39 = load i32, i32* @d, align 4
  %fail37 = add i32 %fail38, %fail39
  %fail31 = icmp eq i32 %fail32, %fail37
  br i1 %fail31, label %B30, label %B42
B30:                               	; preds = %B23
  %fail46 = load i32, i32* @a, align 4
  %fail48 = load i32, i32* @a, align 4
  %fail49 = load i32, i32* @b, align 4
  %fail47 = add i32 %fail48, %fail49
  %fail45 = mul i32 %fail46, %fail47
  %fail50 = load i32, i32* @c, align 4
  %fail44 = add i32 %fail45, %fail50
  %fail52 = load i32, i32* @d, align 4
  %fail53 = load i32, i32* @e, align 4
  %fail51 = add i32 %fail52, %fail53
  %fail43 = icmp sle i32 %fail44, %fail51
  br i1 %fail43, label %B25, label %B56
B42:                               	; preds = %B23
  br label %B28
B25:                               	; preds = %B28, %B30
  store i32 1, i32* %fail24, align 4
  br label %B26
B56:                               	; preds = %B30
  br label %B28
B28:                               	; preds = %B42, %B56
  %fail59 = load i32, i32* @a, align 4
  %fail61 = load i32, i32* @b, align 4
  %fail62 = load i32, i32* @c, align 4
  %fail60 = mul i32 %fail61, %fail62
  %fail58 = sub i32 %fail59, %fail60
  %fail64 = load i32, i32* @d, align 4
  %fail66 = load i32, i32* @a, align 4
  %fail67 = load i32, i32* @c, align 4
  %fail65 = sdiv i32 %fail66, %fail67
  %fail63 = sub i32 %fail64, %fail65
  %fail57 = icmp eq i32 %fail58, %fail63
  br i1 %fail57, label %B25, label %B70
B26:                               	; preds = %B25, %B70
  %fail71 = load i32, i32* %fail24, align 4
  call void @putint(i32 %fail71)
  %fail72 = load i32, i32* %fail24, align 4
  ret i32 %fail72
B70:                               	; preds = %B28
  br label %B26
}

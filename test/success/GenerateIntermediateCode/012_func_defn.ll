declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i0 0, align 4
define i0 @func(i0 @p) {
B2:
  %t4 = alloca i0, align 4
  store i0 %t3, i0* %t4, align 4
  %t6 = load i0, i0* %t4, align 4
  %t5 = sub i0 %t6, 1
  store i0 %t5, i0* %t4, align 4
  %t7 = load i0, i0* %t4, align 4
  ret i0 %t7
}
define i0 @main() {
B8:
  %t9 = alloca i0, align 4
  store i0 10, i0* @a, align 4
  %t10 = load i0, i0* @a, align 4
  %t11 = call i0 @func(i0 %t11, i0 %t10)
  store i0 %t11, i0* %t9, align 4
  %t12 = load i0, i0* %t9, align 4
  ret i0 %t12
}

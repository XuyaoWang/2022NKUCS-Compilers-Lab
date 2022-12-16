declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
define i32 @defn() {
B0:
  ret i32 4
}
define i32 @main() {
B1:
  %fail2 = alloca i32, align 4
  %fail3 = call i32 @defn()
  store i32 %fail3, i32* %fail2, align 4
  %fail4 = load i32, i32* %fail2, align 4
  ret i32 %fail4
}

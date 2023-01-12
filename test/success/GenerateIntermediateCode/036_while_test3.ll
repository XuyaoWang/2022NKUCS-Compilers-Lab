declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@g = global i0 0, align 4
@h = global i0 0, align 4
@f = global i0 0, align 4
@e = global i0 0, align 4
define i0 @EightWhile() {
B30:
  %t34 = alloca i0, align 4
  %t33 = alloca i0, align 4
  %t32 = alloca i0, align 4
  %t31 = alloca i0, align 4
  store i0 5, i0* %t31, align 4
  store i0 6, i0* %t32, align 4
  store i0 7, i0* %t33, align 4
  store i0 10, i0* %t34, align 4
  br label %B35
B35:                               	; preds = %B30, %B47
  %t39 = load i0, i0* %t31, align 4
  %t38 = icmp slt i0 %t39, 20
  br i0 %t38, label %B36, label %B42
B36:                               	; preds = %B35
  %t44 = load i0, i0* %t31, align 4
  %t43 = add i0 %t44, 3
  store i0 %t43, i0* %t31, align 4
  br label %B45
B42:                               	; preds = %B35
  br label %B37
B45:                               	; preds = %B36, %B57
  %t49 = load i0, i0* %t32, align 4
  %t48 = icmp slt i0 %t49, 10
  br i0 %t48, label %B46, label %B52
B37:                               	; preds = %B42
  %t132 = load i0, i0* %t31, align 4
  %t134 = load i0, i0* %t32, align 4
  %t135 = load i0, i0* %t34, align 4
  %t133 = add i0 %t134, %t135
  %t131 = add i0 %t132, %t133
  %t136 = load i0, i0* %t33, align 4
  %t130 = add i0 %t131, %t136
  %t140 = load i0, i0* @e, align 4
  %t141 = load i0, i0* %t34, align 4
  %t139 = add i0 %t140, %t141
  %t142 = load i0, i0* @g, align 4
  %t138 = sub i0 %t139, %t142
  %t143 = load i0, i0* @h, align 4
  %t137 = add i0 %t138, %t143
  %t129 = sub i0 %t130, %t137
  ret i0 %t129
B46:                               	; preds = %B45
  %t54 = load i0, i0* %t32, align 4
  %t53 = add i0 %t54, 1
  store i0 %t53, i0* %t32, align 4
  br label %B55
B52:                               	; preds = %B45
  br label %B47
B55:                               	; preds = %B46, %B67
  %t59 = load i0, i0* %t33, align 4
  %t58 = icmp eq i0 %t59, 7
  br i0 %t58, label %B56, label %B62
B47:                               	; preds = %B52
  %t128 = load i0, i0* %t32, align 4
  %t127 = sub i0 %t128, 2
  store i0 %t127, i0* %t32, align 4
  br label %B35
B56:                               	; preds = %B55
  %t64 = load i0, i0* %t33, align 4
  %t63 = sub i0 %t64, 1
  store i0 %t63, i0* %t33, align 4
  br label %B65
B62:                               	; preds = %B55
  br label %B57
B65:                               	; preds = %B56, %B77
  %t69 = load i0, i0* %t34, align 4
  %t68 = icmp slt i0 %t69, 20
  br i0 %t68, label %B66, label %B72
B57:                               	; preds = %B62
  %t126 = load i0, i0* %t33, align 4
  %t125 = add i0 %t126, 1
  store i0 %t125, i0* %t33, align 4
  br label %B45
B66:                               	; preds = %B65
  %t74 = load i0, i0* %t34, align 4
  %t73 = add i0 %t74, 3
  store i0 %t73, i0* %t34, align 4
  br label %B75
B72:                               	; preds = %B65
  br label %B67
B75:                               	; preds = %B66, %B87
  %t79 = load i0, i0* @e, align 4
  %t78 = icmp sgt i0 %t79, 1
  br i0 %t78, label %B76, label %B82
B67:                               	; preds = %B72
  %t124 = load i0, i0* %t34, align 4
  %t123 = sub i0 %t124, 1
  store i0 %t123, i0* %t34, align 4
  br label %B55
B76:                               	; preds = %B75
  %t84 = load i0, i0* @e, align 4
  %t83 = sub i0 %t84, 1
  store i0 %t83, i0* @e, align 4
  br label %B85
B82:                               	; preds = %B75
  br label %B77
B85:                               	; preds = %B76, %B97
  %t89 = load i0, i0* @f, align 4
  %t88 = icmp sgt i0 %t89, 2
  br i0 %t88, label %B86, label %B92
B77:                               	; preds = %B82
  %t122 = load i0, i0* @e, align 4
  %t121 = add i0 %t122, 1
  store i0 %t121, i0* @e, align 4
  br label %B65
B86:                               	; preds = %B85
  %t94 = load i0, i0* @f, align 4
  %t93 = sub i0 %t94, 2
  store i0 %t93, i0* @f, align 4
  br label %B95
B92:                               	; preds = %B85
  br label %B87
B95:                               	; preds = %B86, %B107
  %t99 = load i0, i0* @g, align 4
  %t98 = icmp slt i0 %t99, 3
  br i0 %t98, label %B96, label %B102
B87:                               	; preds = %B92
  %t120 = load i0, i0* @f, align 4
  %t119 = add i0 %t120, 1
  store i0 %t119, i0* @f, align 4
  br label %B75
B96:                               	; preds = %B95
  %t104 = load i0, i0* @g, align 4
  %t103 = add i0 %t104, 10
  store i0 %t103, i0* @g, align 4
  br label %B105
B102:                               	; preds = %B95
  br label %B97
B105:                               	; preds = %B96, %B106
  %t109 = load i0, i0* @h, align 4
  %t108 = icmp slt i0 %t109, 10
  br i0 %t108, label %B106, label %B112
B97:                               	; preds = %B102
  %t118 = load i0, i0* @g, align 4
  %t117 = sub i0 %t118, 8
  store i0 %t117, i0* @g, align 4
  br label %B85
B106:                               	; preds = %B105
  %t114 = load i0, i0* @h, align 4
  %t113 = add i0 %t114, 8
  store i0 %t113, i0* @h, align 4
  br label %B105
B112:                               	; preds = %B105
  br label %B107
B107:                               	; preds = %B112
  %t116 = load i0, i0* @h, align 4
  %t115 = sub i0 %t116, 1
  store i0 %t115, i0* @h, align 4
  br label %B95
}
define i0 @main() {
B144:
  store i0 1, i0* @g, align 4
  store i0 2, i0* @h, align 4
  store i0 4, i0* @e, align 4
  store i0 6, i0* @f, align 4
  %t145 = call i0 @EightWhile(i0 %t145)
  ret i0 %t145
}

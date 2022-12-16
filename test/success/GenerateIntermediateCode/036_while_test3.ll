declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@g = global i32 0, align 4
@h = global i32 0, align 4
@f = global i32 0, align 4
@e = global i32 0, align 4
define i32 @EightWhile() {
B46:
  %fail50 = alloca i32, align 4
  %fail49 = alloca i32, align 4
  %fail48 = alloca i32, align 4
  %fail47 = alloca i32, align 4
  store i32 5, i32* %fail47, align 4
  store i32 6, i32* %fail48, align 4
  store i32 7, i32* %fail49, align 4
  store i32 10, i32* %fail50, align 4
  br label %B51
B51:                               	; preds = %B46, %B63
  %fail55 = load i32, i32* %fail47, align 4
  %fail54 = icmp slt i32 %fail55, 20
  br i1 %fail54, label %B52, label %B58
B52:                               	; preds = %B51
  %fail60 = load i32, i32* %fail47, align 4
  %fail59 = add i32 %fail60, 3
  store i32 %fail59, i32* %fail47, align 4
  br label %B61
B58:                               	; preds = %B51
  br label %B53
B61:                               	; preds = %B52, %B73
  %fail65 = load i32, i32* %fail48, align 4
  %fail64 = icmp slt i32 %fail65, 10
  br i1 %fail64, label %B62, label %B68
B53:                               	; preds = %B58
  %fail148 = load i32, i32* %fail47, align 4
  %fail150 = load i32, i32* %fail48, align 4
  %fail151 = load i32, i32* %fail50, align 4
  %fail149 = add i32 %fail150, %fail151
  %fail147 = add i32 %fail148, %fail149
  %fail152 = load i32, i32* %fail49, align 4
  %fail146 = add i32 %fail147, %fail152
  %fail156 = load i32, i32* @e, align 4
  %fail157 = load i32, i32* %fail50, align 4
  %fail155 = add i32 %fail156, %fail157
  %fail158 = load i32, i32* @g, align 4
  %fail154 = sub i32 %fail155, %fail158
  %fail159 = load i32, i32* @h, align 4
  %fail153 = add i32 %fail154, %fail159
  %fail145 = sub i32 %fail146, %fail153
  ret i32 %fail145
B62:                               	; preds = %B61
  %fail70 = load i32, i32* %fail48, align 4
  %fail69 = add i32 %fail70, 1
  store i32 %fail69, i32* %fail48, align 4
  br label %B71
B68:                               	; preds = %B61
  br label %B63
B71:                               	; preds = %B62, %B83
  %fail75 = load i32, i32* %fail49, align 4
  %fail74 = icmp eq i32 %fail75, 7
  br i1 %fail74, label %B72, label %B78
B63:                               	; preds = %B68
  %fail144 = load i32, i32* %fail48, align 4
  %fail143 = sub i32 %fail144, 2
  store i32 %fail143, i32* %fail48, align 4
  br label %B51
B72:                               	; preds = %B71
  %fail80 = load i32, i32* %fail49, align 4
  %fail79 = sub i32 %fail80, 1
  store i32 %fail79, i32* %fail49, align 4
  br label %B81
B78:                               	; preds = %B71
  br label %B73
B81:                               	; preds = %B72, %B93
  %fail85 = load i32, i32* %fail50, align 4
  %fail84 = icmp slt i32 %fail85, 20
  br i1 %fail84, label %B82, label %B88
B73:                               	; preds = %B78
  %fail142 = load i32, i32* %fail49, align 4
  %fail141 = add i32 %fail142, 1
  store i32 %fail141, i32* %fail49, align 4
  br label %B61
B82:                               	; preds = %B81
  %fail90 = load i32, i32* %fail50, align 4
  %fail89 = add i32 %fail90, 3
  store i32 %fail89, i32* %fail50, align 4
  br label %B91
B88:                               	; preds = %B81
  br label %B83
B91:                               	; preds = %B82, %B103
  %fail95 = load i32, i32* @e, align 4
  %fail94 = icmp sgt i32 %fail95, 1
  br i1 %fail94, label %B92, label %B98
B83:                               	; preds = %B88
  %fail140 = load i32, i32* %fail50, align 4
  %fail139 = sub i32 %fail140, 1
  store i32 %fail139, i32* %fail50, align 4
  br label %B71
B92:                               	; preds = %B91
  %fail100 = load i32, i32* @e, align 4
  %fail99 = sub i32 %fail100, 1
  store i32 %fail99, i32* @e, align 4
  br label %B101
B98:                               	; preds = %B91
  br label %B93
B101:                               	; preds = %B92, %B113
  %fail105 = load i32, i32* @f, align 4
  %fail104 = icmp sgt i32 %fail105, 2
  br i1 %fail104, label %B102, label %B108
B93:                               	; preds = %B98
  %fail138 = load i32, i32* @e, align 4
  %fail137 = add i32 %fail138, 1
  store i32 %fail137, i32* @e, align 4
  br label %B81
B102:                               	; preds = %B101
  %fail110 = load i32, i32* @f, align 4
  %fail109 = sub i32 %fail110, 2
  store i32 %fail109, i32* @f, align 4
  br label %B111
B108:                               	; preds = %B101
  br label %B103
B111:                               	; preds = %B102, %B123
  %fail115 = load i32, i32* @g, align 4
  %fail114 = icmp slt i32 %fail115, 3
  br i1 %fail114, label %B112, label %B118
B103:                               	; preds = %B108
  %fail136 = load i32, i32* @f, align 4
  %fail135 = add i32 %fail136, 1
  store i32 %fail135, i32* @f, align 4
  br label %B91
B112:                               	; preds = %B111
  %fail120 = load i32, i32* @g, align 4
  %fail119 = add i32 %fail120, 10
  store i32 %fail119, i32* @g, align 4
  br label %B121
B118:                               	; preds = %B111
  br label %B113
B121:                               	; preds = %B112, %B122
  %fail125 = load i32, i32* @h, align 4
  %fail124 = icmp slt i32 %fail125, 10
  br i1 %fail124, label %B122, label %B128
B113:                               	; preds = %B118
  %fail134 = load i32, i32* @g, align 4
  %fail133 = sub i32 %fail134, 8
  store i32 %fail133, i32* @g, align 4
  br label %B101
B122:                               	; preds = %B121
  %fail130 = load i32, i32* @h, align 4
  %fail129 = add i32 %fail130, 8
  store i32 %fail129, i32* @h, align 4
  br label %B121
B128:                               	; preds = %B121
  br label %B123
B123:                               	; preds = %B128
  %fail132 = load i32, i32* @h, align 4
  %fail131 = sub i32 %fail132, 1
  store i32 %fail131, i32* @h, align 4
  br label %B111
}
define i32 @main() {
B160:
  store i32 1, i32* @g, align 4
  store i32 2, i32* @h, align 4
  store i32 4, i32* @e, align 4
  store i32 6, i32* @f, align 4
  %fail161 = call i32 @EightWhile()
  ret i32 %fail161
}

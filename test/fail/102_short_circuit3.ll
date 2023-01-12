declare i32 @getint()
declare i32 @getch()
declare void @putint(i32)
declare void @putch(i32)
@a = global i32 0, align 4
@b = global i32 0, align 4
@d = global i32 0, align 4
define i32 @set_a(i32 %t93) {
B92:
  %t94 = alloca i32, align 4
  store i32 %t93, i32* %t94, align 4
  %t95 = load i32, i32* %t94, align 4
  store i32 %t95, i32* @a, align 4
  %t96 = load i32, i32* @a, align 4
  ret i32 %t96
}
define i32 @set_b(i32 %t98) {
B97:
  %t99 = alloca i32, align 4
  store i32 %t98, i32* %t99, align 4
  %t100 = load i32, i32* %t99, align 4
  store i32 %t100, i32* @b, align 4
  %t101 = load i32, i32* @b, align 4
  ret i32 %t101
}
define i32 @set_d(i32 %t103) {
B102:
  %t104 = alloca i32, align 4
  store i32 %t103, i32* %t104, align 4
  %t105 = load i32, i32* %t104, align 4
  store i32 %t105, i32* @d, align 4
  %t106 = load i32, i32* @d, align 4
  ret i32 %t106
}
define i32 @main() {
B107:
  %t230 = alloca i32, align 4
  %t229 = alloca i32, align 4
  %t228 = alloca i32, align 4
  %t227 = alloca i32, align 4
  %t226 = alloca i32, align 4
  %t136 = alloca i32, align 4
  store i32 2, i32* @a, align 4
  store i32 3, i32* @b, align 4
  %t112 = call i32 @set_a(i32 0)
  %t78 = icmp ne i32 %t112, 0
  br i1 %t78, label %B111, label %B114
B111:                               	; preds = %B107
  %t116 = call i32 @set_b(i32 1)
  %t79 = icmp ne i32 %t116, 0
  br i1 %t79, label %B108, label %B118
B114:                               	; preds = %B107
  br label %B109
B108:                               	; preds = %B111
  br label %B109
B118:                               	; preds = %B111
  br label %B109
B109:                               	; preds = %B108, %B114, %B118
  %t120 = load i32, i32* @a, align 4
  call void @putint(i32 %t120)
  call void @putch(i32 32)
  %t121 = load i32, i32* @b, align 4
  call void @putint(i32 %t121)
  call void @putch(i32 32)
  store i32 2, i32* @a, align 4
  store i32 3, i32* @b, align 4
  %t126 = call i32 @set_a(i32 0)
  %t80 = icmp ne i32 %t126, 0
  br i1 %t80, label %B125, label %B128
B125:                               	; preds = %B109
  %t130 = call i32 @set_b(i32 1)
  %t81 = icmp ne i32 %t130, 0
  br i1 %t81, label %B122, label %B132
B128:                               	; preds = %B109
  br label %B123
B122:                               	; preds = %B125
  br label %B123
B132:                               	; preds = %B125
  br label %B123
B123:                               	; preds = %B122, %B128, %B132
  %t134 = load i32, i32* @a, align 4
  call void @putint(i32 %t134)
  call void @putch(i32 32)
  %t135 = load i32, i32* @b, align 4
  call void @putint(i32 %t135)
  call void @putch(i32 10)
  store i32 1, i32* %t136, align 4
  store i32 2, i32* @d, align 4
  %t142 = load i32, i32* %t136, align 4
  %t141 = icmp sge i32 %t142, 1
  br i1 %t141, label %B140, label %B145
B140:                               	; preds = %B123
  %t146 = call i32 @set_d(i32 3)
  %t82 = icmp ne i32 %t146, 0
  br i1 %t82, label %B137, label %B148
B145:                               	; preds = %B123
  br label %B138
B137:                               	; preds = %B140
  br label %B138
B148:                               	; preds = %B140
  br label %B138
B138:                               	; preds = %B137, %B145, %B148
  %t150 = load i32, i32* @d, align 4
  call void @putint(i32 %t150)
  call void @putch(i32 32)
  %t156 = load i32, i32* %t136, align 4
  %t155 = icmp sle i32 %t156, 1
  br i1 %t155, label %B151, label %B159
B151:                               	; preds = %B138, %B154
  br label %B152
B159:                               	; preds = %B138
  br label %B154
B152:                               	; preds = %B151, %B162
  %t164 = load i32, i32* @d, align 4
  call void @putint(i32 %t164)
  call void @putch(i32 10)
  %t169 = add i32 2, 1
  %t168 = sub i32 3, %t169
  %t167 = icmp sge i32 16, %t168
  br i1 %t167, label %B165, label %B172
B154:                               	; preds = %B159
  %t160 = call i32 @set_d(i32 4)
  %t83 = icmp ne i32 %t160, 0
  br i1 %t83, label %B151, label %B162
B165:                               	; preds = %B152
  call void @putch(i32 65)
  br label %B166
B172:                               	; preds = %B152
  br label %B166
B162:                               	; preds = %B154
  br label %B152
B166:                               	; preds = %B165, %B172
  %t176 = sub i32 25, 7
  %t178 = mul i32 6, 3
  %t177 = sub i32 36, %t178
  %t175 = icmp ne i32 %t176, %t177
  br i1 %t175, label %B173, label %B181
B173:                               	; preds = %B166
  call void @putch(i32 66)
  br label %B174
B181:                               	; preds = %B166
  br label %B174
B174:                               	; preds = %B173, %B181
  %t185 = icmp slt i32 1, 8
  %t189 = srem i32 7, 2
  %t190 = zext i1 %t185 to i32
  %t184 = icmp ne i32 %t190, %t189
  br i1 %t184, label %B182, label %B193
B182:                               	; preds = %B174
  call void @putch(i32 67)
  br label %B183
B193:                               	; preds = %B174
  br label %B183
B183:                               	; preds = %B182, %B193
  %t197 = icmp sgt i32 3, 4
  %t201 = zext i1 %t197 to i32
  %t196 = icmp eq i32 %t201, 0
  br i1 %t196, label %B194, label %B204
B194:                               	; preds = %B183
  call void @putch(i32 68)
  br label %B195
B204:                               	; preds = %B183
  br label %B195
B195:                               	; preds = %B194, %B204
  %t208 = icmp sle i32 102, 63
  %t212 = zext i1 %t208 to i32
  %t207 = icmp eq i32 1, %t212
  br i1 %t207, label %B205, label %B215
B205:                               	; preds = %B195
  call void @putch(i32 69)
  br label %B206
B215:                               	; preds = %B195
  br label %B206
B206:                               	; preds = %B205, %B215
  %t219 = sub i32 5, 6
  %t221 = icmp ne i32 0, 0
  %t220 = xor i1 %t221, true
  %t222 = zext i1 %t220 to i32
  %t85 = sub i32 0, %t222
  %t218 = icmp eq i32 %t219, %t85
  br i1 %t218, label %B216, label %B225
B216:                               	; preds = %B206
  call void @putch(i32 70)
  br label %B217
B225:                               	; preds = %B206
  br label %B217
B217:                               	; preds = %B216, %B225
  call void @putch(i32 10)
  store i32 0, i32* %t226, align 4
  store i32 1, i32* %t227, align 4
  store i32 2, i32* %t228, align 4
  store i32 3, i32* %t229, align 4
  store i32 4, i32* %t230, align 4
  br label %B231
B231:                               	; preds = %B217, %B232
  %t236 = load i32, i32* %t226, align 4
  %t86 = icmp ne i32 %t236, 0
  br i1 %t86, label %B235, label %B238
B235:                               	; preds = %B231
  %t240 = load i32, i32* %t227, align 4
  %t87 = icmp ne i32 %t240, 0
  br i1 %t87, label %B232, label %B242
B238:                               	; preds = %B231
  br label %B233
B232:                               	; preds = %B235
  call void @putch(i32 32)
  br label %B231
B242:                               	; preds = %B235
  br label %B233
B233:                               	; preds = %B238, %B242
  %t248 = load i32, i32* %t226, align 4
  %t88 = icmp ne i32 %t248, 0
  br i1 %t88, label %B244, label %B250
B244:                               	; preds = %B233, %B247
  call void @putch(i32 67)
  br label %B245
B250:                               	; preds = %B233
  br label %B247
B245:                               	; preds = %B244, %B254
  %t261 = load i32, i32* %t226, align 4
  %t262 = load i32, i32* %t227, align 4
  %t260 = icmp sge i32 %t261, %t262
  br i1 %t260, label %B256, label %B265
B247:                               	; preds = %B250
  %t252 = load i32, i32* %t227, align 4
  %t89 = icmp ne i32 %t252, 0
  br i1 %t89, label %B244, label %B254
B256:                               	; preds = %B245, %B259
  call void @putch(i32 72)
  br label %B257
B265:                               	; preds = %B245
  br label %B259
B254:                               	; preds = %B247
  br label %B245
B257:                               	; preds = %B256, %B271
  %t277 = load i32, i32* %t228, align 4
  %t278 = load i32, i32* %t227, align 4
  %t276 = icmp sge i32 %t277, %t278
  br i1 %t276, label %B275, label %B281
B259:                               	; preds = %B265
  %t267 = load i32, i32* %t227, align 4
  %t268 = load i32, i32* %t226, align 4
  %t266 = icmp sle i32 %t267, %t268
  br i1 %t266, label %B256, label %B271
B275:                               	; preds = %B257
  %t283 = load i32, i32* %t230, align 4
  %t284 = load i32, i32* %t229, align 4
  %t282 = icmp ne i32 %t283, %t284
  br i1 %t282, label %B272, label %B287
B281:                               	; preds = %B257
  br label %B273
B271:                               	; preds = %B259
  br label %B257
B272:                               	; preds = %B275
  call void @putch(i32 73)
  br label %B273
B287:                               	; preds = %B275
  br label %B273
B273:                               	; preds = %B272, %B281, %B287
  %t295 = load i32, i32* %t226, align 4
  %t296 = load i32, i32* %t227, align 4
  %t298 = icmp ne i32 %t296, 0
  %t297 = xor i1 %t298, true
  %t299 = zext i1 %t297 to i32
  %t294 = icmp eq i32 %t295, %t299
  br i1 %t294, label %B293, label %B302
B293:                               	; preds = %B273
  %t304 = load i32, i32* %t229, align 4
  %t305 = load i32, i32* %t229, align 4
  %t303 = icmp slt i32 %t304, %t305
  br i1 %t303, label %B288, label %B308
B302:                               	; preds = %B273
  br label %B291
B288:                               	; preds = %B291, %B293
  call void @putch(i32 74)
  br label %B289
B308:                               	; preds = %B293
  br label %B291
B291:                               	; preds = %B302, %B308
  %t310 = load i32, i32* %t230, align 4
  %t311 = load i32, i32* %t230, align 4
  %t309 = icmp sge i32 %t310, %t311
  br i1 %t309, label %B288, label %B314
B289:                               	; preds = %B288, %B314
  %t320 = load i32, i32* %t226, align 4
  %t321 = load i32, i32* %t227, align 4
  %t323 = icmp ne i32 %t321, 0
  %t322 = xor i1 %t323, true
  %t324 = zext i1 %t322 to i32
  %t319 = icmp eq i32 %t320, %t324
  br i1 %t319, label %B315, label %B327
B314:                               	; preds = %B291
  br label %B289
B315:                               	; preds = %B289, %B329
  call void @putch(i32 75)
  br label %B316
B327:                               	; preds = %B289
  br label %B318
B316:                               	; preds = %B315, %B335, %B341
  call void @putch(i32 10)
  ret i32 0
B318:                               	; preds = %B327
  %t331 = load i32, i32* %t229, align 4
  %t332 = load i32, i32* %t229, align 4
  %t330 = icmp slt i32 %t331, %t332
  br i1 %t330, label %B329, label %B335
B329:                               	; preds = %B318
  %t337 = load i32, i32* %t230, align 4
  %t338 = load i32, i32* %t230, align 4
  %t336 = icmp sge i32 %t337, %t338
  br i1 %t336, label %B315, label %B341
B335:                               	; preds = %B318
  br label %B316
B341:                               	; preds = %B329
  br label %B316
}

.text
	ori $t1, $zero, 5
	mtc1  $t1, $f12
	cvt.s.w $f12, $f12
	ori $t0, $zero, 7
	mtc1 $t0, $f13
	cvt.s.w $f13, $f13
	div.s $f11, $f12, $f13
	ori $t1, $zero, 100
	mtc1  $t1, $f13
	cvt.s.w $f13, $f13
	mul.s $f12, $f11, $f13
	cvt.w.s $f12, $f12
	mfc1 $t0, $f12
	or $a0, $zero, $t0
	ori $v0, $zero, 1
	syscall
	ori $v0, $zero, 10
	syscall	

// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.
// if (R0 < R1) {minVal = R0, maxVal = R1}
// else {minVal = R1, maxVal = R0}

	@i
	M = 0
	@R2 
	M = 0
	
// if (R0 - R1 < 0): goto TRUE
	@R0
	D = M
	@R1
	D = D - M
	@TRUE
	D;JLT
	
// FALSE part
	@R1
	D = M
	@minVal
	M = D
	@R0
	D = M
	@maxVal
	M = D
	@LOOP
	0;JMP
	
(TRUE)
	@R0
	D = M
	@minVal
	M = D
	@R1
	D = M
	@maxVal
	M = D

// for (i = 0; i < minVal; i++ ) { sum += maxVal }

(LOOP)

// if (i == minVal): goto END
	@minVal
	D = M
	@i
	D = D - M
	@END
	D;JEQ

	@maxVal
	D = M
	@R2
	M = M + D
	@i
	M = M + 1
	
	@LOOP
	0;JMP
	
(END)
	@END
	0;JMP
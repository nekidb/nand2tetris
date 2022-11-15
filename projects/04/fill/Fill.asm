// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, M Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
	// lastState = 0
	@lastState
	M = 0
	
	// lastScreenReg = SCREEN + 8192
	@8192
	D = A
	@SCREEN
	D = D + A
	@lastScreenReg
	M = D

(CHECK_KBD)
	// if (KBD != 0) goto TRUE
	@KBD
	D = M
	@TRUE
	D;JNE
	
	// nextState = 0
	@nextState
	M = 0
	@SCREEN_UPDATE
	0;JMP
	
(TRUE)
	// nextState = -1
	@nextState
	M = -1
	@SCREEN_UPDATE
	0;JMP

(SCREEN_UPDATE)
	// if (lastState == nextState) goto CHECK_KBD
	@lastState
	D = M
	@nextState
	D = D - M
	@CHECK_KBD
	D;JEQ
	
	// screenIdx = SCREEN
	@SCREEN
	D = A
	@screenIdx
	M = D
	
(LOOP)
	// if (screenIdx == lastScreenReg) goto AFTER_LOOP
	@lastScreenReg
	D = M
	@screenIdx
	D = D - M
	@AFTER_LOOP
	D;JEQ
	
	// Screen[screenIdx] = nextState
	@nextState
	D = M
	@screenIdx
	A = M
	M = D
	
	// screenIdx++
	@screenIdx
	M = M + 1
	
	@LOOP
	0;JMP
	
(AFTER_LOOP)
	//lastState = nextState
	@nextState
	D = M
	@lastState
	M = D
	
	@CHECK_KBD
	0;JMP
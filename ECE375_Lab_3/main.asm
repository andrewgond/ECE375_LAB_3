;***********************************************************
;*	This is the skeleton file for Lab 3 of ECE 375
;*
;*	 Author: Andrew Gondoputro
;			Harrison Gregory
;*	   Date: 1/30/2025
;*
;***********************************************************

.include "m32U4def.inc"			; Include definition file

;***********************************************************
;*	Internal Register Definitions and Constants
;***********************************************************
.def	mpr = r16				; Multipurpose register is required for LCD 
.def	waitcnt = r17			; Wait Loop Counter
.def	ilcnt = r18				; Inner Loop Counter
.def	olcnt = r19				; Outer Loop Counter

;***********************************************************
;*	Start of Code Segment
;***********************************************************
.cseg							; Beginning of code segment

;***********************************************************
;*	Interrupt Vectors
;***********************************************************
.org	$0000					; Beginning of IVs
		rjmp INIT				; Reset interrupt

.org	$0056					; End of Interrupt Vectors

;***********************************************************
;*	Program Initialization
;***********************************************************
INIT:							; The initialization routine
		; Initialize Stack Pointer

		; Initialize LCD Display

		; NOTE that there is no RET or RJMP from INIT,
		; this is because the next instruction executed is the
		; first instruction of the main program

;***********************************************************
;*	Main Program
;***********************************************************
MAIN:							; The Main program
		; Main function design is up to you. Below is an example to brainstorm.

		; Move strings from Program Memory to Data Memory

		; Display the strings on the LCD Display





		rjmp	MAIN			; jump back to main and create an infinite
								; while loop.  Generally, every main program is an
								; infinite while loop, never let the main program
								; just run off

;***********************************************************
;*	Functions and Subroutines
;***********************************************************

;-----------------------------------------------------------
; Func: Template function header
; Desc: Cut and paste this and fill in the info at the
;		beginning of your functions
;-----------------------------------------------------------
FUNC:							; Begin a function with a label
		; Save variables by pushing them to the stack

		; Execute the function here

		; Restore variables by popping them from the stack,
		; in reverse order

		ret						; End a function with RET


;----------------------------------------------------------------
; Sub:	Wait
; Desc:	A wait loop that is 16 + 159975*waitcnt cycles or roughly
;		waitcnt*10ms.  Just initialize wait for the specific amount
;		of time in 10ms intervals. Here is the general eqaution
;		for the number of clock cycles in the wait loop:
;			(((((3*ilcnt)-1+4)*olcnt)-1+4)*waitcnt)-1+16
;----------------------------------------------------------------
Wait:
		push	waitcnt			; Save wait register
		push	ilcnt			; Save ilcnt register
		push	olcnt			; Save olcnt register

Loop:	ldi		olcnt, 224		; load olcnt register
OLoop:	ldi		ilcnt, 237		; load ilcnt register
ILoop:	dec		ilcnt			; decrement ilcnt
		brne	ILoop			; Continue Inner Loop
		dec		olcnt		; decrement olcnt
		brne	OLoop			; Continue Outer Loop
		dec		waitcnt		; Decrement wait
		brne	Loop			; Continue Wait loop

		pop		olcnt		; Restore olcnt register
		pop		ilcnt		; Restore ilcnt register
		pop		waitcnt		; Restore wait register
		ret				; Return from subroutine


;***********************************************************
;*	Stored Program Data
;***********************************************************

;-----------------------------------------------------------
; An example of storing a string. Note the labels before and
; after the .DB directive; these can help to access the data
;-----------------------------------------------------------
STRING_BEG:
.DB		"My Test String"		; Declaring data in ProgMem
STRING_END:

;***********************************************************
;*	Additional Program Includes
;***********************************************************
.include "LCDDriver.asm"		; Include the LCD Driver

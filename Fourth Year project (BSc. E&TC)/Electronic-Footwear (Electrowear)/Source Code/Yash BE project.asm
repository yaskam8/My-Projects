
_msdelay:

;Yash BE project.c,34 :: 		void msdelay (unsigned int itime) //delay routine
;Yash BE project.c,37 :: 		for(i=0; i<itime; i++)
	CLRF        R1 
	CLRF        R2 
L_msdelay0:
	MOVF        FARG_msdelay_itime+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__msdelay332
	MOVF        FARG_msdelay_itime+0, 0 
	SUBWF       R1, 0 
L__msdelay332:
	BTFSC       STATUS+0, 0 
	GOTO        L_msdelay1
;Yash BE project.c,38 :: 		for(j=0; j<175; j++);
	CLRF        R3 
	CLRF        R4 
L_msdelay3:
	MOVLW       0
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__msdelay333
	MOVLW       175
	SUBWF       R3, 0 
L__msdelay333:
	BTFSC       STATUS+0, 0 
	GOTO        L_msdelay4
	INFSNZ      R3, 1 
	INCF        R4, 1 
	GOTO        L_msdelay3
L_msdelay4:
;Yash BE project.c,37 :: 		for(i=0; i<itime; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;Yash BE project.c,38 :: 		for(j=0; j<175; j++);
	GOTO        L_msdelay0
L_msdelay1:
;Yash BE project.c,39 :: 		}
L_end_msdelay:
	RETURN      0
; end of _msdelay

_masterloop:

;Yash BE project.c,41 :: 		int masterloop(void)
;Yash BE project.c,45 :: 		int i=0;
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
;Yash BE project.c,57 :: 		ip1 = ADC_Read(0)*scaler1;
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVF        _scaler1+0, 0 
	MOVWF       R4 
	MOVF        _scaler1+1, 0 
	MOVWF       R5 
	MOVF        _scaler1+2, 0 
	MOVWF       R6 
	MOVF        _scaler1+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_ip1_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_ip1_L0+1 
;Yash BE project.c,59 :: 		vDisp1[0] = ip1 / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp1_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp1_L0+1 
;Yash BE project.c,60 :: 		vDisp1[1] = (ip1 / 100) % 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip1_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip1_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp1_L0+2 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp1_L0+3 
;Yash BE project.c,61 :: 		vDisp1[2] = (ip1 % 100) / 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip1_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip1_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp1_L0+4 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp1_L0+5 
;Yash BE project.c,62 :: 		vDisp1[3] = ip1 % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip1_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip1_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp1_L0+6 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp1_L0+7 
;Yash BE project.c,63 :: 		Display1[0] = vDisp1[0] + 48 ;
	MOVLW       48
	ADDWF       masterloop_vDisp1_L0+0, 0 
	MOVWF       masterloop_Display1_L0+0 
	MOVLW       0
	ADDWFC      masterloop_vDisp1_L0+1, 0 
	MOVWF       masterloop_Display1_L0+1 
;Yash BE project.c,64 :: 		Display1[1] = vDisp1[1] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp1_L0+2, 0 
	MOVWF       masterloop_Display1_L0+2 
	MOVLW       0
	ADDWFC      masterloop_vDisp1_L0+3, 0 
	MOVWF       masterloop_Display1_L0+3 
;Yash BE project.c,65 :: 		Display1[2] = vDisp1[2] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp1_L0+4, 0 
	MOVWF       masterloop_Display1_L0+4 
	MOVLW       0
	ADDWFC      masterloop_vDisp1_L0+5, 0 
	MOVWF       masterloop_Display1_L0+5 
;Yash BE project.c,66 :: 		Display1[3] = vDisp1[3] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       masterloop_Display1_L0+6 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       masterloop_Display1_L0+7 
;Yash BE project.c,72 :: 		for(i=0;i<4;i++)
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
L_masterloop6:
	MOVLW       128
	XORWF       masterloop_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop335
	MOVLW       4
	SUBWF       masterloop_i_L0+0, 0 
L__masterloop335:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop7
;Yash BE project.c,74 :: 		if(Display1[i]==48)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop336
	MOVLW       48
	XORWF       R1, 0 
L__masterloop336:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop9
;Yash BE project.c,76 :: 		D1[i]=0;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Yash BE project.c,77 :: 		}
	GOTO        L_masterloop10
L_masterloop9:
;Yash BE project.c,78 :: 		else if(Display1[i]==49)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop337
	MOVLW       49
	XORWF       R1, 0 
L__masterloop337:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop11
;Yash BE project.c,80 :: 		D1[i]=1;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,81 :: 		}
	GOTO        L_masterloop12
L_masterloop11:
;Yash BE project.c,82 :: 		else if(Display1[i]==50)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop338
	MOVLW       50
	XORWF       R1, 0 
L__masterloop338:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop13
;Yash BE project.c,84 :: 		D1[i]=2;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,85 :: 		}
	GOTO        L_masterloop14
L_masterloop13:
;Yash BE project.c,86 :: 		else if(Display1[i]==51)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop339
	MOVLW       51
	XORWF       R1, 0 
L__masterloop339:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop15
;Yash BE project.c,88 :: 		D1[i]=3;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,89 :: 		}
	GOTO        L_masterloop16
L_masterloop15:
;Yash BE project.c,90 :: 		else if(Display1[i]==52)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop340
	MOVLW       52
	XORWF       R1, 0 
L__masterloop340:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop17
;Yash BE project.c,92 :: 		D1[i]=4;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,93 :: 		}
	GOTO        L_masterloop18
L_masterloop17:
;Yash BE project.c,94 :: 		else if(Display1[i]==53)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop341
	MOVLW       53
	XORWF       R1, 0 
L__masterloop341:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop19
;Yash BE project.c,96 :: 		D1[i]=5;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,97 :: 		}
	GOTO        L_masterloop20
L_masterloop19:
;Yash BE project.c,98 :: 		else if(Display1[i]==54)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop342
	MOVLW       54
	XORWF       R1, 0 
L__masterloop342:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop21
;Yash BE project.c,100 :: 		D1[i]=6;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,101 :: 		}
	GOTO        L_masterloop22
L_masterloop21:
;Yash BE project.c,102 :: 		else if(Display1[i]==55)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop343
	MOVLW       55
	XORWF       R1, 0 
L__masterloop343:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop23
;Yash BE project.c,104 :: 		D1[i]=7;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       7
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,105 :: 		}
	GOTO        L_masterloop24
L_masterloop23:
;Yash BE project.c,106 :: 		else if(Display1[i]==56)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop344
	MOVLW       56
	XORWF       R1, 0 
L__masterloop344:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop25
;Yash BE project.c,108 :: 		D1[i]=8;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       8
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,109 :: 		}
	GOTO        L_masterloop26
L_masterloop25:
;Yash BE project.c,110 :: 		else if(Display1[i]==57)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop345
	MOVLW       57
	XORWF       R1, 0 
L__masterloop345:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop27
;Yash BE project.c,112 :: 		D1[i]=9;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D1_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D1_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       9
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,113 :: 		}
L_masterloop27:
L_masterloop26:
L_masterloop24:
L_masterloop22:
L_masterloop20:
L_masterloop18:
L_masterloop16:
L_masterloop14:
L_masterloop12:
L_masterloop10:
;Yash BE project.c,72 :: 		for(i=0;i<4;i++)
	INFSNZ      masterloop_i_L0+0, 1 
	INCF        masterloop_i_L0+1, 1 
;Yash BE project.c,114 :: 		}
	GOTO        L_masterloop6
L_masterloop7:
;Yash BE project.c,119 :: 		ip2 = ADC_Read(1)*scaler2;
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVF        _scaler2+0, 0 
	MOVWF       R4 
	MOVF        _scaler2+1, 0 
	MOVWF       R5 
	MOVF        _scaler2+2, 0 
	MOVWF       R6 
	MOVF        _scaler2+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_ip2_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_ip2_L0+1 
;Yash BE project.c,121 :: 		vDisp2[0] = ip2 / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp2_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp2_L0+1 
;Yash BE project.c,122 :: 		vDisp2[1] = (ip2 / 100) % 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip2_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip2_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp2_L0+2 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp2_L0+3 
;Yash BE project.c,123 :: 		vDisp2[2] = (ip2 % 100) / 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip2_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip2_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp2_L0+4 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp2_L0+5 
;Yash BE project.c,124 :: 		vDisp2[3] = ip2 % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip2_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip2_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp2_L0+6 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp2_L0+7 
;Yash BE project.c,125 :: 		Display2[0] = vDisp2[0] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp2_L0+0, 0 
	MOVWF       masterloop_Display2_L0+0 
	MOVLW       0
	ADDWFC      masterloop_vDisp2_L0+1, 0 
	MOVWF       masterloop_Display2_L0+1 
;Yash BE project.c,126 :: 		Display2[1] = vDisp2[1] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp2_L0+2, 0 
	MOVWF       masterloop_Display2_L0+2 
	MOVLW       0
	ADDWFC      masterloop_vDisp2_L0+3, 0 
	MOVWF       masterloop_Display2_L0+3 
;Yash BE project.c,127 :: 		Display2[2] = vDisp2[2] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp2_L0+4, 0 
	MOVWF       masterloop_Display2_L0+4 
	MOVLW       0
	ADDWFC      masterloop_vDisp2_L0+5, 0 
	MOVWF       masterloop_Display2_L0+5 
;Yash BE project.c,128 :: 		Display2[3] = vDisp2[3] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       masterloop_Display2_L0+6 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       masterloop_Display2_L0+7 
;Yash BE project.c,130 :: 		for(i=0;i<4;i++)
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
L_masterloop28:
	MOVLW       128
	XORWF       masterloop_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop346
	MOVLW       4
	SUBWF       masterloop_i_L0+0, 0 
L__masterloop346:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop29
;Yash BE project.c,132 :: 		if(Display2[i]==48)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop347
	MOVLW       48
	XORWF       R1, 0 
L__masterloop347:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop31
;Yash BE project.c,134 :: 		D2[i]=0;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Yash BE project.c,135 :: 		}
	GOTO        L_masterloop32
L_masterloop31:
;Yash BE project.c,136 :: 		else if(Display2[i]==49)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop348
	MOVLW       49
	XORWF       R1, 0 
L__masterloop348:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop33
;Yash BE project.c,138 :: 		D2[i]=1;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,139 :: 		}
	GOTO        L_masterloop34
L_masterloop33:
;Yash BE project.c,140 :: 		else if(Display2[i]==50)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop349
	MOVLW       50
	XORWF       R1, 0 
L__masterloop349:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop35
;Yash BE project.c,142 :: 		D2[i]=2;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,143 :: 		}
	GOTO        L_masterloop36
L_masterloop35:
;Yash BE project.c,144 :: 		else if(Display2[i]==51)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop350
	MOVLW       51
	XORWF       R1, 0 
L__masterloop350:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop37
;Yash BE project.c,146 :: 		D2[i]=3;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,147 :: 		}
	GOTO        L_masterloop38
L_masterloop37:
;Yash BE project.c,148 :: 		else if(Display2[i]==52)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop351
	MOVLW       52
	XORWF       R1, 0 
L__masterloop351:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop39
;Yash BE project.c,150 :: 		D2[i]=4;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,151 :: 		}
	GOTO        L_masterloop40
L_masterloop39:
;Yash BE project.c,152 :: 		else if(Display2[i]==53)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop352
	MOVLW       53
	XORWF       R1, 0 
L__masterloop352:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop41
;Yash BE project.c,154 :: 		D2[i]=5;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,155 :: 		}
	GOTO        L_masterloop42
L_masterloop41:
;Yash BE project.c,156 :: 		else if(Display2[i]==54)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop353
	MOVLW       54
	XORWF       R1, 0 
L__masterloop353:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop43
;Yash BE project.c,158 :: 		D2[i]=6;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,159 :: 		}
	GOTO        L_masterloop44
L_masterloop43:
;Yash BE project.c,160 :: 		else if(Display2[i]==55)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop354
	MOVLW       55
	XORWF       R1, 0 
L__masterloop354:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop45
;Yash BE project.c,162 :: 		D2[i]=7;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       7
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,163 :: 		}
	GOTO        L_masterloop46
L_masterloop45:
;Yash BE project.c,164 :: 		else if(Display2[i]==56)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop355
	MOVLW       56
	XORWF       R1, 0 
L__masterloop355:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop47
;Yash BE project.c,166 :: 		D2[i]=8;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       8
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,167 :: 		}
	GOTO        L_masterloop48
L_masterloop47:
;Yash BE project.c,168 :: 		else if(Display2[i]==57)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop356
	MOVLW       57
	XORWF       R1, 0 
L__masterloop356:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop49
;Yash BE project.c,170 :: 		D2[i]=9;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D2_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D2_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       9
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,171 :: 		}
L_masterloop49:
L_masterloop48:
L_masterloop46:
L_masterloop44:
L_masterloop42:
L_masterloop40:
L_masterloop38:
L_masterloop36:
L_masterloop34:
L_masterloop32:
;Yash BE project.c,130 :: 		for(i=0;i<4;i++)
	INFSNZ      masterloop_i_L0+0, 1 
	INCF        masterloop_i_L0+1, 1 
;Yash BE project.c,172 :: 		}
	GOTO        L_masterloop28
L_masterloop29:
;Yash BE project.c,176 :: 		ip3 = ADC_Read(2)*scaler3;
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVF        _scaler3+0, 0 
	MOVWF       R4 
	MOVF        _scaler3+1, 0 
	MOVWF       R5 
	MOVF        _scaler3+2, 0 
	MOVWF       R6 
	MOVF        _scaler3+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_ip3_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_ip3_L0+1 
;Yash BE project.c,178 :: 		vDisp3[0] = ip3 / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp3_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp3_L0+1 
;Yash BE project.c,179 :: 		vDisp3[1] = (ip3 / 100) % 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip3_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip3_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp3_L0+2 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp3_L0+3 
;Yash BE project.c,180 :: 		vDisp3[2] = (ip3 % 100) / 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip3_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip3_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp3_L0+4 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp3_L0+5 
;Yash BE project.c,181 :: 		vDisp3[3] = ip3 % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip3_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip3_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp3_L0+6 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp3_L0+7 
;Yash BE project.c,182 :: 		Display3[0] = vDisp3[0] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp3_L0+0, 0 
	MOVWF       masterloop_Display3_L0+0 
	MOVLW       0
	ADDWFC      masterloop_vDisp3_L0+1, 0 
	MOVWF       masterloop_Display3_L0+1 
;Yash BE project.c,183 :: 		Display3[1] = vDisp3[1] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp3_L0+2, 0 
	MOVWF       masterloop_Display3_L0+2 
	MOVLW       0
	ADDWFC      masterloop_vDisp3_L0+3, 0 
	MOVWF       masterloop_Display3_L0+3 
;Yash BE project.c,184 :: 		Display3[2] = vDisp3[2] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp3_L0+4, 0 
	MOVWF       masterloop_Display3_L0+4 
	MOVLW       0
	ADDWFC      masterloop_vDisp3_L0+5, 0 
	MOVWF       masterloop_Display3_L0+5 
;Yash BE project.c,185 :: 		Display3[3] = vDisp3[3] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       masterloop_Display3_L0+6 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       masterloop_Display3_L0+7 
;Yash BE project.c,187 :: 		for(i=0;i<4;i++)
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
L_masterloop50:
	MOVLW       128
	XORWF       masterloop_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop357
	MOVLW       4
	SUBWF       masterloop_i_L0+0, 0 
L__masterloop357:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop51
;Yash BE project.c,189 :: 		if(Display3[i]==48)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop358
	MOVLW       48
	XORWF       R1, 0 
L__masterloop358:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop53
;Yash BE project.c,191 :: 		D3[i]=0;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Yash BE project.c,192 :: 		}
	GOTO        L_masterloop54
L_masterloop53:
;Yash BE project.c,193 :: 		else if(Display3[i]==49)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop359
	MOVLW       49
	XORWF       R1, 0 
L__masterloop359:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop55
;Yash BE project.c,195 :: 		D3[i]=1;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,196 :: 		}
	GOTO        L_masterloop56
L_masterloop55:
;Yash BE project.c,197 :: 		else if(Display3[i]==50)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop360
	MOVLW       50
	XORWF       R1, 0 
L__masterloop360:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop57
;Yash BE project.c,199 :: 		D3[i]=2;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,200 :: 		}
	GOTO        L_masterloop58
L_masterloop57:
;Yash BE project.c,201 :: 		else if(Display3[i]==51)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop361
	MOVLW       51
	XORWF       R1, 0 
L__masterloop361:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop59
;Yash BE project.c,203 :: 		D3[i]=3;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,204 :: 		}
	GOTO        L_masterloop60
L_masterloop59:
;Yash BE project.c,205 :: 		else if(Display3[i]==52)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop362
	MOVLW       52
	XORWF       R1, 0 
L__masterloop362:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop61
;Yash BE project.c,207 :: 		D3[i]=4;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,208 :: 		}
	GOTO        L_masterloop62
L_masterloop61:
;Yash BE project.c,209 :: 		else if(Display3[i]==53)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop363
	MOVLW       53
	XORWF       R1, 0 
L__masterloop363:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop63
;Yash BE project.c,211 :: 		D3[i]=5;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,212 :: 		}
	GOTO        L_masterloop64
L_masterloop63:
;Yash BE project.c,213 :: 		else if(Display3[i]==54)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop364
	MOVLW       54
	XORWF       R1, 0 
L__masterloop364:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop65
;Yash BE project.c,215 :: 		D3[i]=6;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,216 :: 		}
	GOTO        L_masterloop66
L_masterloop65:
;Yash BE project.c,217 :: 		else if(Display3[i]==55)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop365
	MOVLW       55
	XORWF       R1, 0 
L__masterloop365:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop67
;Yash BE project.c,219 :: 		D3[i]=7;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       7
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,220 :: 		}
	GOTO        L_masterloop68
L_masterloop67:
;Yash BE project.c,221 :: 		else if(Display3[i]==56)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop366
	MOVLW       56
	XORWF       R1, 0 
L__masterloop366:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop69
;Yash BE project.c,223 :: 		D3[i]=8;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       8
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,224 :: 		}
	GOTO        L_masterloop70
L_masterloop69:
;Yash BE project.c,225 :: 		else if(Display3[i]==57)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop367
	MOVLW       57
	XORWF       R1, 0 
L__masterloop367:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop71
;Yash BE project.c,227 :: 		D3[i]=9;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D3_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D3_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       9
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,228 :: 		}
L_masterloop71:
L_masterloop70:
L_masterloop68:
L_masterloop66:
L_masterloop64:
L_masterloop62:
L_masterloop60:
L_masterloop58:
L_masterloop56:
L_masterloop54:
;Yash BE project.c,187 :: 		for(i=0;i<4;i++)
	INFSNZ      masterloop_i_L0+0, 1 
	INCF        masterloop_i_L0+1, 1 
;Yash BE project.c,229 :: 		}
	GOTO        L_masterloop50
L_masterloop51:
;Yash BE project.c,233 :: 		ip4 = ADC_Read(3)*scaler4;
	MOVLW       3
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVF        _scaler4+0, 0 
	MOVWF       R4 
	MOVF        _scaler4+1, 0 
	MOVWF       R5 
	MOVF        _scaler4+2, 0 
	MOVWF       R6 
	MOVF        _scaler4+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_ip4_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_ip4_L0+1 
;Yash BE project.c,235 :: 		vDisp4[0] = ip4 / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp4_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp4_L0+1 
;Yash BE project.c,236 :: 		vDisp4[1] = (ip4 / 100) % 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip4_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip4_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp4_L0+2 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp4_L0+3 
;Yash BE project.c,237 :: 		vDisp4[2] = (ip4 % 100) / 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip4_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip4_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp4_L0+4 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp4_L0+5 
;Yash BE project.c,238 :: 		vDisp4[3] = ip4 % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip4_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip4_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp4_L0+6 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp4_L0+7 
;Yash BE project.c,239 :: 		Display4[0] = vDisp4[0] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp4_L0+0, 0 
	MOVWF       masterloop_Display4_L0+0 
	MOVLW       0
	ADDWFC      masterloop_vDisp4_L0+1, 0 
	MOVWF       masterloop_Display4_L0+1 
;Yash BE project.c,240 :: 		Display4[1] = vDisp4[1] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp4_L0+2, 0 
	MOVWF       masterloop_Display4_L0+2 
	MOVLW       0
	ADDWFC      masterloop_vDisp4_L0+3, 0 
	MOVWF       masterloop_Display4_L0+3 
;Yash BE project.c,241 :: 		Display4[2] = vDisp4[2] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp4_L0+4, 0 
	MOVWF       masterloop_Display4_L0+4 
	MOVLW       0
	ADDWFC      masterloop_vDisp4_L0+5, 0 
	MOVWF       masterloop_Display4_L0+5 
;Yash BE project.c,242 :: 		Display4[3] = vDisp4[3] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       masterloop_Display4_L0+6 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       masterloop_Display4_L0+7 
;Yash BE project.c,244 :: 		for(i=0;i<4;i++)
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
L_masterloop72:
	MOVLW       128
	XORWF       masterloop_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop368
	MOVLW       4
	SUBWF       masterloop_i_L0+0, 0 
L__masterloop368:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop73
;Yash BE project.c,246 :: 		if(Display4[i]==48)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop369
	MOVLW       48
	XORWF       R1, 0 
L__masterloop369:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop75
;Yash BE project.c,248 :: 		D4[i]=0;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Yash BE project.c,249 :: 		}
	GOTO        L_masterloop76
L_masterloop75:
;Yash BE project.c,250 :: 		else if(Display4[i]==49)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop370
	MOVLW       49
	XORWF       R1, 0 
L__masterloop370:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop77
;Yash BE project.c,252 :: 		D4[i]=1;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,253 :: 		}
	GOTO        L_masterloop78
L_masterloop77:
;Yash BE project.c,254 :: 		else if(Display4[i]==50)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop371
	MOVLW       50
	XORWF       R1, 0 
L__masterloop371:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop79
;Yash BE project.c,256 :: 		D4[i]=2;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,257 :: 		}
	GOTO        L_masterloop80
L_masterloop79:
;Yash BE project.c,258 :: 		else if(Display4[i]==51)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop372
	MOVLW       51
	XORWF       R1, 0 
L__masterloop372:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop81
;Yash BE project.c,260 :: 		D4[i]=3;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,261 :: 		}
	GOTO        L_masterloop82
L_masterloop81:
;Yash BE project.c,262 :: 		else if(Display4[i]==52)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop373
	MOVLW       52
	XORWF       R1, 0 
L__masterloop373:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop83
;Yash BE project.c,264 :: 		D4[i]=4;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,265 :: 		}
	GOTO        L_masterloop84
L_masterloop83:
;Yash BE project.c,266 :: 		else if(Display4[i]==53)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop374
	MOVLW       53
	XORWF       R1, 0 
L__masterloop374:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop85
;Yash BE project.c,268 :: 		D4[i]=5;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,269 :: 		}
	GOTO        L_masterloop86
L_masterloop85:
;Yash BE project.c,270 :: 		else if(Display4[i]==54)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop375
	MOVLW       54
	XORWF       R1, 0 
L__masterloop375:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop87
;Yash BE project.c,272 :: 		D4[i]=6;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,273 :: 		}
	GOTO        L_masterloop88
L_masterloop87:
;Yash BE project.c,274 :: 		else if(Display4[i]==55)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop376
	MOVLW       55
	XORWF       R1, 0 
L__masterloop376:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop89
;Yash BE project.c,276 :: 		D4[i]=7;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       7
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,277 :: 		}
	GOTO        L_masterloop90
L_masterloop89:
;Yash BE project.c,278 :: 		else if(Display4[i]==56)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop377
	MOVLW       56
	XORWF       R1, 0 
L__masterloop377:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop91
;Yash BE project.c,280 :: 		D4[i]=8;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       8
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,281 :: 		}
	GOTO        L_masterloop92
L_masterloop91:
;Yash BE project.c,282 :: 		else if(Display4[i]==57)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop378
	MOVLW       57
	XORWF       R1, 0 
L__masterloop378:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop93
;Yash BE project.c,284 :: 		D4[i]=9;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D4_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D4_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       9
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,285 :: 		}
L_masterloop93:
L_masterloop92:
L_masterloop90:
L_masterloop88:
L_masterloop86:
L_masterloop84:
L_masterloop82:
L_masterloop80:
L_masterloop78:
L_masterloop76:
;Yash BE project.c,244 :: 		for(i=0;i<4;i++)
	INFSNZ      masterloop_i_L0+0, 1 
	INCF        masterloop_i_L0+1, 1 
;Yash BE project.c,286 :: 		}
	GOTO        L_masterloop72
L_masterloop73:
;Yash BE project.c,291 :: 		ip5 = ADC_Read(4)*scaler5;
	MOVLW       4
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVF        _scaler5+0, 0 
	MOVWF       R4 
	MOVF        _scaler5+1, 0 
	MOVWF       R5 
	MOVF        _scaler5+2, 0 
	MOVWF       R6 
	MOVF        _scaler5+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_ip5_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_ip5_L0+1 
;Yash BE project.c,293 :: 		vDisp5[0] = ip5 / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp5_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp5_L0+1 
;Yash BE project.c,294 :: 		vDisp5[1] = (ip5 / 100) % 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip5_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip5_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp5_L0+2 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp5_L0+3 
;Yash BE project.c,295 :: 		vDisp5[2] = (ip5 % 100) / 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip5_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip5_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp5_L0+4 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp5_L0+5 
;Yash BE project.c,296 :: 		vDisp5[3] = ip5 % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip5_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip5_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp5_L0+6 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp5_L0+7 
;Yash BE project.c,297 :: 		Display5[0] = vDisp5[0] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp5_L0+0, 0 
	MOVWF       masterloop_Display5_L0+0 
	MOVLW       0
	ADDWFC      masterloop_vDisp5_L0+1, 0 
	MOVWF       masterloop_Display5_L0+1 
;Yash BE project.c,298 :: 		Display5[1] = vDisp5[1] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp5_L0+2, 0 
	MOVWF       masterloop_Display5_L0+2 
	MOVLW       0
	ADDWFC      masterloop_vDisp5_L0+3, 0 
	MOVWF       masterloop_Display5_L0+3 
;Yash BE project.c,299 :: 		Display5[2] = vDisp5[2] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp5_L0+4, 0 
	MOVWF       masterloop_Display5_L0+4 
	MOVLW       0
	ADDWFC      masterloop_vDisp5_L0+5, 0 
	MOVWF       masterloop_Display5_L0+5 
;Yash BE project.c,300 :: 		Display5[3] = vDisp5[3] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       masterloop_Display5_L0+6 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       masterloop_Display5_L0+7 
;Yash BE project.c,302 :: 		for(i=0;i<4;i++)
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
L_masterloop94:
	MOVLW       128
	XORWF       masterloop_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop379
	MOVLW       4
	SUBWF       masterloop_i_L0+0, 0 
L__masterloop379:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop95
;Yash BE project.c,304 :: 		if(Display5[i]==48)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop380
	MOVLW       48
	XORWF       R1, 0 
L__masterloop380:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop97
;Yash BE project.c,306 :: 		D5[i]=0;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Yash BE project.c,307 :: 		}
	GOTO        L_masterloop98
L_masterloop97:
;Yash BE project.c,308 :: 		else if(Display5[i]==49)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop381
	MOVLW       49
	XORWF       R1, 0 
L__masterloop381:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop99
;Yash BE project.c,310 :: 		D5[i]=1;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,311 :: 		}
	GOTO        L_masterloop100
L_masterloop99:
;Yash BE project.c,312 :: 		else if(Display5[i]==50)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop382
	MOVLW       50
	XORWF       R1, 0 
L__masterloop382:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop101
;Yash BE project.c,314 :: 		D5[i]=2;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,315 :: 		}
	GOTO        L_masterloop102
L_masterloop101:
;Yash BE project.c,316 :: 		else if(Display5[i]==51)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop383
	MOVLW       51
	XORWF       R1, 0 
L__masterloop383:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop103
;Yash BE project.c,318 :: 		D5[i]=3;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,319 :: 		}
	GOTO        L_masterloop104
L_masterloop103:
;Yash BE project.c,320 :: 		else if(Display5[i]==52)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop384
	MOVLW       52
	XORWF       R1, 0 
L__masterloop384:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop105
;Yash BE project.c,322 :: 		D5[i]=4;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,323 :: 		}
	GOTO        L_masterloop106
L_masterloop105:
;Yash BE project.c,324 :: 		else if(Display5[i]==53)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop385
	MOVLW       53
	XORWF       R1, 0 
L__masterloop385:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop107
;Yash BE project.c,326 :: 		D5[i]=5;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,327 :: 		}
	GOTO        L_masterloop108
L_masterloop107:
;Yash BE project.c,328 :: 		else if(Display5[i]==54)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop386
	MOVLW       54
	XORWF       R1, 0 
L__masterloop386:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop109
;Yash BE project.c,330 :: 		D5[i]=6;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,331 :: 		}
	GOTO        L_masterloop110
L_masterloop109:
;Yash BE project.c,332 :: 		else if(Display5[i]==55)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop387
	MOVLW       55
	XORWF       R1, 0 
L__masterloop387:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop111
;Yash BE project.c,334 :: 		D5[i]=7;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       7
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,335 :: 		}
	GOTO        L_masterloop112
L_masterloop111:
;Yash BE project.c,336 :: 		else if(Display5[i]==56)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop388
	MOVLW       56
	XORWF       R1, 0 
L__masterloop388:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop113
;Yash BE project.c,338 :: 		D5[i]=8;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       8
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,339 :: 		}
	GOTO        L_masterloop114
L_masterloop113:
;Yash BE project.c,340 :: 		else if(Display5[i]==57)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop389
	MOVLW       57
	XORWF       R1, 0 
L__masterloop389:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop115
;Yash BE project.c,342 :: 		D5[i]=9;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D5_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D5_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       9
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,343 :: 		}
L_masterloop115:
L_masterloop114:
L_masterloop112:
L_masterloop110:
L_masterloop108:
L_masterloop106:
L_masterloop104:
L_masterloop102:
L_masterloop100:
L_masterloop98:
;Yash BE project.c,302 :: 		for(i=0;i<4;i++)
	INFSNZ      masterloop_i_L0+0, 1 
	INCF        masterloop_i_L0+1, 1 
;Yash BE project.c,344 :: 		}
	GOTO        L_masterloop94
L_masterloop95:
;Yash BE project.c,350 :: 		ip6 = ADC_Read(5)*scaler6;
	MOVLW       5
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVF        _scaler6+0, 0 
	MOVWF       R4 
	MOVF        _scaler6+1, 0 
	MOVWF       R5 
	MOVF        _scaler6+2, 0 
	MOVWF       R6 
	MOVF        _scaler6+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_ip6_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_ip6_L0+1 
;Yash BE project.c,352 :: 		vDisp6[0] = ip6 / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp6_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp6_L0+1 
;Yash BE project.c,353 :: 		vDisp6[1] = (ip6 / 100) % 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip6_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip6_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp6_L0+2 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp6_L0+3 
;Yash BE project.c,354 :: 		vDisp6[2] = (ip6 % 100) / 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip6_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip6_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp6_L0+4 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp6_L0+5 
;Yash BE project.c,355 :: 		vDisp6[3] = ip6 % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip6_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip6_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp6_L0+6 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp6_L0+7 
;Yash BE project.c,356 :: 		Display6[0] = vDisp6[0] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp6_L0+0, 0 
	MOVWF       masterloop_Display6_L0+0 
	MOVLW       0
	ADDWFC      masterloop_vDisp6_L0+1, 0 
	MOVWF       masterloop_Display6_L0+1 
;Yash BE project.c,357 :: 		Display6[1] = vDisp6[1] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp6_L0+2, 0 
	MOVWF       masterloop_Display6_L0+2 
	MOVLW       0
	ADDWFC      masterloop_vDisp6_L0+3, 0 
	MOVWF       masterloop_Display6_L0+3 
;Yash BE project.c,358 :: 		Display6[2] = vDisp6[2] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp6_L0+4, 0 
	MOVWF       masterloop_Display6_L0+4 
	MOVLW       0
	ADDWFC      masterloop_vDisp6_L0+5, 0 
	MOVWF       masterloop_Display6_L0+5 
;Yash BE project.c,359 :: 		Display6[3] = vDisp6[3] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       masterloop_Display6_L0+6 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       masterloop_Display6_L0+7 
;Yash BE project.c,361 :: 		for(i=0;i<4;i++)
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
L_masterloop116:
	MOVLW       128
	XORWF       masterloop_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop390
	MOVLW       4
	SUBWF       masterloop_i_L0+0, 0 
L__masterloop390:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop117
;Yash BE project.c,363 :: 		if(Display6[i]==48)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop391
	MOVLW       48
	XORWF       R1, 0 
L__masterloop391:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop119
;Yash BE project.c,365 :: 		D6[i]=0;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Yash BE project.c,366 :: 		}
	GOTO        L_masterloop120
L_masterloop119:
;Yash BE project.c,367 :: 		else if(Display6[i]==49)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop392
	MOVLW       49
	XORWF       R1, 0 
L__masterloop392:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop121
;Yash BE project.c,369 :: 		D6[i]=1;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,370 :: 		}
	GOTO        L_masterloop122
L_masterloop121:
;Yash BE project.c,371 :: 		else if(Display6[i]==50)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop393
	MOVLW       50
	XORWF       R1, 0 
L__masterloop393:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop123
;Yash BE project.c,373 :: 		D6[i]=2;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,374 :: 		}
	GOTO        L_masterloop124
L_masterloop123:
;Yash BE project.c,375 :: 		else if(Display6[i]==51)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop394
	MOVLW       51
	XORWF       R1, 0 
L__masterloop394:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop125
;Yash BE project.c,377 :: 		D6[i]=3;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,378 :: 		}
	GOTO        L_masterloop126
L_masterloop125:
;Yash BE project.c,379 :: 		else if(Display6[i]==52)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop395
	MOVLW       52
	XORWF       R1, 0 
L__masterloop395:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop127
;Yash BE project.c,381 :: 		D6[i]=4;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,382 :: 		}
	GOTO        L_masterloop128
L_masterloop127:
;Yash BE project.c,383 :: 		else if(Display6[i]==53)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop396
	MOVLW       53
	XORWF       R1, 0 
L__masterloop396:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop129
;Yash BE project.c,385 :: 		D6[i]=5;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,386 :: 		}
	GOTO        L_masterloop130
L_masterloop129:
;Yash BE project.c,387 :: 		else if(Display6[i]==54)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop397
	MOVLW       54
	XORWF       R1, 0 
L__masterloop397:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop131
;Yash BE project.c,389 :: 		D6[i]=6;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,390 :: 		}
	GOTO        L_masterloop132
L_masterloop131:
;Yash BE project.c,391 :: 		else if(Display6[i]==55)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop398
	MOVLW       55
	XORWF       R1, 0 
L__masterloop398:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop133
;Yash BE project.c,393 :: 		D6[i]=7;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       7
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,394 :: 		}
	GOTO        L_masterloop134
L_masterloop133:
;Yash BE project.c,395 :: 		else if(Display6[i]==56)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop399
	MOVLW       56
	XORWF       R1, 0 
L__masterloop399:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop135
;Yash BE project.c,397 :: 		D6[i]=8;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       8
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,398 :: 		}
	GOTO        L_masterloop136
L_masterloop135:
;Yash BE project.c,399 :: 		else if(Display6[i]==57)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop400
	MOVLW       57
	XORWF       R1, 0 
L__masterloop400:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop137
;Yash BE project.c,401 :: 		D6[i]=9;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D6_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D6_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       9
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,402 :: 		}
L_masterloop137:
L_masterloop136:
L_masterloop134:
L_masterloop132:
L_masterloop130:
L_masterloop128:
L_masterloop126:
L_masterloop124:
L_masterloop122:
L_masterloop120:
;Yash BE project.c,361 :: 		for(i=0;i<4;i++)
	INFSNZ      masterloop_i_L0+0, 1 
	INCF        masterloop_i_L0+1, 1 
;Yash BE project.c,403 :: 		}
	GOTO        L_masterloop116
L_masterloop117:
;Yash BE project.c,408 :: 		ip7 = ADC_Read(6);
	MOVLW       6
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_ip7_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_ip7_L0+1 
;Yash BE project.c,410 :: 		vDisp7[0] = ip7 / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp7_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp7_L0+1 
;Yash BE project.c,411 :: 		vDisp7[1] = (ip7 / 100) % 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip7_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip7_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp7_L0+2 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp7_L0+3 
;Yash BE project.c,412 :: 		vDisp7[2] = (ip7 % 100) / 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip7_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip7_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp7_L0+4 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp7_L0+5 
;Yash BE project.c,413 :: 		vDisp7[3] = ip7 % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip7_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip7_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp7_L0+6 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp7_L0+7 
;Yash BE project.c,414 :: 		Display7[0] = vDisp7[0] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp7_L0+0, 0 
	MOVWF       masterloop_Display7_L0+0 
	MOVLW       0
	ADDWFC      masterloop_vDisp7_L0+1, 0 
	MOVWF       masterloop_Display7_L0+1 
;Yash BE project.c,415 :: 		Display7[1] = vDisp7[1] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp7_L0+2, 0 
	MOVWF       masterloop_Display7_L0+2 
	MOVLW       0
	ADDWFC      masterloop_vDisp7_L0+3, 0 
	MOVWF       masterloop_Display7_L0+3 
;Yash BE project.c,416 :: 		Display7[2] = vDisp7[2] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp7_L0+4, 0 
	MOVWF       masterloop_Display7_L0+4 
	MOVLW       0
	ADDWFC      masterloop_vDisp7_L0+5, 0 
	MOVWF       masterloop_Display7_L0+5 
;Yash BE project.c,417 :: 		Display7[3] = vDisp7[3] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       masterloop_Display7_L0+6 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       masterloop_Display7_L0+7 
;Yash BE project.c,419 :: 		for(i=0;i<4;i++)
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
L_masterloop138:
	MOVLW       128
	XORWF       masterloop_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop401
	MOVLW       4
	SUBWF       masterloop_i_L0+0, 0 
L__masterloop401:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop139
;Yash BE project.c,421 :: 		if(Display7[i]==48)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop402
	MOVLW       48
	XORWF       R1, 0 
L__masterloop402:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop141
;Yash BE project.c,423 :: 		D7[i]=0;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Yash BE project.c,424 :: 		}
	GOTO        L_masterloop142
L_masterloop141:
;Yash BE project.c,425 :: 		else if(Display7[i]==49)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop403
	MOVLW       49
	XORWF       R1, 0 
L__masterloop403:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop143
;Yash BE project.c,427 :: 		D7[i]=1;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,428 :: 		}
	GOTO        L_masterloop144
L_masterloop143:
;Yash BE project.c,429 :: 		else if(Display7[i]==50)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop404
	MOVLW       50
	XORWF       R1, 0 
L__masterloop404:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop145
;Yash BE project.c,431 :: 		D7[i]=2;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,432 :: 		}
	GOTO        L_masterloop146
L_masterloop145:
;Yash BE project.c,433 :: 		else if(Display7[i]==51)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop405
	MOVLW       51
	XORWF       R1, 0 
L__masterloop405:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop147
;Yash BE project.c,435 :: 		D7[i]=3;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,436 :: 		}
	GOTO        L_masterloop148
L_masterloop147:
;Yash BE project.c,437 :: 		else if(Display7[i]==52)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop406
	MOVLW       52
	XORWF       R1, 0 
L__masterloop406:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop149
;Yash BE project.c,439 :: 		D7[i]=4;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,440 :: 		}
	GOTO        L_masterloop150
L_masterloop149:
;Yash BE project.c,441 :: 		else if(Display7[i]==53)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop407
	MOVLW       53
	XORWF       R1, 0 
L__masterloop407:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop151
;Yash BE project.c,443 :: 		D7[i]=5;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,444 :: 		}
	GOTO        L_masterloop152
L_masterloop151:
;Yash BE project.c,445 :: 		else if(Display7[i]==54)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop408
	MOVLW       54
	XORWF       R1, 0 
L__masterloop408:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop153
;Yash BE project.c,447 :: 		D7[i]=6;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,448 :: 		}
	GOTO        L_masterloop154
L_masterloop153:
;Yash BE project.c,449 :: 		else if(Display7[i]==55)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop409
	MOVLW       55
	XORWF       R1, 0 
L__masterloop409:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop155
;Yash BE project.c,451 :: 		D7[i]=7;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       7
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,452 :: 		}
	GOTO        L_masterloop156
L_masterloop155:
;Yash BE project.c,453 :: 		else if(Display7[i]==56)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop410
	MOVLW       56
	XORWF       R1, 0 
L__masterloop410:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop157
;Yash BE project.c,455 :: 		D7[i]=8;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       8
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,456 :: 		}
	GOTO        L_masterloop158
L_masterloop157:
;Yash BE project.c,457 :: 		else if(Display7[i]==57)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop411
	MOVLW       57
	XORWF       R1, 0 
L__masterloop411:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop159
;Yash BE project.c,459 :: 		D7[i]=9;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D7_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D7_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       9
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,460 :: 		}
L_masterloop159:
L_masterloop158:
L_masterloop156:
L_masterloop154:
L_masterloop152:
L_masterloop150:
L_masterloop148:
L_masterloop146:
L_masterloop144:
L_masterloop142:
;Yash BE project.c,419 :: 		for(i=0;i<4;i++)
	INFSNZ      masterloop_i_L0+0, 1 
	INCF        masterloop_i_L0+1, 1 
;Yash BE project.c,461 :: 		}
	GOTO        L_masterloop138
L_masterloop139:
;Yash BE project.c,465 :: 		ip8 = ADC_Read(7);
	MOVLW       7
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_ip8_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_ip8_L0+1 
;Yash BE project.c,467 :: 		vDisp8[0] = ip8 / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp8_L0+0 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp8_L0+1 
;Yash BE project.c,468 :: 		vDisp8[1] = (ip8 / 100) % 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip8_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip8_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp8_L0+2 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp8_L0+3 
;Yash BE project.c,469 :: 		vDisp8[2] = (ip8 % 100) / 10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip8_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip8_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp8_L0+4 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp8_L0+5 
;Yash BE project.c,470 :: 		vDisp8[3] = ip8 % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        masterloop_ip8_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_ip8_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       masterloop_vDisp8_L0+6 
	MOVF        R1, 0 
	MOVWF       masterloop_vDisp8_L0+7 
;Yash BE project.c,471 :: 		Display8[0] = vDisp8[0] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp8_L0+0, 0 
	MOVWF       masterloop_Display8_L0+0 
	MOVLW       0
	ADDWFC      masterloop_vDisp8_L0+1, 0 
	MOVWF       masterloop_Display8_L0+1 
;Yash BE project.c,472 :: 		Display8[1] = vDisp8[1] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp8_L0+2, 0 
	MOVWF       masterloop_Display8_L0+2 
	MOVLW       0
	ADDWFC      masterloop_vDisp8_L0+3, 0 
	MOVWF       masterloop_Display8_L0+3 
;Yash BE project.c,473 :: 		Display8[2] = vDisp8[2] + 48;
	MOVLW       48
	ADDWF       masterloop_vDisp8_L0+4, 0 
	MOVWF       masterloop_Display8_L0+4 
	MOVLW       0
	ADDWFC      masterloop_vDisp8_L0+5, 0 
	MOVWF       masterloop_Display8_L0+5 
;Yash BE project.c,474 :: 		Display8[3] = vDisp8[3] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       masterloop_Display8_L0+6 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       masterloop_Display8_L0+7 
;Yash BE project.c,476 :: 		for(i=0;i<4;i++)
	CLRF        masterloop_i_L0+0 
	CLRF        masterloop_i_L0+1 
L_masterloop160:
	MOVLW       128
	XORWF       masterloop_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop412
	MOVLW       4
	SUBWF       masterloop_i_L0+0, 0 
L__masterloop412:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop161
;Yash BE project.c,478 :: 		if(Display8[i]==48)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop413
	MOVLW       48
	XORWF       R1, 0 
L__masterloop413:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop163
;Yash BE project.c,480 :: 		D8[i]=0;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Yash BE project.c,481 :: 		}
	GOTO        L_masterloop164
L_masterloop163:
;Yash BE project.c,482 :: 		else if(Display8[i]==49)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop414
	MOVLW       49
	XORWF       R1, 0 
L__masterloop414:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop165
;Yash BE project.c,484 :: 		D8[i]=1;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,485 :: 		}
	GOTO        L_masterloop166
L_masterloop165:
;Yash BE project.c,486 :: 		else if(Display8[i]==50)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop415
	MOVLW       50
	XORWF       R1, 0 
L__masterloop415:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop167
;Yash BE project.c,488 :: 		D8[i]=2;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,489 :: 		}
	GOTO        L_masterloop168
L_masterloop167:
;Yash BE project.c,490 :: 		else if(Display8[i]==51)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop416
	MOVLW       51
	XORWF       R1, 0 
L__masterloop416:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop169
;Yash BE project.c,492 :: 		D8[i]=3;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,493 :: 		}
	GOTO        L_masterloop170
L_masterloop169:
;Yash BE project.c,494 :: 		else if(Display8[i]==52)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop417
	MOVLW       52
	XORWF       R1, 0 
L__masterloop417:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop171
;Yash BE project.c,496 :: 		D8[i]=4;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,497 :: 		}
	GOTO        L_masterloop172
L_masterloop171:
;Yash BE project.c,498 :: 		else if(Display8[i]==53)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop418
	MOVLW       53
	XORWF       R1, 0 
L__masterloop418:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop173
;Yash BE project.c,500 :: 		D8[i]=5;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       5
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,501 :: 		}
	GOTO        L_masterloop174
L_masterloop173:
;Yash BE project.c,502 :: 		else if(Display8[i]==54)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop419
	MOVLW       54
	XORWF       R1, 0 
L__masterloop419:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop175
;Yash BE project.c,504 :: 		D8[i]=6;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       6
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,505 :: 		}
	GOTO        L_masterloop176
L_masterloop175:
;Yash BE project.c,506 :: 		else if(Display8[i]==55)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop420
	MOVLW       55
	XORWF       R1, 0 
L__masterloop420:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop177
;Yash BE project.c,508 :: 		D8[i]=7;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       7
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,509 :: 		}
	GOTO        L_masterloop178
L_masterloop177:
;Yash BE project.c,510 :: 		else if(Display8[i]==56)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop421
	MOVLW       56
	XORWF       R1, 0 
L__masterloop421:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop179
;Yash BE project.c,512 :: 		D8[i]=8;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       8
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,513 :: 		}
	GOTO        L_masterloop180
L_masterloop179:
;Yash BE project.c,514 :: 		else if(Display8[i]==57)
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_Display8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(masterloop_Display8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop422
	MOVLW       57
	XORWF       R1, 0 
L__masterloop422:
	BTFSS       STATUS+0, 2 
	GOTO        L_masterloop181
;Yash BE project.c,516 :: 		D8[i]=9;
	MOVF        masterloop_i_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       masterloop_D8_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(masterloop_D8_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       9
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;Yash BE project.c,517 :: 		}
L_masterloop181:
L_masterloop180:
L_masterloop178:
L_masterloop176:
L_masterloop174:
L_masterloop172:
L_masterloop170:
L_masterloop168:
L_masterloop166:
L_masterloop164:
;Yash BE project.c,476 :: 		for(i=0;i<4;i++)
	INFSNZ      masterloop_i_L0+0, 1 
	INCF        masterloop_i_L0+1, 1 
;Yash BE project.c,518 :: 		}
	GOTO        L_masterloop160
L_masterloop161:
;Yash BE project.c,522 :: 		res[3]=D1[3]+D2[3]+D3[3]+D4[3]+D5[3]+D6[3]+D7[3]+D8[3];
	MOVF        masterloop_D2_L0+6, 0 
	ADDWF       masterloop_D1_L0+6, 0 
	MOVWF       R0 
	MOVF        masterloop_D2_L0+7, 0 
	ADDWFC      masterloop_D1_L0+7, 0 
	MOVWF       R1 
	MOVF        masterloop_D3_L0+6, 0 
	ADDWF       R0, 1 
	MOVF        masterloop_D3_L0+7, 0 
	ADDWFC      R1, 1 
	MOVF        masterloop_D4_L0+6, 0 
	ADDWF       R0, 1 
	MOVF        masterloop_D4_L0+7, 0 
	ADDWFC      R1, 1 
	MOVF        masterloop_D5_L0+6, 0 
	ADDWF       R0, 1 
	MOVF        masterloop_D5_L0+7, 0 
	ADDWFC      R1, 1 
	MOVF        masterloop_D6_L0+6, 0 
	ADDWF       R0, 1 
	MOVF        masterloop_D6_L0+7, 0 
	ADDWFC      R1, 1 
	MOVF        masterloop_D7_L0+6, 0 
	ADDWF       R0, 1 
	MOVF        masterloop_D7_L0+7, 0 
	ADDWFC      R1, 1 
	MOVF        masterloop_D8_L0+6, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVF        masterloop_D8_L0+7, 0 
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       masterloop_res_L0+6 
	MOVF        R3, 0 
	MOVWF       masterloop_res_L0+7 
;Yash BE project.c,524 :: 		if(res[3]>9 && res[3]<20)
	MOVLW       0
	MOVWF       R0 
	MOVF        R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop423
	MOVF        R2, 0 
	SUBLW       9
L__masterloop423:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop184
	MOVLW       0
	SUBWF       masterloop_res_L0+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop424
	MOVLW       20
	SUBWF       masterloop_res_L0+6, 0 
L__masterloop424:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop184
L__masterloop330:
;Yash BE project.c,526 :: 		res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+1;
	MOVF        masterloop_D2_L0+4, 0 
	ADDWF       masterloop_D1_L0+4, 0 
	MOVWF       masterloop_res_L0+4 
	MOVF        masterloop_D2_L0+5, 0 
	ADDWFC      masterloop_D1_L0+5, 0 
	MOVWF       masterloop_res_L0+5 
	MOVF        masterloop_D3_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D3_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D4_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D4_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D5_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D5_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D6_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D6_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D7_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D7_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D8_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D8_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	INFSNZ      masterloop_res_L0+4, 1 
	INCF        masterloop_res_L0+5, 1 
;Yash BE project.c,527 :: 		res[3]= res[3]-10;
	MOVLW       10
	SUBWF       masterloop_res_L0+6, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+7, 1 
;Yash BE project.c,528 :: 		}
	GOTO        L_masterloop185
L_masterloop184:
;Yash BE project.c,529 :: 		else if(res[3]>19 && res[3]<30)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop425
	MOVF        masterloop_res_L0+6, 0 
	SUBLW       19
L__masterloop425:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop188
	MOVLW       0
	SUBWF       masterloop_res_L0+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop426
	MOVLW       30
	SUBWF       masterloop_res_L0+6, 0 
L__masterloop426:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop188
L__masterloop329:
;Yash BE project.c,531 :: 		res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+2;
	MOVF        masterloop_D2_L0+4, 0 
	ADDWF       masterloop_D1_L0+4, 0 
	MOVWF       masterloop_res_L0+4 
	MOVF        masterloop_D2_L0+5, 0 
	ADDWFC      masterloop_D1_L0+5, 0 
	MOVWF       masterloop_res_L0+5 
	MOVF        masterloop_D3_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D3_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D4_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D4_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D5_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D5_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D6_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D6_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D7_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D7_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D8_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D8_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVLW       2
	ADDWF       masterloop_res_L0+4, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+5, 1 
;Yash BE project.c,532 :: 		res[3]= res[3]-20;
	MOVLW       20
	SUBWF       masterloop_res_L0+6, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+7, 1 
;Yash BE project.c,533 :: 		}
	GOTO        L_masterloop189
L_masterloop188:
;Yash BE project.c,534 :: 		else if(res[3]>29 && res[3]<40)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop427
	MOVF        masterloop_res_L0+6, 0 
	SUBLW       29
L__masterloop427:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop192
	MOVLW       0
	SUBWF       masterloop_res_L0+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop428
	MOVLW       40
	SUBWF       masterloop_res_L0+6, 0 
L__masterloop428:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop192
L__masterloop328:
;Yash BE project.c,536 :: 		res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+3;
	MOVF        masterloop_D2_L0+4, 0 
	ADDWF       masterloop_D1_L0+4, 0 
	MOVWF       masterloop_res_L0+4 
	MOVF        masterloop_D2_L0+5, 0 
	ADDWFC      masterloop_D1_L0+5, 0 
	MOVWF       masterloop_res_L0+5 
	MOVF        masterloop_D3_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D3_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D4_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D4_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D5_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D5_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D6_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D6_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D7_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D7_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D8_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D8_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVLW       3
	ADDWF       masterloop_res_L0+4, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+5, 1 
;Yash BE project.c,537 :: 		res[3]= res[3]-30;
	MOVLW       30
	SUBWF       masterloop_res_L0+6, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+7, 1 
;Yash BE project.c,538 :: 		}
	GOTO        L_masterloop193
L_masterloop192:
;Yash BE project.c,539 :: 		else if(res[3]>39 && res[3]<50)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop429
	MOVF        masterloop_res_L0+6, 0 
	SUBLW       39
L__masterloop429:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop196
	MOVLW       0
	SUBWF       masterloop_res_L0+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop430
	MOVLW       50
	SUBWF       masterloop_res_L0+6, 0 
L__masterloop430:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop196
L__masterloop327:
;Yash BE project.c,541 :: 		res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+4;
	MOVF        masterloop_D2_L0+4, 0 
	ADDWF       masterloop_D1_L0+4, 0 
	MOVWF       masterloop_res_L0+4 
	MOVF        masterloop_D2_L0+5, 0 
	ADDWFC      masterloop_D1_L0+5, 0 
	MOVWF       masterloop_res_L0+5 
	MOVF        masterloop_D3_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D3_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D4_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D4_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D5_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D5_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D6_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D6_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D7_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D7_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D8_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D8_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVLW       4
	ADDWF       masterloop_res_L0+4, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+5, 1 
;Yash BE project.c,542 :: 		res[3]= res[3]-40;
	MOVLW       40
	SUBWF       masterloop_res_L0+6, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+7, 1 
;Yash BE project.c,543 :: 		}
	GOTO        L_masterloop197
L_masterloop196:
;Yash BE project.c,544 :: 		else if(res[3]>49 && res[3]<60)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop431
	MOVF        masterloop_res_L0+6, 0 
	SUBLW       49
L__masterloop431:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop200
	MOVLW       0
	SUBWF       masterloop_res_L0+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop432
	MOVLW       60
	SUBWF       masterloop_res_L0+6, 0 
L__masterloop432:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop200
L__masterloop326:
;Yash BE project.c,546 :: 		res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+5;
	MOVF        masterloop_D2_L0+4, 0 
	ADDWF       masterloop_D1_L0+4, 0 
	MOVWF       masterloop_res_L0+4 
	MOVF        masterloop_D2_L0+5, 0 
	ADDWFC      masterloop_D1_L0+5, 0 
	MOVWF       masterloop_res_L0+5 
	MOVF        masterloop_D3_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D3_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D4_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D4_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D5_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D5_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D6_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D6_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D7_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D7_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D8_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D8_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVLW       5
	ADDWF       masterloop_res_L0+4, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+5, 1 
;Yash BE project.c,547 :: 		res[3]= res[3]-50;
	MOVLW       50
	SUBWF       masterloop_res_L0+6, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+7, 1 
;Yash BE project.c,548 :: 		}
	GOTO        L_masterloop201
L_masterloop200:
;Yash BE project.c,549 :: 		else if(res[3]>59 && res[3]<70)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop433
	MOVF        masterloop_res_L0+6, 0 
	SUBLW       59
L__masterloop433:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop204
	MOVLW       0
	SUBWF       masterloop_res_L0+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop434
	MOVLW       70
	SUBWF       masterloop_res_L0+6, 0 
L__masterloop434:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop204
L__masterloop325:
;Yash BE project.c,551 :: 		res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+6;
	MOVF        masterloop_D2_L0+4, 0 
	ADDWF       masterloop_D1_L0+4, 0 
	MOVWF       masterloop_res_L0+4 
	MOVF        masterloop_D2_L0+5, 0 
	ADDWFC      masterloop_D1_L0+5, 0 
	MOVWF       masterloop_res_L0+5 
	MOVF        masterloop_D3_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D3_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D4_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D4_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D5_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D5_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D6_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D6_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D7_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D7_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D8_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D8_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVLW       6
	ADDWF       masterloop_res_L0+4, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+5, 1 
;Yash BE project.c,552 :: 		res[3]= res[3]-60;
	MOVLW       60
	SUBWF       masterloop_res_L0+6, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+7, 1 
;Yash BE project.c,553 :: 		}
	GOTO        L_masterloop205
L_masterloop204:
;Yash BE project.c,554 :: 		else if(res[3]>69 && res[3]<80)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+7, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop435
	MOVF        masterloop_res_L0+6, 0 
	SUBLW       69
L__masterloop435:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop208
	MOVLW       0
	SUBWF       masterloop_res_L0+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop436
	MOVLW       80
	SUBWF       masterloop_res_L0+6, 0 
L__masterloop436:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop208
L__masterloop324:
;Yash BE project.c,556 :: 		res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+7;
	MOVF        masterloop_D2_L0+4, 0 
	ADDWF       masterloop_D1_L0+4, 0 
	MOVWF       masterloop_res_L0+4 
	MOVF        masterloop_D2_L0+5, 0 
	ADDWFC      masterloop_D1_L0+5, 0 
	MOVWF       masterloop_res_L0+5 
	MOVF        masterloop_D3_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D3_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D4_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D4_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D5_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D5_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D6_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D6_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D7_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D7_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D8_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D8_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVLW       7
	ADDWF       masterloop_res_L0+4, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+5, 1 
;Yash BE project.c,557 :: 		res[3]= res[3]-70;
	MOVLW       70
	SUBWF       masterloop_res_L0+6, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+7, 1 
;Yash BE project.c,558 :: 		}
	GOTO        L_masterloop209
L_masterloop208:
;Yash BE project.c,561 :: 		res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2];
	MOVF        masterloop_D2_L0+4, 0 
	ADDWF       masterloop_D1_L0+4, 0 
	MOVWF       masterloop_res_L0+4 
	MOVF        masterloop_D2_L0+5, 0 
	ADDWFC      masterloop_D1_L0+5, 0 
	MOVWF       masterloop_res_L0+5 
	MOVF        masterloop_D3_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D3_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D4_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D4_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D5_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D5_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D6_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D6_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D7_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D7_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
	MOVF        masterloop_D8_L0+4, 0 
	ADDWF       masterloop_res_L0+4, 1 
	MOVF        masterloop_D8_L0+5, 0 
	ADDWFC      masterloop_res_L0+5, 1 
;Yash BE project.c,562 :: 		}
L_masterloop209:
L_masterloop205:
L_masterloop201:
L_masterloop197:
L_masterloop193:
L_masterloop189:
L_masterloop185:
;Yash BE project.c,563 :: 		FloatToStr(res[3], txt4);
	MOVF        masterloop_res_L0+6, 0 
	MOVWF       R0 
	MOVF        masterloop_res_L0+7, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       masterloop_txt4_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(masterloop_txt4_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,564 :: 		LCD_out(2, 4, txt4);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       masterloop_txt4_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(masterloop_txt4_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Yash BE project.c,567 :: 		if(res[2]>9 && res[2]<20)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop437
	MOVF        masterloop_res_L0+4, 0 
	SUBLW       9
L__masterloop437:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop212
	MOVLW       0
	SUBWF       masterloop_res_L0+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop438
	MOVLW       20
	SUBWF       masterloop_res_L0+4, 0 
L__masterloop438:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop212
L__masterloop323:
;Yash BE project.c,569 :: 		res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+1;
	MOVF        masterloop_D2_L0+2, 0 
	ADDWF       masterloop_D1_L0+2, 0 
	MOVWF       masterloop_res_L0+2 
	MOVF        masterloop_D2_L0+3, 0 
	ADDWFC      masterloop_D1_L0+3, 0 
	MOVWF       masterloop_res_L0+3 
	MOVF        masterloop_D3_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D3_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D4_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D4_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D5_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D5_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D6_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D6_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D7_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D7_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D8_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D8_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	INFSNZ      masterloop_res_L0+2, 1 
	INCF        masterloop_res_L0+3, 1 
;Yash BE project.c,570 :: 		res[2]= res[2]-10;
	MOVLW       10
	SUBWF       masterloop_res_L0+4, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+5, 1 
;Yash BE project.c,571 :: 		}
	GOTO        L_masterloop213
L_masterloop212:
;Yash BE project.c,572 :: 		else if(res[2]>19 && res[2]<30)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop439
	MOVF        masterloop_res_L0+4, 0 
	SUBLW       19
L__masterloop439:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop216
	MOVLW       0
	SUBWF       masterloop_res_L0+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop440
	MOVLW       30
	SUBWF       masterloop_res_L0+4, 0 
L__masterloop440:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop216
L__masterloop322:
;Yash BE project.c,574 :: 		res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+2;
	MOVF        masterloop_D2_L0+2, 0 
	ADDWF       masterloop_D1_L0+2, 0 
	MOVWF       masterloop_res_L0+2 
	MOVF        masterloop_D2_L0+3, 0 
	ADDWFC      masterloop_D1_L0+3, 0 
	MOVWF       masterloop_res_L0+3 
	MOVF        masterloop_D3_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D3_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D4_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D4_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D5_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D5_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D6_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D6_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D7_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D7_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D8_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D8_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVLW       2
	ADDWF       masterloop_res_L0+2, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+3, 1 
;Yash BE project.c,575 :: 		res[2]= res[2]-20;
	MOVLW       20
	SUBWF       masterloop_res_L0+4, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+5, 1 
;Yash BE project.c,576 :: 		}
	GOTO        L_masterloop217
L_masterloop216:
;Yash BE project.c,577 :: 		else if(res[2]>29 && res[2]<40)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop441
	MOVF        masterloop_res_L0+4, 0 
	SUBLW       29
L__masterloop441:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop220
	MOVLW       0
	SUBWF       masterloop_res_L0+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop442
	MOVLW       40
	SUBWF       masterloop_res_L0+4, 0 
L__masterloop442:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop220
L__masterloop321:
;Yash BE project.c,579 :: 		res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+3;
	MOVF        masterloop_D2_L0+2, 0 
	ADDWF       masterloop_D1_L0+2, 0 
	MOVWF       masterloop_res_L0+2 
	MOVF        masterloop_D2_L0+3, 0 
	ADDWFC      masterloop_D1_L0+3, 0 
	MOVWF       masterloop_res_L0+3 
	MOVF        masterloop_D3_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D3_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D4_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D4_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D5_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D5_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D6_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D6_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D7_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D7_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D8_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D8_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVLW       3
	ADDWF       masterloop_res_L0+2, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+3, 1 
;Yash BE project.c,580 :: 		res[2]= res[2]-30;
	MOVLW       30
	SUBWF       masterloop_res_L0+4, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+5, 1 
;Yash BE project.c,581 :: 		}
	GOTO        L_masterloop221
L_masterloop220:
;Yash BE project.c,582 :: 		else if(res[2]>39 && res[2]<50)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop443
	MOVF        masterloop_res_L0+4, 0 
	SUBLW       39
L__masterloop443:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop224
	MOVLW       0
	SUBWF       masterloop_res_L0+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop444
	MOVLW       50
	SUBWF       masterloop_res_L0+4, 0 
L__masterloop444:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop224
L__masterloop320:
;Yash BE project.c,584 :: 		res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+4;
	MOVF        masterloop_D2_L0+2, 0 
	ADDWF       masterloop_D1_L0+2, 0 
	MOVWF       masterloop_res_L0+2 
	MOVF        masterloop_D2_L0+3, 0 
	ADDWFC      masterloop_D1_L0+3, 0 
	MOVWF       masterloop_res_L0+3 
	MOVF        masterloop_D3_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D3_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D4_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D4_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D5_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D5_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D6_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D6_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D7_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D7_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D8_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D8_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVLW       4
	ADDWF       masterloop_res_L0+2, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+3, 1 
;Yash BE project.c,585 :: 		res[2]= res[2]-40;
	MOVLW       40
	SUBWF       masterloop_res_L0+4, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+5, 1 
;Yash BE project.c,586 :: 		}
	GOTO        L_masterloop225
L_masterloop224:
;Yash BE project.c,587 :: 		else if(res[2]>49 && res[2]<60)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop445
	MOVF        masterloop_res_L0+4, 0 
	SUBLW       49
L__masterloop445:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop228
	MOVLW       0
	SUBWF       masterloop_res_L0+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop446
	MOVLW       60
	SUBWF       masterloop_res_L0+4, 0 
L__masterloop446:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop228
L__masterloop319:
;Yash BE project.c,589 :: 		res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+5;
	MOVF        masterloop_D2_L0+2, 0 
	ADDWF       masterloop_D1_L0+2, 0 
	MOVWF       masterloop_res_L0+2 
	MOVF        masterloop_D2_L0+3, 0 
	ADDWFC      masterloop_D1_L0+3, 0 
	MOVWF       masterloop_res_L0+3 
	MOVF        masterloop_D3_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D3_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D4_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D4_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D5_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D5_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D6_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D6_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D7_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D7_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D8_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D8_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVLW       5
	ADDWF       masterloop_res_L0+2, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+3, 1 
;Yash BE project.c,590 :: 		res[2]= res[2]-50;
	MOVLW       50
	SUBWF       masterloop_res_L0+4, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+5, 1 
;Yash BE project.c,591 :: 		}
	GOTO        L_masterloop229
L_masterloop228:
;Yash BE project.c,592 :: 		else if(res[2]>59 && res[2]<70)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop447
	MOVF        masterloop_res_L0+4, 0 
	SUBLW       59
L__masterloop447:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop232
	MOVLW       0
	SUBWF       masterloop_res_L0+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop448
	MOVLW       70
	SUBWF       masterloop_res_L0+4, 0 
L__masterloop448:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop232
L__masterloop318:
;Yash BE project.c,594 :: 		res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+6;
	MOVF        masterloop_D2_L0+2, 0 
	ADDWF       masterloop_D1_L0+2, 0 
	MOVWF       masterloop_res_L0+2 
	MOVF        masterloop_D2_L0+3, 0 
	ADDWFC      masterloop_D1_L0+3, 0 
	MOVWF       masterloop_res_L0+3 
	MOVF        masterloop_D3_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D3_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D4_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D4_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D5_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D5_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D6_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D6_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D7_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D7_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D8_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D8_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVLW       6
	ADDWF       masterloop_res_L0+2, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+3, 1 
;Yash BE project.c,595 :: 		res[2]= res[2]-60;
	MOVLW       60
	SUBWF       masterloop_res_L0+4, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+5, 1 
;Yash BE project.c,596 :: 		}
	GOTO        L_masterloop233
L_masterloop232:
;Yash BE project.c,597 :: 		else if(res[2]>69 && res[2]<80)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop449
	MOVF        masterloop_res_L0+4, 0 
	SUBLW       69
L__masterloop449:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop236
	MOVLW       0
	SUBWF       masterloop_res_L0+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop450
	MOVLW       80
	SUBWF       masterloop_res_L0+4, 0 
L__masterloop450:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop236
L__masterloop317:
;Yash BE project.c,599 :: 		res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+7;
	MOVF        masterloop_D2_L0+2, 0 
	ADDWF       masterloop_D1_L0+2, 0 
	MOVWF       masterloop_res_L0+2 
	MOVF        masterloop_D2_L0+3, 0 
	ADDWFC      masterloop_D1_L0+3, 0 
	MOVWF       masterloop_res_L0+3 
	MOVF        masterloop_D3_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D3_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D4_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D4_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D5_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D5_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D6_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D6_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D7_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D7_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D8_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D8_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVLW       7
	ADDWF       masterloop_res_L0+2, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+3, 1 
;Yash BE project.c,600 :: 		res[2]= res[2]-70;
	MOVLW       70
	SUBWF       masterloop_res_L0+4, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+5, 1 
;Yash BE project.c,601 :: 		}
	GOTO        L_masterloop237
L_masterloop236:
;Yash BE project.c,604 :: 		res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1];
	MOVF        masterloop_D2_L0+2, 0 
	ADDWF       masterloop_D1_L0+2, 0 
	MOVWF       masterloop_res_L0+2 
	MOVF        masterloop_D2_L0+3, 0 
	ADDWFC      masterloop_D1_L0+3, 0 
	MOVWF       masterloop_res_L0+3 
	MOVF        masterloop_D3_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D3_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D4_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D4_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D5_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D5_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D6_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D6_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D7_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D7_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
	MOVF        masterloop_D8_L0+2, 0 
	ADDWF       masterloop_res_L0+2, 1 
	MOVF        masterloop_D8_L0+3, 0 
	ADDWFC      masterloop_res_L0+3, 1 
;Yash BE project.c,605 :: 		}
L_masterloop237:
L_masterloop233:
L_masterloop229:
L_masterloop225:
L_masterloop221:
L_masterloop217:
L_masterloop213:
;Yash BE project.c,607 :: 		FloatToStr(res[2], txt3);
	MOVF        masterloop_res_L0+4, 0 
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       masterloop_txt3_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(masterloop_txt3_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,608 :: 		LCD_out(2, 3, txt3);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       masterloop_txt3_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(masterloop_txt3_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Yash BE project.c,611 :: 		if(res[1]>9 && res[1]<20)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop451
	MOVF        masterloop_res_L0+2, 0 
	SUBLW       9
L__masterloop451:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop240
	MOVLW       0
	SUBWF       masterloop_res_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop452
	MOVLW       20
	SUBWF       masterloop_res_L0+2, 0 
L__masterloop452:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop240
L__masterloop316:
;Yash BE project.c,613 :: 		res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+1;
	MOVF        masterloop_D2_L0+0, 0 
	ADDWF       masterloop_D1_L0+0, 0 
	MOVWF       masterloop_res_L0+0 
	MOVF        masterloop_D2_L0+1, 0 
	ADDWFC      masterloop_D1_L0+1, 0 
	MOVWF       masterloop_res_L0+1 
	MOVF        masterloop_D3_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D3_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D4_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D4_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D5_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D5_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D6_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D6_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D7_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D7_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D8_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D8_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	INFSNZ      masterloop_res_L0+0, 1 
	INCF        masterloop_res_L0+1, 1 
;Yash BE project.c,614 :: 		res[1]= res[1]-10;
	MOVLW       10
	SUBWF       masterloop_res_L0+2, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+3, 1 
;Yash BE project.c,615 :: 		}
	GOTO        L_masterloop241
L_masterloop240:
;Yash BE project.c,616 :: 		else if(res[1]>19 && res[1]<30)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop453
	MOVF        masterloop_res_L0+2, 0 
	SUBLW       19
L__masterloop453:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop244
	MOVLW       0
	SUBWF       masterloop_res_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop454
	MOVLW       30
	SUBWF       masterloop_res_L0+2, 0 
L__masterloop454:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop244
L__masterloop315:
;Yash BE project.c,618 :: 		res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+2;
	MOVF        masterloop_D2_L0+0, 0 
	ADDWF       masterloop_D1_L0+0, 0 
	MOVWF       masterloop_res_L0+0 
	MOVF        masterloop_D2_L0+1, 0 
	ADDWFC      masterloop_D1_L0+1, 0 
	MOVWF       masterloop_res_L0+1 
	MOVF        masterloop_D3_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D3_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D4_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D4_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D5_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D5_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D6_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D6_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D7_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D7_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D8_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D8_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVLW       2
	ADDWF       masterloop_res_L0+0, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+1, 1 
;Yash BE project.c,619 :: 		res[1]= res[1]-20;
	MOVLW       20
	SUBWF       masterloop_res_L0+2, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+3, 1 
;Yash BE project.c,620 :: 		}
	GOTO        L_masterloop245
L_masterloop244:
;Yash BE project.c,621 :: 		else if(res[1]>29 && res[1]<40)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop455
	MOVF        masterloop_res_L0+2, 0 
	SUBLW       29
L__masterloop455:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop248
	MOVLW       0
	SUBWF       masterloop_res_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop456
	MOVLW       40
	SUBWF       masterloop_res_L0+2, 0 
L__masterloop456:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop248
L__masterloop314:
;Yash BE project.c,623 :: 		res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+3;
	MOVF        masterloop_D2_L0+0, 0 
	ADDWF       masterloop_D1_L0+0, 0 
	MOVWF       masterloop_res_L0+0 
	MOVF        masterloop_D2_L0+1, 0 
	ADDWFC      masterloop_D1_L0+1, 0 
	MOVWF       masterloop_res_L0+1 
	MOVF        masterloop_D3_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D3_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D4_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D4_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D5_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D5_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D6_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D6_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D7_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D7_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D8_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D8_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVLW       3
	ADDWF       masterloop_res_L0+0, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+1, 1 
;Yash BE project.c,624 :: 		res[1]= res[1]-30;
	MOVLW       30
	SUBWF       masterloop_res_L0+2, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+3, 1 
;Yash BE project.c,625 :: 		}
	GOTO        L_masterloop249
L_masterloop248:
;Yash BE project.c,626 :: 		else if(res[1]>39 && res[1]<50)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop457
	MOVF        masterloop_res_L0+2, 0 
	SUBLW       39
L__masterloop457:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop252
	MOVLW       0
	SUBWF       masterloop_res_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop458
	MOVLW       50
	SUBWF       masterloop_res_L0+2, 0 
L__masterloop458:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop252
L__masterloop313:
;Yash BE project.c,628 :: 		res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+4;
	MOVF        masterloop_D2_L0+0, 0 
	ADDWF       masterloop_D1_L0+0, 0 
	MOVWF       masterloop_res_L0+0 
	MOVF        masterloop_D2_L0+1, 0 
	ADDWFC      masterloop_D1_L0+1, 0 
	MOVWF       masterloop_res_L0+1 
	MOVF        masterloop_D3_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D3_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D4_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D4_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D5_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D5_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D6_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D6_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D7_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D7_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D8_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D8_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVLW       4
	ADDWF       masterloop_res_L0+0, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+1, 1 
;Yash BE project.c,629 :: 		res[1]= res[1]-40;
	MOVLW       40
	SUBWF       masterloop_res_L0+2, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+3, 1 
;Yash BE project.c,630 :: 		}
	GOTO        L_masterloop253
L_masterloop252:
;Yash BE project.c,631 :: 		else if(res[1]>49 && res[1]<60)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop459
	MOVF        masterloop_res_L0+2, 0 
	SUBLW       49
L__masterloop459:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop256
	MOVLW       0
	SUBWF       masterloop_res_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop460
	MOVLW       60
	SUBWF       masterloop_res_L0+2, 0 
L__masterloop460:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop256
L__masterloop312:
;Yash BE project.c,633 :: 		res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+5;
	MOVF        masterloop_D2_L0+0, 0 
	ADDWF       masterloop_D1_L0+0, 0 
	MOVWF       masterloop_res_L0+0 
	MOVF        masterloop_D2_L0+1, 0 
	ADDWFC      masterloop_D1_L0+1, 0 
	MOVWF       masterloop_res_L0+1 
	MOVF        masterloop_D3_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D3_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D4_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D4_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D5_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D5_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D6_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D6_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D7_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D7_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D8_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D8_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVLW       5
	ADDWF       masterloop_res_L0+0, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+1, 1 
;Yash BE project.c,634 :: 		res[1]= res[1]-50;
	MOVLW       50
	SUBWF       masterloop_res_L0+2, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+3, 1 
;Yash BE project.c,635 :: 		}
	GOTO        L_masterloop257
L_masterloop256:
;Yash BE project.c,636 :: 		else if(res[1]>59 && res[1]<70)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop461
	MOVF        masterloop_res_L0+2, 0 
	SUBLW       59
L__masterloop461:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop260
	MOVLW       0
	SUBWF       masterloop_res_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop462
	MOVLW       70
	SUBWF       masterloop_res_L0+2, 0 
L__masterloop462:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop260
L__masterloop311:
;Yash BE project.c,638 :: 		res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+6;
	MOVF        masterloop_D2_L0+0, 0 
	ADDWF       masterloop_D1_L0+0, 0 
	MOVWF       masterloop_res_L0+0 
	MOVF        masterloop_D2_L0+1, 0 
	ADDWFC      masterloop_D1_L0+1, 0 
	MOVWF       masterloop_res_L0+1 
	MOVF        masterloop_D3_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D3_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D4_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D4_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D5_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D5_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D6_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D6_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D7_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D7_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D8_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D8_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVLW       6
	ADDWF       masterloop_res_L0+0, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+1, 1 
;Yash BE project.c,639 :: 		res[1]= res[1]-60;
	MOVLW       60
	SUBWF       masterloop_res_L0+2, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+3, 1 
;Yash BE project.c,640 :: 		}
	GOTO        L_masterloop261
L_masterloop260:
;Yash BE project.c,641 :: 		else if(res[1]>69 && res[1]<80)
	MOVLW       0
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop463
	MOVF        masterloop_res_L0+2, 0 
	SUBLW       69
L__masterloop463:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop264
	MOVLW       0
	SUBWF       masterloop_res_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__masterloop464
	MOVLW       80
	SUBWF       masterloop_res_L0+2, 0 
L__masterloop464:
	BTFSC       STATUS+0, 0 
	GOTO        L_masterloop264
L__masterloop310:
;Yash BE project.c,643 :: 		res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+7;
	MOVF        masterloop_D2_L0+0, 0 
	ADDWF       masterloop_D1_L0+0, 0 
	MOVWF       masterloop_res_L0+0 
	MOVF        masterloop_D2_L0+1, 0 
	ADDWFC      masterloop_D1_L0+1, 0 
	MOVWF       masterloop_res_L0+1 
	MOVF        masterloop_D3_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D3_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D4_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D4_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D5_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D5_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D6_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D6_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D7_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D7_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D8_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D8_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVLW       7
	ADDWF       masterloop_res_L0+0, 1 
	MOVLW       0
	ADDWFC      masterloop_res_L0+1, 1 
;Yash BE project.c,644 :: 		res[1]= res[1]-70;
	MOVLW       70
	SUBWF       masterloop_res_L0+2, 1 
	MOVLW       0
	SUBWFB      masterloop_res_L0+3, 1 
;Yash BE project.c,645 :: 		}
	GOTO        L_masterloop265
L_masterloop264:
;Yash BE project.c,648 :: 		res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0];
	MOVF        masterloop_D2_L0+0, 0 
	ADDWF       masterloop_D1_L0+0, 0 
	MOVWF       masterloop_res_L0+0 
	MOVF        masterloop_D2_L0+1, 0 
	ADDWFC      masterloop_D1_L0+1, 0 
	MOVWF       masterloop_res_L0+1 
	MOVF        masterloop_D3_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D3_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D4_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D4_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D5_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D5_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D6_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D6_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D7_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D7_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
	MOVF        masterloop_D8_L0+0, 0 
	ADDWF       masterloop_res_L0+0, 1 
	MOVF        masterloop_D8_L0+1, 0 
	ADDWFC      masterloop_res_L0+1, 1 
;Yash BE project.c,649 :: 		}
L_masterloop265:
L_masterloop261:
L_masterloop257:
L_masterloop253:
L_masterloop249:
L_masterloop245:
L_masterloop241:
;Yash BE project.c,651 :: 		FloatToStr(res[1], txt2);
	MOVF        masterloop_res_L0+2, 0 
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       masterloop_txt2_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(masterloop_txt2_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,652 :: 		LCD_out(2, 2, txt2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       masterloop_txt2_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(masterloop_txt2_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Yash BE project.c,654 :: 		FloatToStr(res[0], txt1);
	MOVF        masterloop_res_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_res_L0+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       masterloop_txt1_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(masterloop_txt1_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,655 :: 		LCD_out(2, 1, txt1);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       masterloop_txt1_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(masterloop_txt1_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Yash BE project.c,657 :: 		measured=res[0]*1000+res[1]*100+res[2]*10+res[3];
	MOVF        masterloop_res_L0+0, 0 
	MOVWF       R0 
	MOVF        masterloop_res_L0+1, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__masterloop+0 
	MOVF        R1, 0 
	MOVWF       FLOC__masterloop+1 
	MOVF        masterloop_res_L0+2, 0 
	MOVWF       R0 
	MOVF        masterloop_res_L0+3, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__masterloop+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__masterloop+1, 1 
	MOVF        masterloop_res_L0+4, 0 
	MOVWF       R0 
	MOVF        masterloop_res_L0+5, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        FLOC__masterloop+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__masterloop+1, 0 
	ADDWFC      R1, 1 
	MOVF        masterloop_res_L0+6, 0 
	ADDWF       R0, 1 
	MOVF        masterloop_res_L0+7, 0 
	ADDWFC      R1, 1 
	CALL        _Word2Double+0, 0
	MOVF        R0, 0 
	MOVWF       _measured+0 
	MOVF        R1, 0 
	MOVWF       _measured+1 
	MOVF        R2, 0 
	MOVWF       _measured+2 
	MOVF        R3, 0 
	MOVWF       _measured+3 
;Yash BE project.c,662 :: 		return measured;
	CALL        _Double2Int+0, 0
;Yash BE project.c,663 :: 		}
L_end_masterloop:
	RETURN      0
; end of _masterloop

_calculator:

;Yash BE project.c,665 :: 		float calculator(int measured)
;Yash BE project.c,669 :: 		percent=(measured/reference)*100;
	MOVF        FARG_calculator_measured+0, 0 
	MOVWF       R0 
	MOVF        FARG_calculator_measured+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        _reference+0, 0 
	MOVWF       R4 
	MOVF        _reference+1, 0 
	MOVWF       R5 
	MOVF        _reference+2, 0 
	MOVWF       R6 
	MOVF        _reference+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       calculator_percent_L0+0 
	MOVF        R1, 0 
	MOVWF       calculator_percent_L0+1 
	MOVF        R2, 0 
	MOVWF       calculator_percent_L0+2 
	MOVF        R3, 0 
	MOVWF       calculator_percent_L0+3 
;Yash BE project.c,670 :: 		FloatToStr(percent, percenttxt);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       calculator_percenttxt_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(calculator_percenttxt_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,671 :: 		LCD_out(2, 10, percenttxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       calculator_percenttxt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(calculator_percenttxt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Yash BE project.c,672 :: 		LCD_chr(2, 16, '%');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       37
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Yash BE project.c,673 :: 		return percent;
	MOVF        calculator_percent_L0+0, 0 
	MOVWF       R0 
	MOVF        calculator_percent_L0+1, 0 
	MOVWF       R1 
	MOVF        calculator_percent_L0+2, 0 
	MOVWF       R2 
	MOVF        calculator_percent_L0+3, 0 
	MOVWF       R3 
;Yash BE project.c,674 :: 		}
L_end_calculator:
	RETURN      0
; end of _calculator

_convInt:

;Yash BE project.c,676 :: 		int convInt(char a)
;Yash BE project.c,679 :: 		if(a==48)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       48
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt266
;Yash BE project.c,681 :: 		integer=0;
	CLRF        R2 
	CLRF        R3 
;Yash BE project.c,682 :: 		}
	GOTO        L_convInt267
L_convInt266:
;Yash BE project.c,683 :: 		else if(a==49)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt268
;Yash BE project.c,685 :: 		integer=1;
	MOVLW       1
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,686 :: 		}
	GOTO        L_convInt269
L_convInt268:
;Yash BE project.c,687 :: 		else if(a==50)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt270
;Yash BE project.c,689 :: 		integer=2;
	MOVLW       2
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,690 :: 		}
	GOTO        L_convInt271
L_convInt270:
;Yash BE project.c,691 :: 		else if(a==51)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt272
;Yash BE project.c,693 :: 		integer=3;
	MOVLW       3
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,694 :: 		}
	GOTO        L_convInt273
L_convInt272:
;Yash BE project.c,695 :: 		else if(a==52)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       52
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt274
;Yash BE project.c,697 :: 		integer=4;
	MOVLW       4
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,698 :: 		}
	GOTO        L_convInt275
L_convInt274:
;Yash BE project.c,699 :: 		else if(a==53)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       53
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt276
;Yash BE project.c,701 :: 		integer=5;
	MOVLW       5
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,702 :: 		}
	GOTO        L_convInt277
L_convInt276:
;Yash BE project.c,703 :: 		else if(a==54)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt278
;Yash BE project.c,705 :: 		integer=6;
	MOVLW       6
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,706 :: 		}
	GOTO        L_convInt279
L_convInt278:
;Yash BE project.c,707 :: 		else if(a==55)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       55
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt280
;Yash BE project.c,709 :: 		integer=7;
	MOVLW       7
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,710 :: 		}
	GOTO        L_convInt281
L_convInt280:
;Yash BE project.c,711 :: 		else if(a==56)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       56
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt282
;Yash BE project.c,713 :: 		integer=8;
	MOVLW       8
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,714 :: 		}
	GOTO        L_convInt283
L_convInt282:
;Yash BE project.c,715 :: 		else if(a==57)
	MOVF        FARG_convInt_a+0, 0 
	XORLW       57
	BTFSS       STATUS+0, 2 
	GOTO        L_convInt284
;Yash BE project.c,717 :: 		integer=9;
	MOVLW       9
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
;Yash BE project.c,718 :: 		}
L_convInt284:
L_convInt283:
L_convInt281:
L_convInt279:
L_convInt277:
L_convInt275:
L_convInt273:
L_convInt271:
L_convInt269:
L_convInt267:
;Yash BE project.c,719 :: 		return integer;
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	MOVWF       R1 
;Yash BE project.c,720 :: 		}
L_end_convInt:
	RETURN      0
; end of _convInt

_mod:

;Yash BE project.c,722 :: 		float mod(float modulu)
;Yash BE project.c,725 :: 		if(modulu<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        mod_modulu_L0+0, 0 
	MOVWF       R0 
	MOVF        mod_modulu_L0+1, 0 
	MOVWF       R1 
	MOVF        mod_modulu_L0+2, 0 
	MOVWF       R2 
	MOVF        mod_modulu_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mod285
;Yash BE project.c,727 :: 		modulu=modulu*(-1);
	MOVF        mod_modulu_L0+0, 0 
	MOVWF       R0 
	MOVF        mod_modulu_L0+1, 0 
	MOVWF       R1 
	MOVF        mod_modulu_L0+2, 0 
	MOVWF       R2 
	MOVF        mod_modulu_L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       mod_modulu_L0+0 
	MOVF        R1, 0 
	MOVWF       mod_modulu_L0+1 
	MOVF        R2, 0 
	MOVWF       mod_modulu_L0+2 
	MOVF        R3, 0 
	MOVWF       mod_modulu_L0+3 
;Yash BE project.c,728 :: 		}
	GOTO        L_mod286
L_mod285:
;Yash BE project.c,731 :: 		modulu=modulu;
;Yash BE project.c,732 :: 		}
L_mod286:
;Yash BE project.c,733 :: 		return modulu;
	MOVF        mod_modulu_L0+0, 0 
	MOVWF       R0 
	MOVF        mod_modulu_L0+1, 0 
	MOVWF       R1 
	MOVF        mod_modulu_L0+2, 0 
	MOVWF       R2 
	MOVF        mod_modulu_L0+3, 0 
	MOVWF       R3 
;Yash BE project.c,734 :: 		}
L_end_mod:
	RETURN      0
; end of _mod

_main:

;Yash BE project.c,737 :: 		void main()
;Yash BE project.c,742 :: 		float x=0,y=0,op1,op2,Amp,Off;
;Yash BE project.c,747 :: 		TRISC=0X00;
	CLRF        TRISC+0 
;Yash BE project.c,748 :: 		TRISA=0XFF;
	MOVLW       255
	MOVWF       TRISA+0 
;Yash BE project.c,749 :: 		TRISD=0X00;
	CLRF        TRISD+0 
;Yash BE project.c,750 :: 		TRISB=0X00;
	CLRF        TRISB+0 
;Yash BE project.c,751 :: 		TRISE=0X00;
	CLRF        TRISE+0 
;Yash BE project.c,753 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Yash BE project.c,754 :: 		ADC_Init();                       // Initialize ADC module with default settings
	CALL        _ADC_Init+0, 0
;Yash BE project.c,756 :: 		UART1_Init(38400);                // Initialize UART module at 9600 bps
	MOVLW       12
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Yash BE project.c,757 :: 		Delay_ms(100);                    // Wait for UART module to stabilize
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main287:
	DECFSZ      R13, 1, 1
	BRA         L_main287
	DECFSZ      R12, 1, 1
	BRA         L_main287
	DECFSZ      R11, 1, 1
	BRA         L_main287
	NOP
;Yash BE project.c,758 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Yash BE project.c,761 :: 		Lcd_Out(1, 2, "Bluetooth waiting");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Yash_32BE_32project+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Yash_32BE_32project+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Yash BE project.c,762 :: 		Lcd_Out(2, 2, "for connection...");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Yash_32BE_32project+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Yash_32BE_32project+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Yash BE project.c,764 :: 		Amp=((Upperbound-Lowerbound)/(max_data-min_data));    //5.0147;
	MOVF        _Lowerbound+0, 0 
	MOVWF       R4 
	MOVF        _Lowerbound+1, 0 
	MOVWF       R5 
	MOVF        _Lowerbound+2, 0 
	MOVWF       R6 
	MOVF        _Lowerbound+3, 0 
	MOVWF       R7 
	MOVF        _Upperbound+0, 0 
	MOVWF       R0 
	MOVF        _Upperbound+1, 0 
	MOVWF       R1 
	MOVF        _Upperbound+2, 0 
	MOVWF       R2 
	MOVF        _Upperbound+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        _min_data+0, 0 
	MOVWF       R4 
	MOVF        _min_data+1, 0 
	MOVWF       R5 
	MOVF        _min_data+2, 0 
	MOVWF       R6 
	MOVF        _min_data+3, 0 
	MOVWF       R7 
	MOVF        _max_data+0, 0 
	MOVWF       R0 
	MOVF        _max_data+1, 0 
	MOVWF       R1 
	MOVF        _max_data+2, 0 
	MOVWF       R2 
	MOVF        _max_data+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	MOVF        FLOC__main+2, 0 
	MOVWF       R2 
	MOVF        FLOC__main+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_Amp_L0+0 
	MOVF        R1, 0 
	MOVWF       main_Amp_L0+1 
	MOVF        R2, 0 
	MOVWF       main_Amp_L0+2 
	MOVF        R3, 0 
	MOVWF       main_Amp_L0+3 
;Yash BE project.c,765 :: 		Off=Upperbound-(Amp*max_data);
	MOVF        _max_data+0, 0 
	MOVWF       R4 
	MOVF        _max_data+1, 0 
	MOVWF       R5 
	MOVF        _max_data+2, 0 
	MOVWF       R6 
	MOVF        _max_data+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _Upperbound+0, 0 
	MOVWF       R0 
	MOVF        _Upperbound+1, 0 
	MOVWF       R1 
	MOVF        _Upperbound+2, 0 
	MOVWF       R2 
	MOVF        _Upperbound+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_Off_L0+0 
	MOVF        R1, 0 
	MOVWF       main_Off_L0+1 
	MOVF        R2, 0 
	MOVWF       main_Off_L0+2 
	MOVF        R3, 0 
	MOVWF       main_Off_L0+3 
;Yash BE project.c,783 :: 		while (!UART1_Data_Ready());     // If data is received
L_main288:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main289
	GOTO        L_main288
L_main289:
;Yash BE project.c,785 :: 		UART1_Read_Text(output, "ok", 255);    // reads text until 'OK' is found
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr3_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr3_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       255
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;Yash BE project.c,790 :: 		UART1_Write_Text("Connection Successful!!");
	MOVLW       ?lstr4_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,791 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,792 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,794 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,810 :: 		base =(Amp*masterloop())+Off;        // Here we set the maximum value of weight.
	CALL        _masterloop+0, 0
	CALL        _Int2Double+0, 0
	MOVF        main_Amp_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Amp_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Amp_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Amp_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        main_Off_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Off_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Off_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Off_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _base+0 
	MOVF        R1, 0 
	MOVWF       _base+1 
	MOVF        R2, 0 
	MOVWF       _base+2 
	MOVF        R3, 0 
	MOVWF       _base+3 
;Yash BE project.c,812 :: 		UART1_Write_Text("Enter your limit... First Enter 10's place digit : ");
	MOVLW       ?lstr5_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,813 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,814 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,815 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,816 :: 		while (!UART1_Data_Ready());
L_main290:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main291
	GOTO        L_main290
L_main291:
;Yash BE project.c,818 :: 		UART1_Read_Text(output, "ok", 255);    // reads text until 'OK' is found
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr6_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr6_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       255
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;Yash BE project.c,826 :: 		limit1= convInt(output[0]);              //At this point 10's place is accepted.
	MOVF        main_output_L0+0, 0 
	MOVWF       FARG_convInt_a+0 
	CALL        _convInt+0, 0
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       main_limit1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_limit1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_limit1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_limit1_L0+3 
;Yash BE project.c,828 :: 		UART1_Write_Text("Now Enter unit's place digit : ");
	MOVLW       ?lstr7_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,829 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,830 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,831 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,832 :: 		while (!UART1_Data_Ready());
L_main292:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main293
	GOTO        L_main292
L_main293:
;Yash BE project.c,834 :: 		UART1_Read_Text(output, "ok", 255);    // reads text until 'OK' is found
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr8_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr8_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       255
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;Yash BE project.c,840 :: 		limit2= convInt(output[0]);             //At this point 0's place is accepted.
	MOVF        main_output_L0+0, 0 
	MOVWF       FARG_convInt_a+0 
	CALL        _convInt+0, 0
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       main_limit2_L0+0 
	MOVF        R1, 0 
	MOVWF       main_limit2_L0+1 
	MOVF        R2, 0 
	MOVWF       main_limit2_L0+2 
	MOVF        R3, 0 
	MOVWF       main_limit2_L0+3 
;Yash BE project.c,846 :: 		limit=(limit1*10)+limit2;       //Final limit calculation
	MOVF        main_limit1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_limit1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_limit1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_limit1_L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        main_limit2_L0+0, 0 
	MOVWF       R4 
	MOVF        main_limit2_L0+1, 0 
	MOVWF       R5 
	MOVF        main_limit2_L0+2, 0 
	MOVWF       R6 
	MOVF        main_limit2_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        FLOC__main+0, 0 
	MOVWF       main_limit_L0+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       main_limit_L0+1 
	MOVF        FLOC__main+2, 0 
	MOVWF       main_limit_L0+2 
	MOVF        FLOC__main+3, 0 
	MOVWF       main_limit_L0+3 
;Yash BE project.c,847 :: 		threshold=limit-50;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	MOVF        FLOC__main+2, 0 
	MOVWF       R2 
	MOVF        FLOC__main+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _threshold+0 
	MOVF        R1, 0 
	MOVWF       _threshold+1 
	MOVF        R2, 0 
	MOVWF       _threshold+2 
	MOVF        R3, 0 
	MOVWF       _threshold+3 
;Yash BE project.c,848 :: 		FloatToStr(limit, output);
	MOVF        FLOC__main+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        FLOC__main+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        FLOC__main+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,850 :: 		UART1_Write_Text("Your prescribed limit is: ");
	MOVLW       ?lstr9_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,851 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,852 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,853 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,854 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,855 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,858 :: 		UART1_Write_Text("Put full pressure until you hear a 3 second buzzer.");
	MOVLW       ?lstr10_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,859 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,860 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,861 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,862 :: 		UART1_Write_Text("Press 'ok' when full pressure is applied.");
	MOVLW       ?lstr11_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,863 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,864 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,865 :: 		while (!UART1_Data_Ready());
L_main294:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main295
	GOTO        L_main294
L_main295:
;Yash BE project.c,867 :: 		UART1_Read_Text(output, "ok", 255);    // reads text until 'OK' is found
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr12_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr12_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       255
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;Yash BE project.c,871 :: 		msdelay(2000);                         //buffer time to apply pressure
	MOVLW       208
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       7
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,872 :: 		REF =(Amp*masterloop())+Off;;
	CALL        _masterloop+0, 0
	CALL        _Int2Double+0, 0
	MOVF        main_Amp_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Amp_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Amp_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Amp_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        main_Off_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Off_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Off_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Off_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_REF_L0+0 
	MOVF        R1, 0 
	MOVWF       main_REF_L0+1 
	MOVF        R2, 0 
	MOVWF       main_REF_L0+2 
	MOVF        R3, 0 
	MOVWF       main_REF_L0+3 
;Yash BE project.c,873 :: 		reference=REF - base;        // Here we set the maximum value of weight.
	MOVF        _base+0, 0 
	MOVWF       R4 
	MOVF        _base+1, 0 
	MOVWF       R5 
	MOVF        _base+2, 0 
	MOVWF       R6 
	MOVF        _base+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _reference+0 
	MOVF        R1, 0 
	MOVWF       _reference+1 
	MOVF        R2, 0 
	MOVWF       _reference+2 
	MOVF        R3, 0 
	MOVWF       _reference+3 
;Yash BE project.c,874 :: 		if (reference<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main296
;Yash BE project.c,876 :: 		reference=reference*(-1);
	MOVF        _reference+0, 0 
	MOVWF       R0 
	MOVF        _reference+1, 0 
	MOVWF       R1 
	MOVF        _reference+2, 0 
	MOVWF       R2 
	MOVF        _reference+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _reference+0 
	MOVF        R1, 0 
	MOVWF       _reference+1 
	MOVF        R2, 0 
	MOVWF       _reference+2 
	MOVF        R3, 0 
	MOVWF       _reference+3 
;Yash BE project.c,877 :: 		}
L_main296:
;Yash BE project.c,879 :: 		PORTB.TRISB7=1;
	BSF         PORTB+0, 7 
;Yash BE project.c,880 :: 		UART1_Write_Text("Thank you..");
	MOVLW       ?lstr13_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,881 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,882 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,883 :: 		msdelay(500);
	MOVLW       244
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,884 :: 		PORTB.TRISB7=0;               //buzzer goes off
	BCF         PORTB+0, 7 
;Yash BE project.c,887 :: 		msdelay(2000);                //3 sec buzzer goes on..
	MOVLW       208
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       7
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,890 :: 		UART1_Write_Text("Electroware is ready to use now..");
	MOVLW       ?lstr14_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,891 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,892 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,894 :: 		thresh_value= (threshold/100)*reference;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        _threshold+0, 0 
	MOVWF       R0 
	MOVF        _threshold+1, 0 
	MOVWF       R1 
	MOVF        _threshold+2, 0 
	MOVWF       R2 
	MOVF        _threshold+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        _reference+0, 0 
	MOVWF       R4 
	MOVF        _reference+1, 0 
	MOVWF       R5 
	MOVF        _reference+2, 0 
	MOVWF       R6 
	MOVF        _reference+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_thresh_value_L0+0 
	MOVF        R1, 0 
	MOVWF       main_thresh_value_L0+1 
	MOVF        R2, 0 
	MOVWF       main_thresh_value_L0+2 
	MOVF        R3, 0 
	MOVWF       main_thresh_value_L0+3 
;Yash BE project.c,895 :: 		limit_value=  (limit/100)*reference;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        main_limit_L0+0, 0 
	MOVWF       R0 
	MOVF        main_limit_L0+1, 0 
	MOVWF       R1 
	MOVF        main_limit_L0+2, 0 
	MOVWF       R2 
	MOVF        main_limit_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        _reference+0, 0 
	MOVWF       R4 
	MOVF        _reference+1, 0 
	MOVWF       R5 
	MOVF        _reference+2, 0 
	MOVWF       R6 
	MOVF        _reference+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_limit_value_L0+0 
	MOVF        R1, 0 
	MOVWF       main_limit_value_L0+1 
	MOVF        R2, 0 
	MOVWF       main_limit_value_L0+2 
	MOVF        R3, 0 
	MOVWF       main_limit_value_L0+3 
;Yash BE project.c,897 :: 		UART1_Write_Text("Base : ");
	MOVLW       ?lstr15_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr15_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,899 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,900 :: 		FloatToStr(base, output);
	MOVF        _base+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _base+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _base+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _base+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,901 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,902 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,903 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,905 :: 		UART1_Write_Text("Reading : ");
	MOVLW       ?lstr16_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr16_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,907 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,908 :: 		FloatToStr(REF, output);
	MOVF        main_REF_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_REF_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_REF_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_REF_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,909 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,910 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,911 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,913 :: 		UART1_Write_Text("Reference : ");
	MOVLW       ?lstr17_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,915 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,916 :: 		FloatToStr(reference, output);
	MOVF        _reference+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _reference+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _reference+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _reference+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,917 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,918 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,919 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,921 :: 		UART1_Write_Text("Threshold value : ");
	MOVLW       ?lstr18_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,923 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,924 :: 		FloatToStr(thresh_value, output);
	MOVF        main_thresh_value_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_thresh_value_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_thresh_value_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_thresh_value_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,925 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,926 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,927 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,929 :: 		UART1_Write_Text("Limit : ");
	MOVLW       ?lstr19_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr19_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,931 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,932 :: 		FloatToStr(limit_value, output);
	MOVF        main_limit_value_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_limit_value_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_limit_value_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_limit_value_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,933 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,934 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,935 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,943 :: 		msdelay(5000);
	MOVLW       136
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       19
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,944 :: 		while(1)
L_main297:
;Yash BE project.c,948 :: 		op2 =(Amp*masterloop())+Off;
	CALL        _masterloop+0, 0
	CALL        _Int2Double+0, 0
	MOVF        main_Amp_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Amp_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Amp_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Amp_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        main_Off_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Off_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Off_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Off_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_op2_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op2_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op2_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op2_L0+3 
;Yash BE project.c,949 :: 		op1=op2-base;
	MOVF        _base+0, 0 
	MOVWF       R4 
	MOVF        _base+1, 0 
	MOVWF       R5 
	MOVF        _base+2, 0 
	MOVWF       R6 
	MOVF        _base+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_op1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op1_L0+3 
;Yash BE project.c,950 :: 		if (op1<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main299
;Yash BE project.c,952 :: 		op1=op1*(-1);
	MOVF        main_op1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_op1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op1_L0+3 
;Yash BE project.c,953 :: 		}
L_main299:
;Yash BE project.c,955 :: 		PERCENT=calculator(op1);
	MOVF        main_op1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       R3 
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_calculator_measured+0 
	MOVF        R1, 0 
	MOVWF       FARG_calculator_measured+1 
	CALL        _calculator+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       main_PERCENT_L0+0 
	MOVF        R1, 0 
	MOVWF       main_PERCENT_L0+1 
;Yash BE project.c,956 :: 		FloatToStr(op2, output);
	MOVF        main_op2_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_op2_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_op2_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_op2_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,957 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,959 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,960 :: 		FloatToStr(op1, output);
	MOVF        main_op1_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,961 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,962 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,963 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,964 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,969 :: 		UART1_Write_Text("Waiting for pressure..");
	MOVLW       ?lstr20_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr20_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,970 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,971 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,972 :: 		do
L_main300:
;Yash BE project.c,974 :: 		op2=masterloop();
	CALL        _masterloop+0, 0
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       main_op2_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op2_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op2_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op2_L0+3 
;Yash BE project.c,975 :: 		op1=masterloop()-base;
	CALL        _masterloop+0, 0
	CALL        _Int2Double+0, 0
	MOVF        _base+0, 0 
	MOVWF       R4 
	MOVF        _base+1, 0 
	MOVWF       R5 
	MOVF        _base+2, 0 
	MOVWF       R6 
	MOVF        _base+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_op1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op1_L0+3 
;Yash BE project.c,976 :: 		if (op1<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main303
;Yash BE project.c,978 :: 		op1=op1*(-1);
	MOVF        main_op1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_op1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op1_L0+3 
;Yash BE project.c,979 :: 		}
L_main303:
;Yash BE project.c,980 :: 		PERCENT=calculator(op1);
	MOVF        main_op1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       R3 
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_calculator_measured+0 
	MOVF        R1, 0 
	MOVWF       FARG_calculator_measured+1 
	CALL        _calculator+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       main_PERCENT_L0+0 
	MOVF        R1, 0 
	MOVWF       main_PERCENT_L0+1 
;Yash BE project.c,981 :: 		FloatToStr(op1, output);
	MOVF        main_op1_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,982 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,983 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,984 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,985 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,986 :: 		}while(PERCENT<threshold);
	MOVF        main_PERCENT_L0+0, 0 
	MOVWF       R0 
	MOVF        main_PERCENT_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        _threshold+0, 0 
	MOVWF       R4 
	MOVF        _threshold+1, 0 
	MOVWF       R5 
	MOVF        _threshold+2, 0 
	MOVWF       R6 
	MOVF        _threshold+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main300
;Yash BE project.c,987 :: 		msdelay(interval);               // waiting for 'interval/1000' sec before capturing the input values
	MOVF        _interval+0, 0 
	MOVWF       R0 
	MOVF        _interval+1, 0 
	MOVWF       R1 
	MOVF        _interval+2, 0 
	MOVWF       R2 
	MOVF        _interval+3, 0 
	MOVWF       R3 
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_msdelay_itime+0 
	MOVF        R1, 0 
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,988 :: 		UART1_Write_Text("Crossed threshold :");
	MOVLW       ?lstr21_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr21_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,990 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,991 :: 		op2=masterloop();
	CALL        _masterloop+0, 0
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       main_op2_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op2_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op2_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op2_L0+3 
;Yash BE project.c,992 :: 		op1=masterloop()-base;
	CALL        _masterloop+0, 0
	CALL        _Int2Double+0, 0
	MOVF        _base+0, 0 
	MOVWF       R4 
	MOVF        _base+1, 0 
	MOVWF       R5 
	MOVF        _base+2, 0 
	MOVWF       R6 
	MOVF        _base+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_op1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op1_L0+3 
;Yash BE project.c,993 :: 		if (op1<0)
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main304
;Yash BE project.c,995 :: 		op1=op1*(-1);
	MOVF        main_op1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_op1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op1_L0+3 
;Yash BE project.c,996 :: 		}
L_main304:
;Yash BE project.c,997 :: 		PERCENT=calculator(op1);        //Sampling data after 'interval/1000' and calculating percentto write into memory
	MOVF        main_op1_L0+0, 0 
	MOVWF       R0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       R1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       R2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       R3 
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_calculator_measured+0 
	MOVF        R1, 0 
	MOVWF       FARG_calculator_measured+1 
	CALL        _calculator+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       main_PERCENT_L0+0 
	MOVF        R1, 0 
	MOVWF       main_PERCENT_L0+1 
;Yash BE project.c,998 :: 		pressure=PERCENT;
	MOVF        R0, 0 
	MOVWF       main_pressure_L0+0 
	MOVF        R1, 0 
	MOVWF       main_pressure_L0+1 
;Yash BE project.c,1000 :: 		FloatToStr(op1, output);
	MOVF        main_op1_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_op1_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_op1_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_op1_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,1001 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,1002 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1003 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1005 :: 		if(PERCENT>=threshold)
	MOVF        main_PERCENT_L0+0, 0 
	MOVWF       R0 
	MOVF        main_PERCENT_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        _threshold+0, 0 
	MOVWF       R4 
	MOVF        _threshold+1, 0 
	MOVWF       R5 
	MOVF        _threshold+2, 0 
	MOVWF       R6 
	MOVF        _threshold+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main305
;Yash BE project.c,1007 :: 		if(PERCENT>=limit)
	MOVF        main_PERCENT_L0+0, 0 
	MOVWF       R0 
	MOVF        main_PERCENT_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        main_limit_L0+0, 0 
	MOVWF       R4 
	MOVF        main_limit_L0+1, 0 
	MOVWF       R5 
	MOVF        main_limit_L0+2, 0 
	MOVWF       R6 
	MOVF        main_limit_L0+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main306
;Yash BE project.c,1009 :: 		PORTB.TRISB7=1;
	BSF         PORTB+0, 7 
;Yash BE project.c,1010 :: 		UART1_Write_Text("ALERT!! Over-Pressurized!!!");
	MOVLW       ?lstr22_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr22_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,1011 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1012 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1013 :: 		FloatToStr(pressure, output);
	MOVF        main_pressure_L0+0, 0 
	MOVWF       R0 
	MOVF        main_pressure_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,1014 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,1015 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1016 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1017 :: 		msdelay(2000);            //1 sec buzzer goes on..
	MOVLW       208
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       7
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,1018 :: 		PORTB.TRISB7=0;
	BCF         PORTB+0, 7 
;Yash BE project.c,1019 :: 		}
L_main306:
;Yash BE project.c,1034 :: 		do{
L_main307:
;Yash BE project.c,1035 :: 		op1=masterloop()-base;
	CALL        _masterloop+0, 0
	CALL        _Int2Double+0, 0
	MOVF        _base+0, 0 
	MOVWF       R4 
	MOVF        _base+1, 0 
	MOVWF       R5 
	MOVF        _base+2, 0 
	MOVWF       R6 
	MOVF        _base+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_op1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_op1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_op1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_op1_L0+3 
;Yash BE project.c,1036 :: 		PERCENT=calculator(op1);
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_calculator_measured+0 
	MOVF        R1, 0 
	MOVWF       FARG_calculator_measured+1 
	CALL        _calculator+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       main_PERCENT_L0+0 
	MOVF        R1, 0 
	MOVWF       main_PERCENT_L0+1 
;Yash BE project.c,1037 :: 		}while(PERCENT>threshold);
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _threshold+0, 0 
	MOVWF       R0 
	MOVF        _threshold+1, 0 
	MOVWF       R1 
	MOVF        _threshold+2, 0 
	MOVWF       R2 
	MOVF        _threshold+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main307
;Yash BE project.c,1038 :: 		UART1_Write_Text("Under threshold. Ready for next step.");
	MOVLW       ?lstr23_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr23_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,1039 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1040 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1041 :: 		}
L_main305:
;Yash BE project.c,1043 :: 		msdelay(100);                 // This is the sampling frequency... after 0.1sec
	MOVLW       100
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Yash BE project.c,1064 :: 		UART1_Write_Text("YOUR PRESSURE is : ");
	MOVLW       ?lstr24_Yash_32BE_32project+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr24_Yash_32BE_32project+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,1066 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1067 :: 		FloatToStr(pressure, output);
	MOVF        main_pressure_L0+0, 0 
	MOVWF       R0 
	MOVF        main_pressure_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_output_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Yash BE project.c,1068 :: 		UART1_Write_Text(output);
	MOVLW       main_output_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_output_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Yash BE project.c,1069 :: 		UART1_Write(10);                //LF
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1070 :: 		UART1_Write(13);                //CR
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Yash BE project.c,1090 :: 		}
	GOTO        L_main297
;Yash BE project.c,1092 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

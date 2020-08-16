
_msdelay:

;Door locking system.c,39 :: 		void msdelay (unsigned int itime) //delay
;Door locking system.c,42 :: 		for(i=0; i<itime; i++)
	CLRF        R1 
	CLRF        R2 
L_msdelay0:
	MOVF        FARG_msdelay_itime+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__msdelay134
	MOVF        FARG_msdelay_itime+0, 0 
	SUBWF       R1, 0 
L__msdelay134:
	BTFSC       STATUS+0, 0 
	GOTO        L_msdelay1
;Door locking system.c,43 :: 		for(j=0; j<175; j++);
	CLRF        R3 
	CLRF        R4 
L_msdelay3:
	MOVLW       0
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__msdelay135
	MOVLW       175
	SUBWF       R3, 0 
L__msdelay135:
	BTFSC       STATUS+0, 0 
	GOTO        L_msdelay4
	INFSNZ      R3, 1 
	INCF        R4, 1 
	GOTO        L_msdelay3
L_msdelay4:
;Door locking system.c,42 :: 		for(i=0; i<itime; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;Door locking system.c,43 :: 		for(j=0; j<175; j++);
	GOTO        L_msdelay0
L_msdelay1:
;Door locking system.c,44 :: 		}
L_end_msdelay:
	RETURN      0
; end of _msdelay

_authenticate:

;Door locking system.c,46 :: 		int authenticate(unsigned char password[])
;Door locking system.c,48 :: 		int i,s=0;
	CLRF        authenticate_s_L0+0 
	CLRF        authenticate_s_L0+1 
;Door locking system.c,49 :: 		Lcd_Cmd(_LCD_SECOND_ROW);
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,50 :: 		for(i=0;i<4;i++)                                //Authenticating through many passwords
	CLRF        authenticate_i_L0+0 
	CLRF        authenticate_i_L0+1 
L_authenticate6:
	MOVLW       128
	XORWF       authenticate_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__authenticate137
	MOVLW       4
	SUBWF       authenticate_i_L0+0, 0 
L__authenticate137:
	BTFSC       STATUS+0, 0 
	GOTO        L_authenticate7
;Door locking system.c,52 :: 		if(password[i]==pswd1[i])
	MOVF        authenticate_i_L0+0, 0 
	ADDWF       FARG_authenticate_password+0, 0 
	MOVWF       FSR0 
	MOVF        authenticate_i_L0+1, 0 
	ADDWFC      FARG_authenticate_password+1, 0 
	MOVWF       FSR0H 
	MOVLW       _pswd1+0
	ADDWF       authenticate_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_pswd1+0)
	ADDWFC      authenticate_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_authenticate9
;Door locking system.c,54 :: 		s=s+1;
	INFSNZ      authenticate_s_L0+0, 1 
	INCF        authenticate_s_L0+1, 1 
;Door locking system.c,55 :: 		}
L_authenticate9:
;Door locking system.c,56 :: 		if(s==4)
	MOVLW       0
	XORWF       authenticate_s_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__authenticate138
	MOVLW       4
	XORWF       authenticate_s_L0+0, 0 
L__authenticate138:
	BTFSS       STATUS+0, 2 
	GOTO        L_authenticate10
;Door locking system.c,57 :: 		return (1);
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_authenticate
L_authenticate10:
;Door locking system.c,50 :: 		for(i=0;i<4;i++)                                //Authenticating through many passwords
	INFSNZ      authenticate_i_L0+0, 1 
	INCF        authenticate_i_L0+1, 1 
;Door locking system.c,58 :: 		}
	GOTO        L_authenticate6
L_authenticate7:
;Door locking system.c,59 :: 		Lcd_Cmd(_LCD_CLEAR);                                 //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,60 :: 		s=0;
	CLRF        authenticate_s_L0+0 
	CLRF        authenticate_s_L0+1 
;Door locking system.c,61 :: 		for(i=0;i<4;i++)
	CLRF        authenticate_i_L0+0 
	CLRF        authenticate_i_L0+1 
L_authenticate11:
	MOVLW       128
	XORWF       authenticate_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__authenticate139
	MOVLW       4
	SUBWF       authenticate_i_L0+0, 0 
L__authenticate139:
	BTFSC       STATUS+0, 0 
	GOTO        L_authenticate12
;Door locking system.c,63 :: 		if(password[i]==pswd2[i])
	MOVF        authenticate_i_L0+0, 0 
	ADDWF       FARG_authenticate_password+0, 0 
	MOVWF       FSR0 
	MOVF        authenticate_i_L0+1, 0 
	ADDWFC      FARG_authenticate_password+1, 0 
	MOVWF       FSR0H 
	MOVLW       _pswd2+0
	ADDWF       authenticate_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_pswd2+0)
	ADDWFC      authenticate_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_authenticate14
;Door locking system.c,65 :: 		s=s+1;
	INFSNZ      authenticate_s_L0+0, 1 
	INCF        authenticate_s_L0+1, 1 
;Door locking system.c,66 :: 		}
L_authenticate14:
;Door locking system.c,67 :: 		if(s==4)
	MOVLW       0
	XORWF       authenticate_s_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__authenticate140
	MOVLW       4
	XORWF       authenticate_s_L0+0, 0 
L__authenticate140:
	BTFSS       STATUS+0, 2 
	GOTO        L_authenticate15
;Door locking system.c,68 :: 		return (2);
	MOVLW       2
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_authenticate
L_authenticate15:
;Door locking system.c,61 :: 		for(i=0;i<4;i++)
	INFSNZ      authenticate_i_L0+0, 1 
	INCF        authenticate_i_L0+1, 1 
;Door locking system.c,69 :: 		}
	GOTO        L_authenticate11
L_authenticate12:
;Door locking system.c,70 :: 		Lcd_Cmd(_LCD_CLEAR);                                 //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,71 :: 		s=0;
	CLRF        authenticate_s_L0+0 
	CLRF        authenticate_s_L0+1 
;Door locking system.c,72 :: 		for(i=0;i<4;i++)
	CLRF        authenticate_i_L0+0 
	CLRF        authenticate_i_L0+1 
L_authenticate16:
	MOVLW       128
	XORWF       authenticate_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__authenticate141
	MOVLW       4
	SUBWF       authenticate_i_L0+0, 0 
L__authenticate141:
	BTFSC       STATUS+0, 0 
	GOTO        L_authenticate17
;Door locking system.c,74 :: 		if(password[i]==pswd3[i])
	MOVF        authenticate_i_L0+0, 0 
	ADDWF       FARG_authenticate_password+0, 0 
	MOVWF       FSR0 
	MOVF        authenticate_i_L0+1, 0 
	ADDWFC      FARG_authenticate_password+1, 0 
	MOVWF       FSR0H 
	MOVLW       _pswd3+0
	ADDWF       authenticate_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_pswd3+0)
	ADDWFC      authenticate_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_authenticate19
;Door locking system.c,76 :: 		s=s+1;
	INFSNZ      authenticate_s_L0+0, 1 
	INCF        authenticate_s_L0+1, 1 
;Door locking system.c,77 :: 		}
L_authenticate19:
;Door locking system.c,78 :: 		if(s==4)
	MOVLW       0
	XORWF       authenticate_s_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__authenticate142
	MOVLW       4
	XORWF       authenticate_s_L0+0, 0 
L__authenticate142:
	BTFSS       STATUS+0, 2 
	GOTO        L_authenticate20
;Door locking system.c,79 :: 		return (3);
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_authenticate
L_authenticate20:
;Door locking system.c,72 :: 		for(i=0;i<4;i++)
	INFSNZ      authenticate_i_L0+0, 1 
	INCF        authenticate_i_L0+1, 1 
;Door locking system.c,80 :: 		}
	GOTO        L_authenticate16
L_authenticate17:
;Door locking system.c,81 :: 		Lcd_Cmd(_LCD_CLEAR);                                 //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,82 :: 		s=0;
	CLRF        authenticate_s_L0+0 
	CLRF        authenticate_s_L0+1 
;Door locking system.c,83 :: 		for(i=0;i<4;i++)
	CLRF        authenticate_i_L0+0 
	CLRF        authenticate_i_L0+1 
L_authenticate21:
	MOVLW       128
	XORWF       authenticate_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__authenticate143
	MOVLW       4
	SUBWF       authenticate_i_L0+0, 0 
L__authenticate143:
	BTFSC       STATUS+0, 0 
	GOTO        L_authenticate22
;Door locking system.c,85 :: 		if(password[i]==pswd4[i])
	MOVF        authenticate_i_L0+0, 0 
	ADDWF       FARG_authenticate_password+0, 0 
	MOVWF       FSR0 
	MOVF        authenticate_i_L0+1, 0 
	ADDWFC      FARG_authenticate_password+1, 0 
	MOVWF       FSR0H 
	MOVLW       _pswd4+0
	ADDWF       authenticate_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_pswd4+0)
	ADDWFC      authenticate_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_authenticate24
;Door locking system.c,87 :: 		s=s+1;
	INFSNZ      authenticate_s_L0+0, 1 
	INCF        authenticate_s_L0+1, 1 
;Door locking system.c,88 :: 		}
L_authenticate24:
;Door locking system.c,89 :: 		if(s==4)
	MOVLW       0
	XORWF       authenticate_s_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__authenticate144
	MOVLW       4
	XORWF       authenticate_s_L0+0, 0 
L__authenticate144:
	BTFSS       STATUS+0, 2 
	GOTO        L_authenticate25
;Door locking system.c,90 :: 		return (4);
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_authenticate
L_authenticate25:
;Door locking system.c,83 :: 		for(i=0;i<4;i++)
	INFSNZ      authenticate_i_L0+0, 1 
	INCF        authenticate_i_L0+1, 1 
;Door locking system.c,91 :: 		}
	GOTO        L_authenticate21
L_authenticate22:
;Door locking system.c,92 :: 		}
L_end_authenticate:
	RETURN      0
; end of _authenticate

_scan:

;Door locking system.c,94 :: 		void scan(void)
;Door locking system.c,96 :: 		COL = 0xF0;
	MOVLW       240
	MOVWF       PORTD+0 
;Door locking system.c,98 :: 		do
L_scan26:
;Door locking system.c,100 :: 		ROW = 0xF0;
	MOVLW       240
	MOVWF       PORTD+0 
;Door locking system.c,101 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       _colloc+0 
;Door locking system.c,102 :: 		colloc &= 0xF0;                                                        //Check location of column which is pressed
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _colloc+0 
;Door locking system.c,103 :: 		}while(colloc != 0xF0);
	MOVF        R1, 0 
	XORLW       240
	BTFSS       STATUS+0, 2 
	GOTO        L_scan26
;Door locking system.c,105 :: 		do
L_scan29:
;Door locking system.c,107 :: 		do
L_scan32:
;Door locking system.c,109 :: 		msdelay(50);                                                  //wait for key to be pressed
	MOVLW       50
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,110 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       _colloc+0 
;Door locking system.c,111 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _colloc+0 
;Door locking system.c,112 :: 		}while(colloc == 0xF0);                                       //gets out of loop when key is pressed n now enters for checking of key debouncing
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_scan32
;Door locking system.c,114 :: 		msdelay(20);                                                           //Check for debouncing
	MOVLW       20
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,115 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       _colloc+0 
;Door locking system.c,116 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _colloc+0 
;Door locking system.c,117 :: 		} while(colloc == 0xF0);
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_scan29
;Door locking system.c,123 :: 		ROW = 0xFE;                            //Check for rows 1, 2, 3, 4 in sequence.
	MOVLW       254
	MOVWF       PORTD+0 
;Door locking system.c,124 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       _colloc+0 
;Door locking system.c,125 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _colloc+0 
;Door locking system.c,126 :: 		if(colloc != 0xF0)
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_scan37
;Door locking system.c,128 :: 		rowloc = 0;
	CLRF        _rowloc+0 
;Door locking system.c,129 :: 		break;
	GOTO        L_scan36
;Door locking system.c,130 :: 		}
L_scan37:
;Door locking system.c,131 :: 		ROW = 0xFD;
	MOVLW       253
	MOVWF       PORTD+0 
;Door locking system.c,132 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       _colloc+0 
;Door locking system.c,133 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _colloc+0 
;Door locking system.c,134 :: 		if(colloc != 0xF0)
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_scan38
;Door locking system.c,136 :: 		rowloc = 1;
	MOVLW       1
	MOVWF       _rowloc+0 
;Door locking system.c,137 :: 		break;
	GOTO        L_scan36
;Door locking system.c,138 :: 		}
L_scan38:
;Door locking system.c,139 :: 		ROW = 0xFB;
	MOVLW       251
	MOVWF       PORTD+0 
;Door locking system.c,140 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       _colloc+0 
;Door locking system.c,141 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _colloc+0 
;Door locking system.c,142 :: 		if(colloc != 0xF0)
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_scan39
;Door locking system.c,144 :: 		rowloc = 2;
	MOVLW       2
	MOVWF       _rowloc+0 
;Door locking system.c,145 :: 		break;
	GOTO        L_scan36
;Door locking system.c,146 :: 		}
L_scan39:
;Door locking system.c,147 :: 		ROW = 0xF7;
	MOVLW       247
	MOVWF       PORTD+0 
;Door locking system.c,148 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       _colloc+0 
;Door locking system.c,149 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       _colloc+0 
;Door locking system.c,150 :: 		rowloc = 3;
	MOVLW       3
	MOVWF       _rowloc+0 
;Door locking system.c,153 :: 		}
L_scan36:
;Door locking system.c,154 :: 		}
L_end_scan:
	RETURN      0
; end of _scan

_readEEPROM:

;Door locking system.c,156 :: 		unsigned char readEEPROM(unsigned char address)                      //Routine to read from memory
;Door locking system.c,158 :: 		EEADR =address;
	MOVF        FARG_readEEPROM_address+0, 0 
	MOVWF       EEADR+0 
;Door locking system.c,159 :: 		EECON1.EEPGD=0;
	BCF         EECON1+0, 7 
;Door locking system.c,160 :: 		EECON1.RD=1;
	BSF         EECON1+0, 0 
;Door locking system.c,161 :: 		return EEDATA;
	MOVF        EEDATA+0, 0 
	MOVWF       R0 
;Door locking system.c,162 :: 		}
L_end_readEEPROM:
	RETURN      0
; end of _readEEPROM

_writeEEPROM:

;Door locking system.c,164 :: 		void writeEEPROM(unsigned char address,unsigned char datas)           //Routine to write to memory
;Door locking system.c,167 :: 		EEADR=address;
	MOVF        FARG_writeEEPROM_address+0, 0 
	MOVWF       EEADR+0 
;Door locking system.c,168 :: 		EEDATA=datas;
	MOVF        FARG_writeEEPROM_datas+0, 0 
	MOVWF       EEDATA+0 
;Door locking system.c,169 :: 		EECON1.EEPGD=0;
	BCF         EECON1+0, 7 
;Door locking system.c,170 :: 		EECON1.WREN=1;
	BSF         EECON1+0, 2 
;Door locking system.c,171 :: 		INTCON_SAVE=INTCON;
	MOVF        INTCON+0, 0 
	MOVWF       R0 
;Door locking system.c,172 :: 		INTCON=0;
	CLRF        INTCON+0 
;Door locking system.c,173 :: 		EECON2=0x55;
	MOVLW       85
	MOVWF       EECON2+0 
;Door locking system.c,174 :: 		EECON2=0xAA;
	MOVLW       170
	MOVWF       EECON2+0 
;Door locking system.c,175 :: 		EECON1.WR=1;
	BSF         EECON1+0, 1 
;Door locking system.c,176 :: 		INTCON=INTCON_SAVE;
	MOVF        R0, 0 
	MOVWF       INTCON+0 
;Door locking system.c,177 :: 		EECON1.WREN=0;
	BCF         EECON1+0, 2 
;Door locking system.c,178 :: 		while(PIR2.EEIF==0)
L_writeEEPROM40:
	BTFSC       PIR2+0, 4 
	GOTO        L_writeEEPROM41
;Door locking system.c,180 :: 		asm nop;
	NOP
;Door locking system.c,181 :: 		}
	GOTO        L_writeEEPROM40
L_writeEEPROM41:
;Door locking system.c,182 :: 		PIR2.EEIF=0;
	BCF         PIR2+0, 4 
;Door locking system.c,183 :: 		}
L_end_writeEEPROM:
	RETURN      0
; end of _writeEEPROM

_memory:

;Door locking system.c,186 :: 		void memory(unsigned int mem_add,unsigned char dat[4])
;Door locking system.c,191 :: 		Lcd_Cmd(_LCD_CLEAR);                        //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,192 :: 		Lcd_Out(1, 1, "Data to be written is: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,193 :: 		Lcd_Out(2, 1, dat);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        FARG_memory_dat+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        FARG_memory_dat+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,194 :: 		Data[0]=dat[0]-48;           //Converting into ASCII so tht it can be stored into the PIC memory
	MOVFF       FARG_memory_dat+0, FSR0
	MOVFF       FARG_memory_dat+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       memory_Data_L0+0 
;Door locking system.c,195 :: 		Data[1]=dat[1]-48;
	MOVLW       1
	ADDWF       FARG_memory_dat+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_memory_dat+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       memory_Data_L0+1 
;Door locking system.c,196 :: 		Data[2]=dat[2]-48;
	MOVLW       2
	ADDWF       FARG_memory_dat+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_memory_dat+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       memory_Data_L0+2 
;Door locking system.c,197 :: 		Data[3]=dat[3]-48;
	MOVLW       3
	ADDWF       FARG_memory_dat+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_memory_dat+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       memory_Data_L0+3 
;Door locking system.c,198 :: 		msdelay(500);
	MOVLW       244
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,199 :: 		switch(mem_add)
	GOTO        L_memory42
;Door locking system.c,201 :: 		case 1:
L_memory44:
;Door locking system.c,202 :: 		for(i=0;i<4;i++)
	CLRF        memory_i_L0+0 
L_memory45:
	MOVLW       4
	SUBWF       memory_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_memory46
;Door locking system.c,204 :: 		writeEEPROM(mem_add+i, Data[i]);
	MOVF        memory_i_L0+0, 0 
	ADDWF       FARG_memory_mem_add+0, 0 
	MOVWF       FARG_writeEEPROM_address+0 
	MOVLW       memory_Data_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(memory_Data_L0+0)
	MOVWF       FSR0H 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeEEPROM_datas+0 
	CALL        _writeEEPROM+0, 0
;Door locking system.c,205 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,206 :: 		pswd1[i]     = readEEPROM(mem_add+i) + 48;
	MOVLW       _pswd1+0
	MOVWF       FLOC__memory+0 
	MOVLW       hi_addr(_pswd1+0)
	MOVWF       FLOC__memory+1 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FLOC__memory+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__memory+1, 1 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FARG_memory_mem_add+0, 0 
	MOVWF       FARG_readEEPROM_address+0 
	CALL        _readEEPROM+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__memory+0, FSR1
	MOVFF       FLOC__memory+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,207 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,202 :: 		for(i=0;i<4;i++)
	INCF        memory_i_L0+0, 1 
;Door locking system.c,208 :: 		}
	GOTO        L_memory45
L_memory46:
;Door locking system.c,209 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,210 :: 		Lcd_Out(1, 1, "Your new P1: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,211 :: 		Lcd_Out(2, 1, pswd1);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _pswd1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_pswd1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,212 :: 		msdelay(2000);
	MOVLW       208
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       7
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,213 :: 		break;
	GOTO        L_memory43
;Door locking system.c,214 :: 		case 2:
L_memory48:
;Door locking system.c,215 :: 		for(i=0;i<4;i++)
	CLRF        memory_i_L0+0 
L_memory49:
	MOVLW       4
	SUBWF       memory_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_memory50
;Door locking system.c,217 :: 		writeEEPROM(mem_add+i, Data[i]);
	MOVF        memory_i_L0+0, 0 
	ADDWF       FARG_memory_mem_add+0, 0 
	MOVWF       FARG_writeEEPROM_address+0 
	MOVLW       memory_Data_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(memory_Data_L0+0)
	MOVWF       FSR0H 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeEEPROM_datas+0 
	CALL        _writeEEPROM+0, 0
;Door locking system.c,218 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,219 :: 		pswd2[i]     = readEEPROM(mem_add+i) + 48;
	MOVLW       _pswd2+0
	MOVWF       FLOC__memory+0 
	MOVLW       hi_addr(_pswd2+0)
	MOVWF       FLOC__memory+1 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FLOC__memory+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__memory+1, 1 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FARG_memory_mem_add+0, 0 
	MOVWF       FARG_readEEPROM_address+0 
	CALL        _readEEPROM+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__memory+0, FSR1
	MOVFF       FLOC__memory+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,220 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,215 :: 		for(i=0;i<4;i++)
	INCF        memory_i_L0+0, 1 
;Door locking system.c,221 :: 		}
	GOTO        L_memory49
L_memory50:
;Door locking system.c,222 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,223 :: 		Lcd_Out(1, 1, "Your new P2: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,224 :: 		Lcd_Out(2, 1, pswd2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _pswd2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_pswd2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,225 :: 		msdelay(2000);
	MOVLW       208
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       7
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,226 :: 		break;
	GOTO        L_memory43
;Door locking system.c,227 :: 		case 3:
L_memory52:
;Door locking system.c,228 :: 		for(i=0;i<4;i++)
	CLRF        memory_i_L0+0 
L_memory53:
	MOVLW       4
	SUBWF       memory_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_memory54
;Door locking system.c,230 :: 		writeEEPROM(mem_add+i, Data[i]);
	MOVF        memory_i_L0+0, 0 
	ADDWF       FARG_memory_mem_add+0, 0 
	MOVWF       FARG_writeEEPROM_address+0 
	MOVLW       memory_Data_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(memory_Data_L0+0)
	MOVWF       FSR0H 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeEEPROM_datas+0 
	CALL        _writeEEPROM+0, 0
;Door locking system.c,231 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,232 :: 		pswd3[i]     = readEEPROM(mem_add+i) + 48;
	MOVLW       _pswd3+0
	MOVWF       FLOC__memory+0 
	MOVLW       hi_addr(_pswd3+0)
	MOVWF       FLOC__memory+1 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FLOC__memory+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__memory+1, 1 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FARG_memory_mem_add+0, 0 
	MOVWF       FARG_readEEPROM_address+0 
	CALL        _readEEPROM+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__memory+0, FSR1
	MOVFF       FLOC__memory+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,233 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,228 :: 		for(i=0;i<4;i++)
	INCF        memory_i_L0+0, 1 
;Door locking system.c,234 :: 		}
	GOTO        L_memory53
L_memory54:
;Door locking system.c,235 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,236 :: 		Lcd_Out(1, 1, "Your new P3: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,237 :: 		Lcd_Out(2, 1, pswd3);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _pswd3+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_pswd3+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,238 :: 		msdelay(2000);
	MOVLW       208
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       7
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,239 :: 		break;;
	GOTO        L_memory43
;Door locking system.c,240 :: 		case 4:
L_memory56:
;Door locking system.c,241 :: 		for(i=0;i<4;i++)
	CLRF        memory_i_L0+0 
L_memory57:
	MOVLW       4
	SUBWF       memory_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_memory58
;Door locking system.c,243 :: 		writeEEPROM(mem_add+i, Data[i]);
	MOVF        memory_i_L0+0, 0 
	ADDWF       FARG_memory_mem_add+0, 0 
	MOVWF       FARG_writeEEPROM_address+0 
	MOVLW       memory_Data_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(memory_Data_L0+0)
	MOVWF       FSR0H 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_writeEEPROM_datas+0 
	CALL        _writeEEPROM+0, 0
;Door locking system.c,244 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,245 :: 		pswd4[i]     = readEEPROM(mem_add+i) + 48;
	MOVLW       _pswd4+0
	MOVWF       FLOC__memory+0 
	MOVLW       hi_addr(_pswd4+0)
	MOVWF       FLOC__memory+1 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FLOC__memory+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__memory+1, 1 
	MOVF        memory_i_L0+0, 0 
	ADDWF       FARG_memory_mem_add+0, 0 
	MOVWF       FARG_readEEPROM_address+0 
	CALL        _readEEPROM+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__memory+0, FSR1
	MOVFF       FLOC__memory+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,246 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,241 :: 		for(i=0;i<4;i++)
	INCF        memory_i_L0+0, 1 
;Door locking system.c,247 :: 		}
	GOTO        L_memory57
L_memory58:
;Door locking system.c,248 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,249 :: 		Lcd_Out(1, 1, "Your new P4: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,250 :: 		Lcd_Out(2, 1, pswd4);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _pswd4+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_pswd4+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,251 :: 		msdelay(2000);
	MOVLW       208
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       7
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,252 :: 		break;
	GOTO        L_memory43
;Door locking system.c,253 :: 		}
L_memory42:
	MOVLW       0
	XORWF       FARG_memory_mem_add+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__memory149
	MOVLW       1
	XORWF       FARG_memory_mem_add+0, 0 
L__memory149:
	BTFSC       STATUS+0, 2 
	GOTO        L_memory44
	MOVLW       0
	XORWF       FARG_memory_mem_add+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__memory150
	MOVLW       2
	XORWF       FARG_memory_mem_add+0, 0 
L__memory150:
	BTFSC       STATUS+0, 2 
	GOTO        L_memory48
	MOVLW       0
	XORWF       FARG_memory_mem_add+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__memory151
	MOVLW       3
	XORWF       FARG_memory_mem_add+0, 0 
L__memory151:
	BTFSC       STATUS+0, 2 
	GOTO        L_memory52
	MOVLW       0
	XORWF       FARG_memory_mem_add+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__memory152
	MOVLW       4
	XORWF       FARG_memory_mem_add+0, 0 
L__memory152:
	BTFSC       STATUS+0, 2 
	GOTO        L_memory56
L_memory43:
;Door locking system.c,254 :: 		}
L_end_memory:
	RETURN      0
; end of _memory

_menu:

;Door locking system.c,256 :: 		int menu()
;Door locking system.c,261 :: 		Lcd_Cmd(_LCD_CLEAR);                        //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,262 :: 		Lcd_Out(2, 1, "1.Unlock 2.Reset");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,263 :: 		Lcd_Out(1, 1, "You wish to : ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,266 :: 		COL = 0xF0;
	MOVLW       240
	MOVWF       PORTD+0 
;Door locking system.c,267 :: 		rowloc=15;                //randomly set for avoiding its default value used furthur..
	MOVLW       15
	MOVWF       _rowloc+0 
;Door locking system.c,268 :: 		do
L_menu60:
;Door locking system.c,270 :: 		ROW = 0xF0;
	MOVLW       240
	MOVWF       PORTD+0 
;Door locking system.c,271 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,272 :: 		colloc &= 0xF0;            //Check location of column which is pressed
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,273 :: 		}while(colloc != 0xF0);
	MOVF        R1, 0 
	XORLW       240
	BTFSS       STATUS+0, 2 
	GOTO        L_menu60
;Door locking system.c,275 :: 		do
L_menu63:
;Door locking system.c,277 :: 		do
L_menu66:
;Door locking system.c,279 :: 		msdelay(50);      //wait for key to be pressed
	MOVLW       50
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,280 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,281 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,282 :: 		}while(colloc == 0xF0);           //gets out of loop when key is pressed n now enters for checking of key debouncing
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_menu66
;Door locking system.c,284 :: 		msdelay(20);                               //Check for debouncing
	MOVLW       20
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,285 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,286 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,287 :: 		} while(colloc == 0xF0);
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_menu63
;Door locking system.c,293 :: 		ROW = 0xFE;                                 //Check for rows 1, 2, 3, 4 in sequence.
	MOVLW       254
	MOVWF       PORTD+0 
;Door locking system.c,294 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,295 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,296 :: 		if(colloc != 0xF0)                //scan only 1st row... n set rowloc to 0.. which is used as a condition check furthur
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_menu71
;Door locking system.c,298 :: 		rowloc = 5;             //to avoid usage of garbage val taken as zero. so randomly taken as 5
	MOVLW       5
	MOVWF       _rowloc+0 
;Door locking system.c,299 :: 		break;
	GOTO        L_menu70
;Door locking system.c,300 :: 		}
L_menu71:
;Door locking system.c,301 :: 		ROW = 0xFD;
	MOVLW       253
	MOVWF       PORTD+0 
;Door locking system.c,302 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,303 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,304 :: 		if(colloc != 0xF0)                  //if other than 1st row is pressed then display INVALID KEYPRESS...
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_menu72
;Door locking system.c,306 :: 		Lcd_Cmd(_LCD_CLEAR);        //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,307 :: 		Lcd_Out(1, 1, "Invalid Keypress");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,308 :: 		break;
	GOTO        L_menu70
;Door locking system.c,309 :: 		}
L_menu72:
;Door locking system.c,310 :: 		ROW = 0xFB;
	MOVLW       251
	MOVWF       PORTD+0 
;Door locking system.c,311 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,312 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,313 :: 		if(colloc != 0xF0)
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_menu73
;Door locking system.c,315 :: 		Lcd_Cmd(_LCD_CLEAR);        //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,316 :: 		Lcd_Out(1, 1, "Invalid Keypress");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,317 :: 		break;
	GOTO        L_menu70
;Door locking system.c,318 :: 		}
L_menu73:
;Door locking system.c,319 :: 		ROW = 0xF7;
	MOVLW       247
	MOVWF       PORTD+0 
;Door locking system.c,320 :: 		colloc = COL;
	MOVF        PORTD+0, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,321 :: 		colloc &= 0xF0;
	MOVLW       240
	ANDWF       PORTD+0, 0 
	MOVWF       menu_colloc_L0+0 
;Door locking system.c,323 :: 		Lcd_Cmd(_LCD_CLEAR);        //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,324 :: 		Lcd_Out(1, 1, "Invalid Keypress");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,327 :: 		}
L_menu70:
;Door locking system.c,330 :: 		if(colloc == 0xE0 & rowloc==5)                // here the rowloc value is used to confirm that key pressed belongs to only 1st row.
	MOVF        menu_colloc_L0+0, 0 
	XORLW       224
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _rowloc+0, 0 
	XORLW       5
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menu74
;Door locking system.c,332 :: 		Lcd_Cmd(_LCD_CLEAR);        //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,333 :: 		Lcd_Out(1, 1, "Invalid Keypress");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,334 :: 		}
L_menu74:
;Door locking system.c,335 :: 		if(colloc == 0xD0 & rowloc==5)                //rowloc value is used everywhere to check for all 4 keys of 1st row...
	MOVF        menu_colloc_L0+0, 0 
	XORLW       208
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _rowloc+0, 0 
	XORLW       5
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menu75
;Door locking system.c,337 :: 		Lcd_Out_Cp("1");
	MOVLW       ?lstr12_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr12_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,338 :: 		value=1;
	MOVLW       1
	MOVWF       menu_value_L0+0 
	MOVLW       0
	MOVWF       menu_value_L0+1 
;Door locking system.c,339 :: 		}
L_menu75:
;Door locking system.c,340 :: 		if(colloc == 0xB0 & rowloc==5)
	MOVF        menu_colloc_L0+0, 0 
	XORLW       176
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _rowloc+0, 0 
	XORLW       5
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menu76
;Door locking system.c,342 :: 		Lcd_Out_Cp("2");
	MOVLW       ?lstr13_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr13_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,343 :: 		value=2;
	MOVLW       2
	MOVWF       menu_value_L0+0 
	MOVLW       0
	MOVWF       menu_value_L0+1 
;Door locking system.c,344 :: 		}
L_menu76:
;Door locking system.c,345 :: 		if(colloc == 0x70 & rowloc==5)
	MOVF        menu_colloc_L0+0, 0 
	XORLW       112
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        _rowloc+0, 0 
	XORLW       5
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_menu77
;Door locking system.c,347 :: 		Lcd_Cmd(_LCD_CLEAR);      //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,348 :: 		Lcd_Out(1, 1, "Invalid Keypress");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,349 :: 		}
L_menu77:
;Door locking system.c,350 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,352 :: 		return (value);
	MOVF        menu_value_L0+0, 0 
	MOVWF       R0 
	MOVF        menu_value_L0+1, 0 
	MOVWF       R1 
;Door locking system.c,353 :: 		}
L_end_menu:
	RETURN      0
; end of _menu

_Reset_routine:

;Door locking system.c,355 :: 		void Reset_routine()
;Door locking system.c,358 :: 		int i=0,ch,x=0,check,y;
	CLRF        Reset_routine_i_L0+0 
	CLRF        Reset_routine_i_L0+1 
	CLRF        Reset_routine_x_L0+0 
	CLRF        Reset_routine_x_L0+1 
;Door locking system.c,359 :: 		Lcd_Cmd(_LCD_CLEAR);                    // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,360 :: 		Lcd_Out(1, 1, "Verify yourself!");      //Displaying "Verify yourself!"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,362 :: 		Lcd_Cmd(_LCD_SECOND_ROW);               //Second line..
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,363 :: 		for(i=0;i<4;i++)      //getting the password first for verification
	CLRF        Reset_routine_i_L0+0 
	CLRF        Reset_routine_i_L0+1 
L_Reset_routine78:
	MOVLW       128
	XORWF       Reset_routine_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine155
	MOVLW       4
	SUBWF       Reset_routine_i_L0+0, 0 
L__Reset_routine155:
	BTFSC       STATUS+0, 0 
	GOTO        L_Reset_routine79
;Door locking system.c,365 :: 		scan();
	CALL        _scan+0, 0
;Door locking system.c,366 :: 		if(colloc == 0xE0)
	MOVF        _colloc+0, 0 
	XORLW       224
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine81
;Door locking system.c,368 :: 		Lcd_Chr_Cp('*');                        //Displaying data as ****.
	MOVLW       42
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Door locking system.c,369 :: 		entry[i]=keypad[rowloc][0];             //storing simultaneously into array 'entry'
	MOVLW       Reset_routine_entry_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_entry_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,370 :: 		continue;
	GOTO        L_Reset_routine80
;Door locking system.c,371 :: 		}
L_Reset_routine81:
;Door locking system.c,372 :: 		if(colloc == 0xD0)
	MOVF        _colloc+0, 0 
	XORLW       208
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine82
;Door locking system.c,374 :: 		Lcd_Chr_Cp('*');
	MOVLW       42
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Door locking system.c,375 :: 		entry[i]=keypad[rowloc][1];
	MOVLW       Reset_routine_entry_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_entry_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,376 :: 		continue;
	GOTO        L_Reset_routine80
;Door locking system.c,377 :: 		}
L_Reset_routine82:
;Door locking system.c,378 :: 		if(colloc == 0xB0)
	MOVF        _colloc+0, 0 
	XORLW       176
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine83
;Door locking system.c,380 :: 		Lcd_Chr_Cp('*');
	MOVLW       42
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Door locking system.c,381 :: 		entry[i]=keypad[rowloc][2];
	MOVLW       Reset_routine_entry_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_entry_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,382 :: 		continue;
	GOTO        L_Reset_routine80
;Door locking system.c,383 :: 		}
L_Reset_routine83:
;Door locking system.c,384 :: 		if(colloc == 0x70)
	MOVF        _colloc+0, 0 
	XORLW       112
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine84
;Door locking system.c,386 :: 		Lcd_Chr_Cp('*');
	MOVLW       42
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Door locking system.c,387 :: 		entry[i]=keypad[rowloc][3];
	MOVLW       Reset_routine_entry_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_entry_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,389 :: 		continue;
	GOTO        L_Reset_routine80
;Door locking system.c,390 :: 		}
L_Reset_routine84:
;Door locking system.c,392 :: 		}                        //for loop ends here
L_Reset_routine80:
;Door locking system.c,363 :: 		for(i=0;i<4;i++)      //getting the password first for verification
	INFSNZ      Reset_routine_i_L0+0, 1 
	INCF        Reset_routine_i_L0+1, 1 
;Door locking system.c,392 :: 		}                        //for loop ends here
	GOTO        L_Reset_routine78
L_Reset_routine79:
;Door locking system.c,394 :: 		x=authenticate(entry);
	MOVLW       Reset_routine_entry_L0+0
	MOVWF       FARG_authenticate_password+0 
	MOVLW       hi_addr(Reset_routine_entry_L0+0)
	MOVWF       FARG_authenticate_password+1 
	CALL        _authenticate+0, 0
	MOVF        R0, 0 
	MOVWF       Reset_routine_x_L0+0 
	MOVF        R1, 0 
	MOVWF       Reset_routine_x_L0+1 
;Door locking system.c,396 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,397 :: 		if(x==4 || x==3 || x==2 || x==1)
	MOVLW       0
	XORWF       Reset_routine_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine156
	MOVLW       4
	XORWF       Reset_routine_x_L0+0, 0 
L__Reset_routine156:
	BTFSC       STATUS+0, 2 
	GOTO        L__Reset_routine131
	MOVLW       0
	XORWF       Reset_routine_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine157
	MOVLW       3
	XORWF       Reset_routine_x_L0+0, 0 
L__Reset_routine157:
	BTFSC       STATUS+0, 2 
	GOTO        L__Reset_routine131
	MOVLW       0
	XORWF       Reset_routine_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine158
	MOVLW       2
	XORWF       Reset_routine_x_L0+0, 0 
L__Reset_routine158:
	BTFSC       STATUS+0, 2 
	GOTO        L__Reset_routine131
	MOVLW       0
	XORWF       Reset_routine_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine159
	MOVLW       1
	XORWF       Reset_routine_x_L0+0, 0 
L__Reset_routine159:
	BTFSC       STATUS+0, 2 
	GOTO        L__Reset_routine131
	GOTO        L_Reset_routine87
L__Reset_routine131:
;Door locking system.c,399 :: 		Lcd_Out(1, 1, "Enter new password");      //Displaying "Enter new password"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,400 :: 		Lcd_Cmd(_LCD_SECOND_ROW);                         //next Line
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,401 :: 		for(i=0;i<4;i++)
	CLRF        Reset_routine_i_L0+0 
	CLRF        Reset_routine_i_L0+1 
L_Reset_routine88:
	MOVLW       128
	XORWF       Reset_routine_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine160
	MOVLW       4
	SUBWF       Reset_routine_i_L0+0, 0 
L__Reset_routine160:
	BTFSC       STATUS+0, 0 
	GOTO        L_Reset_routine89
;Door locking system.c,403 :: 		scan();
	CALL        _scan+0, 0
;Door locking system.c,404 :: 		if(colloc == 0xE0)
	MOVF        _colloc+0, 0 
	XORLW       224
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine91
;Door locking system.c,406 :: 		Lcd_Out_Cp("*");                                  //Displaying data as ****.
	MOVLW       ?lstr17_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr17_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,407 :: 		recheckagain[i]=keypad[rowloc][0];                //storing simultaneously into array 'recheck1'
	MOVLW       Reset_routine_recheckagain_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_recheckagain_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,408 :: 		continue;
	GOTO        L_Reset_routine90
;Door locking system.c,409 :: 		}
L_Reset_routine91:
;Door locking system.c,410 :: 		if(colloc == 0xD0)
	MOVF        _colloc+0, 0 
	XORLW       208
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine92
;Door locking system.c,412 :: 		Lcd_Out_Cp("*");
	MOVLW       ?lstr18_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr18_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,413 :: 		recheckagain[i]=keypad[rowloc][1];
	MOVLW       Reset_routine_recheckagain_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_recheckagain_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,414 :: 		continue;
	GOTO        L_Reset_routine90
;Door locking system.c,415 :: 		}
L_Reset_routine92:
;Door locking system.c,416 :: 		if(colloc == 0xB0)
	MOVF        _colloc+0, 0 
	XORLW       176
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine93
;Door locking system.c,418 :: 		Lcd_Out_Cp("*");
	MOVLW       ?lstr19_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr19_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,419 :: 		recheckagain[i]=keypad[rowloc][2];
	MOVLW       Reset_routine_recheckagain_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_recheckagain_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,420 :: 		continue;
	GOTO        L_Reset_routine90
;Door locking system.c,421 :: 		}
L_Reset_routine93:
;Door locking system.c,422 :: 		if(colloc == 0x70)
	MOVF        _colloc+0, 0 
	XORLW       112
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine94
;Door locking system.c,424 :: 		Lcd_Out_Cp("*");
	MOVLW       ?lstr20_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr20_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,425 :: 		recheckagain[i]=keypad[rowloc][3];
	MOVLW       Reset_routine_recheckagain_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_recheckagain_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,427 :: 		continue;
	GOTO        L_Reset_routine90
;Door locking system.c,428 :: 		}
L_Reset_routine94:
;Door locking system.c,430 :: 		}                                //for loop ends here
L_Reset_routine90:
;Door locking system.c,401 :: 		for(i=0;i<4;i++)
	INFSNZ      Reset_routine_i_L0+0, 1 
	INCF        Reset_routine_i_L0+1, 1 
;Door locking system.c,430 :: 		}                                //for loop ends here
	GOTO        L_Reset_routine88
L_Reset_routine89:
;Door locking system.c,433 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,434 :: 		Lcd_Out(1, 1, recheckagain);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       Reset_routine_recheckagain_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(Reset_routine_recheckagain_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,435 :: 		msdelay(500);
	MOVLW       244
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,436 :: 		Lcd_Out(1, 1, "RE-ENTER your PSWD");                      //Displaying "RE-ENTER PSWD"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr21_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr21_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,437 :: 		Lcd_Cmd(_LCD_SECOND_ROW);                                 //Second line..
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,438 :: 		for(i=0;i<4;i++)                          //Re-checking procedure of new password
	CLRF        Reset_routine_i_L0+0 
	CLRF        Reset_routine_i_L0+1 
L_Reset_routine95:
	MOVLW       128
	XORWF       Reset_routine_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine161
	MOVLW       4
	SUBWF       Reset_routine_i_L0+0, 0 
L__Reset_routine161:
	BTFSC       STATUS+0, 0 
	GOTO        L_Reset_routine96
;Door locking system.c,441 :: 		scan();
	CALL        _scan+0, 0
;Door locking system.c,443 :: 		if(colloc == 0xE0)
	MOVF        _colloc+0, 0 
	XORLW       224
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine98
;Door locking system.c,445 :: 		Lcd_Out_Cp("*");                             //Displaying data as ****.
	MOVLW       ?lstr22_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr22_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,446 :: 		recheck[i]=keypad[rowloc][0];                //storing simultaneously into array 'recheck'
	MOVLW       Reset_routine_recheck_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_recheck_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,447 :: 		continue;
	GOTO        L_Reset_routine97
;Door locking system.c,448 :: 		}
L_Reset_routine98:
;Door locking system.c,449 :: 		if(colloc == 0xD0)
	MOVF        _colloc+0, 0 
	XORLW       208
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine99
;Door locking system.c,451 :: 		Lcd_Out_Cp("*");
	MOVLW       ?lstr23_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr23_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,452 :: 		recheck[i]=keypad[rowloc][1];
	MOVLW       Reset_routine_recheck_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_recheck_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,453 :: 		continue;
	GOTO        L_Reset_routine97
;Door locking system.c,454 :: 		}
L_Reset_routine99:
;Door locking system.c,455 :: 		if(colloc == 0xB0)
	MOVF        _colloc+0, 0 
	XORLW       176
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine100
;Door locking system.c,457 :: 		Lcd_Out_Cp("*");
	MOVLW       ?lstr24_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr24_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,458 :: 		recheck[i]=keypad[rowloc][2];
	MOVLW       Reset_routine_recheck_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_recheck_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,459 :: 		continue;
	GOTO        L_Reset_routine97
;Door locking system.c,460 :: 		}
L_Reset_routine100:
;Door locking system.c,461 :: 		if(colloc == 0x70)
	MOVF        _colloc+0, 0 
	XORLW       112
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine101
;Door locking system.c,463 :: 		Lcd_Out_Cp("*");
	MOVLW       ?lstr25_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr25_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,464 :: 		recheck[i]=keypad[rowloc][3];
	MOVLW       Reset_routine_recheck_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Reset_routine_recheck_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,465 :: 		continue;
	GOTO        L_Reset_routine97
;Door locking system.c,466 :: 		}
L_Reset_routine101:
;Door locking system.c,468 :: 		}                                //for loop ends here
L_Reset_routine97:
;Door locking system.c,438 :: 		for(i=0;i<4;i++)                          //Re-checking procedure of new password
	INFSNZ      Reset_routine_i_L0+0, 1 
	INCF        Reset_routine_i_L0+1, 1 
;Door locking system.c,468 :: 		}                                //for loop ends here
	GOTO        L_Reset_routine95
L_Reset_routine96:
;Door locking system.c,470 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,471 :: 		Lcd_Out(2, 1, recheck);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       Reset_routine_recheck_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(Reset_routine_recheck_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,472 :: 		msdelay(500);
	MOVLW       244
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,473 :: 		check=0;
	CLRF        Reset_routine_check_L0+0 
	CLRF        Reset_routine_check_L0+1 
;Door locking system.c,474 :: 		for(i=0;i<4;i++)
	CLRF        Reset_routine_i_L0+0 
	CLRF        Reset_routine_i_L0+1 
L_Reset_routine102:
	MOVLW       128
	XORWF       Reset_routine_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine162
	MOVLW       4
	SUBWF       Reset_routine_i_L0+0, 0 
L__Reset_routine162:
	BTFSC       STATUS+0, 0 
	GOTO        L_Reset_routine103
;Door locking system.c,476 :: 		if(recheck[i]==recheckagain[i])
	MOVLW       Reset_routine_recheck_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(Reset_routine_recheck_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVLW       Reset_routine_recheckagain_L0+0
	ADDWF       Reset_routine_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(Reset_routine_recheckagain_L0+0)
	ADDWFC      Reset_routine_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine105
;Door locking system.c,478 :: 		check++;
	INFSNZ      Reset_routine_check_L0+0, 1 
	INCF        Reset_routine_check_L0+1, 1 
;Door locking system.c,479 :: 		}
L_Reset_routine105:
;Door locking system.c,474 :: 		for(i=0;i<4;i++)
	INFSNZ      Reset_routine_i_L0+0, 1 
	INCF        Reset_routine_i_L0+1, 1 
;Door locking system.c,480 :: 		}
	GOTO        L_Reset_routine102
L_Reset_routine103:
;Door locking system.c,481 :: 		if(check==4)   //here new passwords are matched so nw goin to store them into memory
	MOVLW       0
	XORWF       Reset_routine_check_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Reset_routine163
	MOVLW       4
	XORWF       Reset_routine_check_L0+0, 0 
L__Reset_routine163:
	BTFSS       STATUS+0, 2 
	GOTO        L_Reset_routine106
;Door locking system.c,483 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,484 :: 		Lcd_Out(1, 1, "Processing with...");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr26_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr26_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,485 :: 		Lcd_Out(2, 1, recheckagain);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       Reset_routine_recheckagain_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(Reset_routine_recheckagain_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,486 :: 		y=x;
	MOVF        Reset_routine_x_L0+0, 0 
	MOVWF       Reset_routine_y_L0+0 
	MOVF        Reset_routine_x_L0+1, 0 
	MOVWF       Reset_routine_y_L0+1 
;Door locking system.c,488 :: 		vDisp2[0] = y / 100;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Reset_routine_x_L0+0, 0 
	MOVWF       R0 
	MOVF        Reset_routine_x_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       Reset_routine_vDisp2_L0+0 
;Door locking system.c,489 :: 		vDisp2[1] = (y / 10) % 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Reset_routine_y_L0+0, 0 
	MOVWF       R0 
	MOVF        Reset_routine_y_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       Reset_routine_vDisp2_L0+1 
;Door locking system.c,490 :: 		vDisp2[2] = y % 10;                      //Extract 100, 10, 1 place value
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Reset_routine_y_L0+0, 0 
	MOVWF       R0 
	MOVF        Reset_routine_y_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       Reset_routine_vDisp2_L0+2 
;Door locking system.c,493 :: 		Display2[3] = vDisp2[2] + 48;            //Convert to ASCII value
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
;Door locking system.c,498 :: 		LCD_Chr(2, 12, Display2[3]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Chr_column+0 
	CALL        _Lcd_Chr+0, 0
;Door locking system.c,502 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,503 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,504 :: 		memory(x,recheckagain);
	MOVF        Reset_routine_x_L0+0, 0 
	MOVWF       FARG_memory_mem_add+0 
	MOVF        Reset_routine_x_L0+1, 0 
	MOVWF       FARG_memory_mem_add+1 
	MOVLW       Reset_routine_recheckagain_L0+0
	MOVWF       FARG_memory_dat+0 
	MOVLW       hi_addr(Reset_routine_recheckagain_L0+0)
	MOVWF       FARG_memory_dat+1 
	CALL        _memory+0, 0
;Door locking system.c,505 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,506 :: 		Lcd_Out(1, 1, "Password Successfully Changed");        //Displaying "PSWD Changed"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr27_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr27_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,507 :: 		Lcd_Out(2, 5, "Changed!!!");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr28_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr28_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,508 :: 		msdelay(800);
	MOVLW       32
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,509 :: 		}
	GOTO        L_Reset_routine107
L_Reset_routine106:
;Door locking system.c,512 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,513 :: 		Lcd_Out(1, 1, "Passwords Mismatch!!");                  //Displaying "Passwords Mismatch!!"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr29_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr29_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,514 :: 		msdelay(500);
	MOVLW       244
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,515 :: 		}
L_Reset_routine107:
;Door locking system.c,517 :: 		}
L_Reset_routine87:
;Door locking system.c,518 :: 		}
L_end_Reset_routine:
	RETURN      0
; end of _Reset_routine

_main:

;Door locking system.c,520 :: 		void main()
;Door locking system.c,523 :: 		int i=0,j=0,s=0,res=1,ch,check=0,x=0,take;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
	CLRF        main_j_L0+0 
	CLRF        main_j_L0+1 
	CLRF        main_x_L0+0 
	CLRF        main_x_L0+1 
;Door locking system.c,527 :: 		TRISC=0X00;
	CLRF        TRISC+0 
;Door locking system.c,528 :: 		TRISA=0X00;
	CLRF        TRISA+0 
;Door locking system.c,529 :: 		TRISD=0X00;
	CLRF        TRISD+0 
;Door locking system.c,530 :: 		TRISB=0X00;                                                  //Setting ports A,B,C,D all as output
	CLRF        TRISB+0 
;Door locking system.c,532 :: 		while(1)
L_main108:
;Door locking system.c,535 :: 		Y=1;                                                        //LED indicating that door is closed
	BSF         RA3_bit+0, 3 
;Door locking system.c,536 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Door locking system.c,538 :: 		Lcd_Out(1, 1, "**YSK  Productions**");                        //Displaying "Welcome"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr30_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr30_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,539 :: 		msdelay(300);
	MOVLW       44
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,540 :: 		Lcd_Out(2, 4, "Press any key");                             //Displaying "Press any key.."
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr31_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr31_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,541 :: 		scan();                                                     //waiting fr user to press any key.... once any key pressed go ahead...
	CALL        _scan+0, 0
;Door locking system.c,542 :: 		ch=menu();                                                  //ch tells what user wants to do... unlock or reset pswd
	CALL        _menu+0, 0
	MOVF        R0, 0 
	MOVWF       main_ch_L0+0 
	MOVF        R1, 0 
	MOVWF       main_ch_L0+1 
;Door locking system.c,544 :: 		if(ch==1)                                                   //This begins when user presses 1 from menu list i.e unlocking option
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main165
	MOVLW       1
	XORWF       R0, 0 
L__main165:
	BTFSS       STATUS+0, 2 
	GOTO        L_main110
;Door locking system.c,547 :: 		for(j=0;j<3;j++)                            //this loop runs for chances to enter password..
	CLRF        main_j_L0+0 
	CLRF        main_j_L0+1 
L_main111:
	MOVLW       128
	XORWF       main_j_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main166
	MOVLW       3
	SUBWF       main_j_L0+0, 0 
L__main166:
	BTFSC       STATUS+0, 0 
	GOTO        L_main112
;Door locking system.c,550 :: 		Lcd_Cmd(_LCD_CLEAR);                        //clear display screen
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,551 :: 		Lcd_Out(1, 1, "Enter Password");            //Displaying "Enter Password"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr32_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr32_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,552 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);              //Display on, Cursor Blinking
	MOVLW       15
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,553 :: 		Lcd_Cmd(_LCD_SECOND_ROW);                   //Second line..
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,554 :: 		for(i=0;i<4;i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main114:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main167
	MOVLW       4
	SUBWF       main_i_L0+0, 0 
L__main167:
	BTFSC       STATUS+0, 0 
	GOTO        L_main115
;Door locking system.c,556 :: 		scan();
	CALL        _scan+0, 0
;Door locking system.c,557 :: 		if(colloc == 0xE0)
	MOVF        _colloc+0, 0 
	XORLW       224
	BTFSS       STATUS+0, 2 
	GOTO        L_main117
;Door locking system.c,559 :: 		Lcd_Chr_Cp('*');                        //Displaying data as ****.
	MOVLW       42
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Door locking system.c,560 :: 		entry[i]=keypad[rowloc][0];             //storing simultaneously into array 'entry'
	MOVLW       main_entry_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(main_entry_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,561 :: 		continue;
	GOTO        L_main116
;Door locking system.c,562 :: 		}
L_main117:
;Door locking system.c,563 :: 		if(colloc == 0xD0)
	MOVF        _colloc+0, 0 
	XORLW       208
	BTFSS       STATUS+0, 2 
	GOTO        L_main118
;Door locking system.c,565 :: 		Lcd_Chr_Cp('*');
	MOVLW       42
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Door locking system.c,566 :: 		entry[i]=keypad[rowloc][1];
	MOVLW       main_entry_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(main_entry_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,567 :: 		continue;
	GOTO        L_main116
;Door locking system.c,568 :: 		}
L_main118:
;Door locking system.c,569 :: 		if(colloc == 0xB0)
	MOVF        _colloc+0, 0 
	XORLW       176
	BTFSS       STATUS+0, 2 
	GOTO        L_main119
;Door locking system.c,571 :: 		Lcd_Chr_Cp('*');
	MOVLW       42
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Door locking system.c,572 :: 		entry[i]=keypad[rowloc][2];
	MOVLW       main_entry_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(main_entry_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,573 :: 		continue;
	GOTO        L_main116
;Door locking system.c,574 :: 		}
L_main119:
;Door locking system.c,575 :: 		if(colloc == 0x70)
	MOVF        _colloc+0, 0 
	XORLW       112
	BTFSS       STATUS+0, 2 
	GOTO        L_main120
;Door locking system.c,577 :: 		Lcd_Chr_Cp('*');
	MOVLW       42
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Door locking system.c,578 :: 		entry[i]=keypad[rowloc][3];
	MOVLW       main_entry_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(main_entry_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        _rowloc+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _keypad+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_keypad+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;Door locking system.c,579 :: 		continue;
	GOTO        L_main116
;Door locking system.c,580 :: 		}
L_main120:
;Door locking system.c,582 :: 		}                              //for loop ends here
L_main116:
;Door locking system.c,554 :: 		for(i=0;i<4;i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;Door locking system.c,582 :: 		}                              //for loop ends here
	GOTO        L_main114
L_main115:
;Door locking system.c,584 :: 		Lcd_Cmd(_LCD_CLEAR);                                    // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,585 :: 		Lcd_Out(1, 1, "U hav entered...");                      //Displaying "U hav entered..."
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr33_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr33_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,586 :: 		msdelay(100);
	MOVLW       100
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,588 :: 		Lcd_Cmd(_LCD_SECOND_ROW);                               //Second line..
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,589 :: 		Lcd_Out_Cp(entry);                                      //Displaying "entered password by user"
	MOVLW       main_entry_L0+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(main_entry_L0+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;Door locking system.c,590 :: 		msdelay(350);
	MOVLW       94
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,591 :: 		Lcd_Cmd(_LCD_CLEAR);                                    // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,592 :: 		x=authenticate(entry);
	MOVLW       main_entry_L0+0
	MOVWF       FARG_authenticate_password+0 
	MOVLW       hi_addr(main_entry_L0+0)
	MOVWF       FARG_authenticate_password+1 
	CALL        _authenticate+0, 0
	MOVF        R0, 0 
	MOVWF       main_x_L0+0 
	MOVF        R1, 0 
	MOVWF       main_x_L0+1 
;Door locking system.c,593 :: 		Lcd_Cmd(_LCD_CLEAR);                                    //Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,594 :: 		if(x==4 || x==3 || x==2 || x==1)
	MOVLW       0
	XORWF       main_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main168
	MOVLW       4
	XORWF       main_x_L0+0, 0 
L__main168:
	BTFSC       STATUS+0, 2 
	GOTO        L__main132
	MOVLW       0
	XORWF       main_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main169
	MOVLW       3
	XORWF       main_x_L0+0, 0 
L__main169:
	BTFSC       STATUS+0, 2 
	GOTO        L__main132
	MOVLW       0
	XORWF       main_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main170
	MOVLW       2
	XORWF       main_x_L0+0, 0 
L__main170:
	BTFSC       STATUS+0, 2 
	GOTO        L__main132
	MOVLW       0
	XORWF       main_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main171
	MOVLW       1
	XORWF       main_x_L0+0, 0 
L__main171:
	BTFSC       STATUS+0, 2 
	GOTO        L__main132
	GOTO        L_main123
L__main132:
;Door locking system.c,596 :: 		y=0; g=1;
	BCF         RA3_bit+0, 3 
	BSF         RA0_bit+0, 0 
;Door locking system.c,597 :: 		Lcd_Out(1, 1, "CONGRATULATIONS");               //Displaying "CONGRATULATIONS"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr34_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr34_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,598 :: 		msdelay(200);
	MOVLW       200
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       0
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,599 :: 		Lcd_Out(1, 1, "Door unlocked!!");               //Displaying "Door unlocked!!"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr35_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr35_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,600 :: 		msdelay(1000);                                  //Actual door opening time
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,601 :: 		y=1; g=0;
	BSF         RA3_bit+0, 3 
	BCF         RA0_bit+0, 0 
;Door locking system.c,602 :: 		break;
	GOTO        L_main112
;Door locking system.c,603 :: 		}
L_main123:
;Door locking system.c,606 :: 		y=0;
	BCF         RA3_bit+0, 3 
;Door locking system.c,607 :: 		b=1;
	BSF         RA2_bit+0, 2 
;Door locking system.c,608 :: 		Lcd_Out(1, 1, "Wrong password!!!");             //Displaying "wrong pass!!!"
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr36_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr36_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,609 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,610 :: 		Lcd_Cmd(_LCD_SECOND_ROW);                       //Second line..
	MOVLW       192
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Door locking system.c,611 :: 		if(j==0)
	MOVLW       0
	XORWF       main_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main172
	MOVLW       0
	XORWF       main_j_L0+0, 0 
L__main172:
	BTFSS       STATUS+0, 2 
	GOTO        L_main125
;Door locking system.c,613 :: 		Lcd_Out(2, 1, "2 chances left..");                 //Displaying "2 chances left"
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr37_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr37_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,614 :: 		msdelay(500);
	MOVLW       244
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,615 :: 		}
	GOTO        L_main126
L_main125:
;Door locking system.c,616 :: 		else if(j==1)
	MOVLW       0
	XORWF       main_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main173
	MOVLW       1
	XORWF       main_j_L0+0, 0 
L__main173:
	BTFSS       STATUS+0, 2 
	GOTO        L_main127
;Door locking system.c,618 :: 		Lcd_Out(2, 1, "1 chance left..");                  //Displaying "1 chance left"
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr38_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr38_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,619 :: 		msdelay(500);
	MOVLW       244
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       1
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,620 :: 		}
	GOTO        L_main128
L_main127:
;Door locking system.c,621 :: 		else if(j==2)
	MOVLW       0
	XORWF       main_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main174
	MOVLW       2
	XORWF       main_j_L0+0, 0 
L__main174:
	BTFSS       STATUS+0, 2 
	GOTO        L_main129
;Door locking system.c,623 :: 		Lcd_Out(2, 1, "ALERT!!!!");                        //Displaying "ALERT!!!"
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr39_Door_32locking_32system+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr39_Door_32locking_32system+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Door locking system.c,624 :: 		Red=1;
	BSF         RA1_bit+0, 1 
;Door locking system.c,625 :: 		msdelay(1000);
	MOVLW       232
	MOVWF       FARG_msdelay_itime+0 
	MOVLW       3
	MOVWF       FARG_msdelay_itime+1 
	CALL        _msdelay+0, 0
;Door locking system.c,626 :: 		Red=0;
	BCF         RA1_bit+0, 1 
;Door locking system.c,627 :: 		break;
	GOTO        L_main112
;Door locking system.c,628 :: 		}
L_main129:
L_main128:
L_main126:
;Door locking system.c,629 :: 		b=0;
	BCF         RA2_bit+0, 2 
;Door locking system.c,630 :: 		y=1;
	BSF         RA3_bit+0, 3 
;Door locking system.c,547 :: 		for(j=0;j<3;j++)                            //this loop runs for chances to enter password..
	INFSNZ      main_j_L0+0, 1 
	INCF        main_j_L0+1, 1 
;Door locking system.c,633 :: 		}
	GOTO        L_main111
L_main112:
;Door locking system.c,634 :: 		}                //If loop of ch=1 ends here..
L_main110:
;Door locking system.c,636 :: 		if(ch==2)                                        //This begins when user presses 2 from menu list i.e resetting passwrd
	MOVLW       0
	XORWF       main_ch_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main175
	MOVLW       2
	XORWF       main_ch_L0+0, 0 
L__main175:
	BTFSS       STATUS+0, 2 
	GOTO        L_main130
;Door locking system.c,638 :: 		Reset_routine();
	CALL        _Reset_routine+0, 0
;Door locking system.c,639 :: 		}
L_main130:
;Door locking system.c,640 :: 		}
	GOTO        L_main108
;Door locking system.c,641 :: 		}                                                                                                        //main ends here
L_end_main:
	GOTO        $+0
; end of _main

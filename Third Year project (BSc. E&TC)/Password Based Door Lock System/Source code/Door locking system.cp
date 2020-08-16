#line 1 "C:/Users/owner/Desktop/Yash/Trial(Latest Updated)/Door locking system.c"

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_RW at RB6_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_RW_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;

char ROW at PORTD;
char COL at PORTD;
unsigned char colloc,rowloc;
unsigned char pswd1[]="1111",pswd2[]="2222",pswd3[]="3333",pswd4[]="4444";


sbit G at RA0_bit;
sbit Red at RA1_bit;
sbit B at RA2_bit;
sbit Y at RA3_bit;
sbit G_Direction at TRISA0_bit;
sbit Red_Direction at TRISA1_bit;
sbit B_Direction at TRISA2_bit;
sbit Y_Direction at TRISA3_bit;

unsigned char keypad[4][4] = {
 {'0','1','2','3'},
 {'4','5','6','7'},
 {'8','9','A','B'},
 {'C','D','E','F'}
 };

void msdelay (unsigned int itime)
 {
 unsigned int i,j;
 for(i=0; i<itime; i++)
 for(j=0; j<175; j++);
 }

int authenticate(unsigned char password[])
{
int i,s=0;
Lcd_Cmd(_LCD_SECOND_ROW);
 for(i=0;i<4;i++)
 {
 if(password[i]==pswd1[i])
 {
 s=s+1;
 }
 if(s==4)
 return (1);
 }
 Lcd_Cmd(_LCD_CLEAR);
 s=0;
 for(i=0;i<4;i++)
 {
 if(password[i]==pswd2[i])
 {
 s=s+1;
 }
 if(s==4)
 return (2);
 }
 Lcd_Cmd(_LCD_CLEAR);
 s=0;
 for(i=0;i<4;i++)
 {
 if(password[i]==pswd3[i])
 {
 s=s+1;
 }
 if(s==4)
 return (3);
 }
 Lcd_Cmd(_LCD_CLEAR);
 s=0;
 for(i=0;i<4;i++)
 {
 if(password[i]==pswd4[i])
 {
 s=s+1;
 }
 if(s==4)
 return (4);
 }
}

void scan(void)
{
 COL = 0xF0;

 do
 {
 ROW = 0xF0;
 colloc = COL;
 colloc &= 0xF0;
 }while(colloc != 0xF0);

 do
 {
 do
 {
 msdelay(50);
 colloc = COL;
 colloc &= 0xF0;
 }while(colloc == 0xF0);

 msdelay(20);
 colloc = COL;
 colloc &= 0xF0;
 } while(colloc == 0xF0);



 while(1)
 {
 ROW = 0xFE;
 colloc = COL;
 colloc &= 0xF0;
 if(colloc != 0xF0)
 {
 rowloc = 0;
 break;
 }
 ROW = 0xFD;
 colloc = COL;
 colloc &= 0xF0;
 if(colloc != 0xF0)
 {
 rowloc = 1;
 break;
 }
 ROW = 0xFB;
 colloc = COL;
 colloc &= 0xF0;
 if(colloc != 0xF0)
 {
 rowloc = 2;
 break;
 }
 ROW = 0xF7;
 colloc = COL;
 colloc &= 0xF0;
 rowloc = 3;
 break;

 }
}

unsigned char readEEPROM(unsigned char address)
{
 EEADR =address;
 EECON1.EEPGD=0;
 EECON1.RD=1;
 return EEDATA;
}

void writeEEPROM(unsigned char address,unsigned char datas)
{
 unsigned char INTCON_SAVE;
 EEADR=address;
 EEDATA=datas;
 EECON1.EEPGD=0;
 EECON1.WREN=1;
 INTCON_SAVE=INTCON;
 INTCON=0;
 EECON2=0x55;
 EECON2=0xAA;
 EECON1.WR=1;
 INTCON=INTCON_SAVE;
 EECON1.WREN=0;
 while(PIR2.EEIF==0)
 {
 asm nop;
 }
 PIR2.EEIF=0;
}


void memory(unsigned int mem_add,unsigned char dat[4])
{
unsigned short int i,t,t1[4];
unsigned char Display2[5],vDisp2[5],Data[4];
int txt[5],actual_txt[4];
Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1, 1, "Data to be written is: ");
Lcd_Out(2, 1, dat);
Data[0]=dat[0]-48;
Data[1]=dat[1]-48;
Data[2]=dat[2]-48;
Data[3]=dat[3]-48;
msdelay(500);
switch(mem_add)
 {
 case 1:
 for(i=0;i<4;i++)
 {
 writeEEPROM(mem_add+i, Data[i]);
 msdelay(200);
 pswd1[i] = readEEPROM(mem_add+i) + 48;
 msdelay(200);
 }
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Your new P1: ");
 Lcd_Out(2, 1, pswd1);
 msdelay(2000);
 break;
 case 2:
 for(i=0;i<4;i++)
 {
 writeEEPROM(mem_add+i, Data[i]);
 msdelay(200);
 pswd2[i] = readEEPROM(mem_add+i) + 48;
 msdelay(200);
 }
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Your new P2: ");
 Lcd_Out(2, 1, pswd2);
 msdelay(2000);
 break;
 case 3:
 for(i=0;i<4;i++)
 {
 writeEEPROM(mem_add+i, Data[i]);
 msdelay(200);
 pswd3[i] = readEEPROM(mem_add+i) + 48;
 msdelay(200);
 }
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Your new P3: ");
 Lcd_Out(2, 1, pswd3);
 msdelay(2000);
 break;;
 case 4:
 for(i=0;i<4;i++)
 {
 writeEEPROM(mem_add+i, Data[i]);
 msdelay(200);
 pswd4[i] = readEEPROM(mem_add+i) + 48;
 msdelay(200);
 }
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Your new P4: ");
 Lcd_Out(2, 1, pswd4);
 msdelay(2000);
 break;
 }
}

int menu()
{
 int i,value;
 unsigned char colloc;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 1, "1.Unlock 2.Reset");
 Lcd_Out(1, 1, "You wish to : ");

 {
 COL = 0xF0;
 rowloc=15;
 do
 {
 ROW = 0xF0;
 colloc = COL;
 colloc &= 0xF0;
 }while(colloc != 0xF0);

 do
 {
 do
 {
 msdelay(50);
 colloc = COL;
 colloc &= 0xF0;
 }while(colloc == 0xF0);

 msdelay(20);
 colloc = COL;
 colloc &= 0xF0;
 } while(colloc == 0xF0);



 while(1)
 {
 ROW = 0xFE;
 colloc = COL;
 colloc &= 0xF0;
 if(colloc != 0xF0)
 {
 rowloc = 5;
 break;
 }
 ROW = 0xFD;
 colloc = COL;
 colloc &= 0xF0;
 if(colloc != 0xF0)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Invalid Keypress");
 break;
 }
 ROW = 0xFB;
 colloc = COL;
 colloc &= 0xF0;
 if(colloc != 0xF0)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Invalid Keypress");
 break;
 }
 ROW = 0xF7;
 colloc = COL;
 colloc &= 0xF0;
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Invalid Keypress");
 break;
 }
 }


 if(colloc == 0xE0 & rowloc==5)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Invalid Keypress");
 }
 if(colloc == 0xD0 & rowloc==5)
 {
 Lcd_Out_Cp("1");
 value=1;
 }
 if(colloc == 0xB0 & rowloc==5)
 {
 Lcd_Out_Cp("2");
 value=2;
 }
 if(colloc == 0x70 & rowloc==5)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Invalid Keypress");
 }
 msdelay(1000);
 }
 return (value);
}

void Reset_routine()
{
unsigned char entry[4],recheck[4],recheckagain[4],Display2[5],vDisp2[5];
int i=0,ch,x=0,check,y;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Verify yourself!");

 Lcd_Cmd(_LCD_SECOND_ROW);
 for(i=0;i<4;i++)
 {
 scan();
 if(colloc == 0xE0)
 {
 Lcd_Chr_Cp('*');
 entry[i]=keypad[rowloc][0];
 continue;
 }
 if(colloc == 0xD0)
 {
 Lcd_Chr_Cp('*');
 entry[i]=keypad[rowloc][1];
 continue;
 }
 if(colloc == 0xB0)
 {
 Lcd_Chr_Cp('*');
 entry[i]=keypad[rowloc][2];
 continue;
 }
 if(colloc == 0x70)
 {
 Lcd_Chr_Cp('*');
 entry[i]=keypad[rowloc][3];

 continue;
 }

 }

 x=authenticate(entry);

 Lcd_Cmd(_LCD_CLEAR);
 if(x==4 || x==3 || x==2 || x==1)
 {
 Lcd_Out(1, 1, "Enter new password");
 Lcd_Cmd(_LCD_SECOND_ROW);
 for(i=0;i<4;i++)
 {
 scan();
 if(colloc == 0xE0)
 {
 Lcd_Out_Cp("*");
 recheckagain[i]=keypad[rowloc][0];
 continue;
 }
 if(colloc == 0xD0)
 {
 Lcd_Out_Cp("*");
 recheckagain[i]=keypad[rowloc][1];
 continue;
 }
 if(colloc == 0xB0)
 {
 Lcd_Out_Cp("*");
 recheckagain[i]=keypad[rowloc][2];
 continue;
 }
 if(colloc == 0x70)
 {
 Lcd_Out_Cp("*");
 recheckagain[i]=keypad[rowloc][3];

 continue;
 }

 }


 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, recheckagain);
 msdelay(500);
 Lcd_Out(1, 1, "RE-ENTER your PSWD");
 Lcd_Cmd(_LCD_SECOND_ROW);
 for(i=0;i<4;i++)
 {

 scan();

 if(colloc == 0xE0)
 {
 Lcd_Out_Cp("*");
 recheck[i]=keypad[rowloc][0];
 continue;
 }
 if(colloc == 0xD0)
 {
 Lcd_Out_Cp("*");
 recheck[i]=keypad[rowloc][1];
 continue;
 }
 if(colloc == 0xB0)
 {
 Lcd_Out_Cp("*");
 recheck[i]=keypad[rowloc][2];
 continue;
 }
 if(colloc == 0x70)
 {
 Lcd_Out_Cp("*");
 recheck[i]=keypad[rowloc][3];
 continue;
 }

 }

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 1, recheck);
 msdelay(500);
 check=0;
 for(i=0;i<4;i++)
 {
 if(recheck[i]==recheckagain[i])
 {
 check++;
 }
 }
 if(check==4)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Processing with...");
 Lcd_Out(2, 1, recheckagain);
 y=x;

 vDisp2[0] = y / 100;
 vDisp2[1] = (y / 10) % 10;
 vDisp2[2] = y % 10;
 Display2[1] = vDisp2[0] + 48;
 Display2[2] = vDisp2[1] + 48;
 Display2[3] = vDisp2[2] + 48;




 LCD_Chr(2, 12, Display2[3]);



 msdelay(1000);
 Lcd_Cmd(_LCD_CLEAR);
 memory(x,recheckagain);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Password Successfully Changed");
 Lcd_Out(2, 5, "Changed!!!");
 msdelay(800);
 }
 else
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Passwords Mismatch!!");
 msdelay(500);
 }

 }
}

void main()
{
unsigned char entry[4],recheck[4],recheck1[4];
int i=0,j=0,s=0,res=1,ch,check=0,x=0,take;
unsigned short t;
char txt[4];

TRISC=0X00;
TRISA=0X00;
TRISD=0X00;
TRISB=0X00;

while(1)
{

Y=1;
Lcd_Init();

Lcd_Out(1, 1, "**YSK  Productions**");
msdelay(300);
Lcd_Out(2, 4, "Press any key");
scan();
ch=menu();

if(ch==1)
 {

 for(j=0;j<3;j++)
 {
 s=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Enter Password");
 Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
 Lcd_Cmd(_LCD_SECOND_ROW);
 for(i=0;i<4;i++)
 {
 scan();
 if(colloc == 0xE0)
 {
 Lcd_Chr_Cp('*');
 entry[i]=keypad[rowloc][0];
 continue;
 }
 if(colloc == 0xD0)
 {
 Lcd_Chr_Cp('*');
 entry[i]=keypad[rowloc][1];
 continue;
 }
 if(colloc == 0xB0)
 {
 Lcd_Chr_Cp('*');
 entry[i]=keypad[rowloc][2];
 continue;
 }
 if(colloc == 0x70)
 {
 Lcd_Chr_Cp('*');
 entry[i]=keypad[rowloc][3];
 continue;
 }

 }

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "U hav entered...");
 msdelay(100);

 Lcd_Cmd(_LCD_SECOND_ROW);
 Lcd_Out_Cp(entry);
 msdelay(350);
 Lcd_Cmd(_LCD_CLEAR);
x=authenticate(entry);
 Lcd_Cmd(_LCD_CLEAR);
 if(x==4 || x==3 || x==2 || x==1)
 {
 y=0; g=1;
 Lcd_Out(1, 1, "CONGRATULATIONS");
 msdelay(200);
 Lcd_Out(1, 1, "Door unlocked!!");
 msdelay(1000);
 y=1; g=0;
 break;
 }
 else
 {
 y=0;
 b=1;
 Lcd_Out(1, 1, "Wrong password!!!");
 msdelay(1000);
 Lcd_Cmd(_LCD_SECOND_ROW);
 if(j==0)
 {
 Lcd_Out(2, 1, "2 chances left..");
 msdelay(500);
 }
 else if(j==1)
 {
 Lcd_Out(2, 1, "1 chance left..");
 msdelay(500);
 }
 else if(j==2)
 {
 Lcd_Out(2, 1, "ALERT!!!!");
 Red=1;
 msdelay(1000);
 Red=0;
 break;
 }
 b=0;
 y=1;
 }
 s=0;
 }
 }

if(ch==2)
 {
 Reset_routine();
 }
}
}

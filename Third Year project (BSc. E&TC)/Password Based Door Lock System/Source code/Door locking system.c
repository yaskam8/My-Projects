//Lcd pin setting
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
                             };                //Definition of keypad matrix
                             
void msdelay (unsigned int itime) //delay
 {
        unsigned int i,j;
         for(i=0; i<itime; i++)
          for(j=0; j<175; j++);
 }
 
int authenticate(unsigned char password[])
{
int i,s=0;
Lcd_Cmd(_LCD_SECOND_ROW);
                for(i=0;i<4;i++)                                //Authenticating through many passwords
                        {
                                if(password[i]==pswd1[i])
                                {
                                s=s+1;
                                }
                                if(s==4)
                                        return (1);
                        }
                Lcd_Cmd(_LCD_CLEAR);                                 //clear display screen
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
                Lcd_Cmd(_LCD_CLEAR);                                 //clear display screen
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
                Lcd_Cmd(_LCD_CLEAR);                                 //clear display screen
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
                colloc &= 0xF0;                                                        //Check location of column which is pressed
                }while(colloc != 0xF0);
                                                                                       //at this point no key is pressed
                do
                {
                        do
                        {
                         msdelay(50);                                                  //wait for key to be pressed
                         colloc = COL;
                         colloc &= 0xF0;
                         }while(colloc == 0xF0);                                       //gets out of loop when key is pressed n now enters for checking of key debouncing

                msdelay(20);                                                           //Check for debouncing
                colloc = COL;
                colloc &= 0xF0;
                } while(colloc == 0xF0);



                                        while(1)
                                                 {
                                                ROW = 0xFE;                            //Check for rows 1, 2, 3, 4 in sequence.
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

unsigned char readEEPROM(unsigned char address)                      //Routine to read from memory
{
 EEADR =address;
 EECON1.EEPGD=0;
 EECON1.RD=1;
 return EEDATA;
}

void writeEEPROM(unsigned char address,unsigned char datas)           //Routine to write to memory
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
Lcd_Cmd(_LCD_CLEAR);                        //clear display screen
Lcd_Out(1, 1, "Data to be written is: ");
Lcd_Out(2, 1, dat);
Data[0]=dat[0]-48;           //Converting into ASCII so tht it can be stored into the PIC memory
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
                     pswd1[i]     = readEEPROM(mem_add+i) + 48;
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
                     pswd2[i]     = readEEPROM(mem_add+i) + 48;
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
                     pswd3[i]     = readEEPROM(mem_add+i) + 48;
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
                     pswd4[i]     = readEEPROM(mem_add+i) + 48;
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

        Lcd_Cmd(_LCD_CLEAR);                        //clear display screen
        Lcd_Out(2, 1, "1.Unlock 2.Reset");
        Lcd_Out(1, 1, "You wish to : ");
/*Checking for what is opted by user from menu list*/
                       {
                        COL = 0xF0;
                        rowloc=15;                //randomly set for avoiding its default value used furthur..
                                do
                                {
                                ROW = 0xF0;
                                colloc = COL;
                                colloc &= 0xF0;            //Check location of column which is pressed
                                }while(colloc != 0xF0);
                                                           //at this point no key is pressed
                                do
                                {
                                        do
                                        {
                                         msdelay(50);      //wait for key to be pressed
                                         colloc = COL;
                                         colloc &= 0xF0;
                                         }while(colloc == 0xF0);           //gets out of loop when key is pressed n now enters for checking of key debouncing

                                msdelay(20);                               //Check for debouncing
                                colloc = COL;
                                colloc &= 0xF0;
                                } while(colloc == 0xF0);


                                /*Rows scanning*/
                                                        while(1)
                                                        {
                                                                ROW = 0xFE;                                 //Check for rows 1, 2, 3, 4 in sequence.
                                                                colloc = COL;
                                                                colloc &= 0xF0;
                                                                          if(colloc != 0xF0)                //scan only 1st row... n set rowloc to 0.. which is used as a condition check furthur
                                                                                    {
                                                                                    rowloc = 5;             //to avoid usage of garbage val taken as zero. so randomly taken as 5
                                                                                         break;
                                                                                    }
                                                                ROW = 0xFD;
                                                                colloc = COL;
                                                                colloc &= 0xF0;
                                                                        if(colloc != 0xF0)                  //if other than 1st row is pressed then display INVALID KEYPRESS...
                                                                                {
                                                                                Lcd_Cmd(_LCD_CLEAR);        //clear display screen
                                                                                Lcd_Out(1, 1, "Invalid Keypress");
                                                                                break;
                                                                                }
                                                                ROW = 0xFB;
                                                                colloc = COL;
                                                                colloc &= 0xF0;
                                                                        if(colloc != 0xF0)
                                                                                {
                                                                                Lcd_Cmd(_LCD_CLEAR);        //clear display screen
                                                                                Lcd_Out(1, 1, "Invalid Keypress");
                                                                                break;
                                                                                }
                                                                ROW = 0xF7;
                                                                colloc = COL;
                                                                colloc &= 0xF0;
                                                                                {
                                                                                Lcd_Cmd(_LCD_CLEAR);        //clear display screen
                                                                                Lcd_Out(1, 1, "Invalid Keypress");
                                                                                break;
                                                                                }
                                                        }

                                /*Columns scanning*/
                                        if(colloc == 0xE0 & rowloc==5)                // here the rowloc value is used to confirm that key pressed belongs to only 1st row.
                                        {
                                            Lcd_Cmd(_LCD_CLEAR);        //clear display screen
                                            Lcd_Out(1, 1, "Invalid Keypress");
                                        }
                                        if(colloc == 0xD0 & rowloc==5)                //rowloc value is used everywhere to check for all 4 keys of 1st row...
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
                                            Lcd_Cmd(_LCD_CLEAR);      //clear display screen
                                            Lcd_Out(1, 1, "Invalid Keypress");
                                        }
                                 msdelay(1000);
                         }                                   //loop ends here
 return (value);
}

void Reset_routine()
{
unsigned char entry[4],recheck[4],recheckagain[4],Display2[5],vDisp2[5];
int i=0,ch,x=0,check,y;
        Lcd_Cmd(_LCD_CLEAR);                    // Clear display
        Lcd_Out(1, 1, "Verify yourself!");      //Displaying "Verify yourself!"
        //msdelay(500);
        Lcd_Cmd(_LCD_SECOND_ROW);               //Second line..
                          for(i=0;i<4;i++)      //getting the password first for verification
                                        {
                                        scan();
                                                                if(colloc == 0xE0)
                                                                        {
                                                                        Lcd_Chr_Cp('*');                        //Displaying data as ****.
                                                                        entry[i]=keypad[rowloc][0];             //storing simultaneously into array 'entry'
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
                                                                        //msdelay[200];
                                                                        continue;
                                                                        }

                                                        }                        //for loop ends here

        x=authenticate(entry);
/*GETTING NEW PASSWORD*/
                Lcd_Cmd(_LCD_CLEAR);
         if(x==4 || x==3 || x==2 || x==1)
                {
                Lcd_Out(1, 1, "Enter new password");      //Displaying "Enter new password"
                Lcd_Cmd(_LCD_SECOND_ROW);                         //next Line
                                for(i=0;i<4;i++)
                                        {
                                        scan();
                                                                if(colloc == 0xE0)
                                                                        {
                                                                        Lcd_Out_Cp("*");                                  //Displaying data as ****.
                                                                        recheckagain[i]=keypad[rowloc][0];                //storing simultaneously into array 'recheck1'
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
                                                                        //msdelay[100];
                                                                        continue;
                                                                        }

                                                        }                                //for loop ends here


                Lcd_Cmd(_LCD_CLEAR);
                Lcd_Out(1, 1, recheckagain);
                msdelay(500);
                Lcd_Out(1, 1, "RE-ENTER your PSWD");                      //Displaying "RE-ENTER PSWD"
                Lcd_Cmd(_LCD_SECOND_ROW);                                 //Second line..
                                for(i=0;i<4;i++)                          //Re-checking procedure of new password
                                        {

                                        scan();

                                                                if(colloc == 0xE0)
                                                                        {
                                                                        Lcd_Out_Cp("*");                             //Displaying data as ****.
                                                                        recheck[i]=keypad[rowloc][0];                //storing simultaneously into array 'recheck'
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

                                          }                                //for loop ends here

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
                if(check==4)   //here new passwords are matched so nw goin to store them into memory
                        {
                                Lcd_Cmd(_LCD_CLEAR);
                                Lcd_Out(1, 1, "Processing with...");
                                Lcd_Out(2, 1, recheckagain);
                                y=x;
                                //trying out for producing an ascii value
                                           vDisp2[0] = y / 100;
                                           vDisp2[1] = (y / 10) % 10;
                                           vDisp2[2] = y % 10;                      //Extract 100, 10, 1 place value
                                           Display2[1] = vDisp2[0] + 48;
                                           Display2[2] = vDisp2[1] + 48;
                                           Display2[3] = vDisp2[2] + 48;            //Convert to ASCII value
                                           //LCD_Chr(2, 8, Display2[0]);
                                           //LCD_Chr(2, 9, Display2[1]);
                                           //LCD_Chr(2, 10, Display2[2]);
                                           //LCD_Chr(2, 11, '.');
                                           LCD_Chr(2, 12, Display2[3]);
                                           //LCD_Chr(2, 13, Display2[4]);
                                           //LCD_Chr(2, 14, Display2[5]);         // Display on to LCD
                                //Lcd_Out(2, 10, Display2);                    //giving variable name gives its hex value to be printed!!!
                                msdelay(1000);
                                Lcd_Cmd(_LCD_CLEAR);
                                memory(x,recheckagain);
                                Lcd_Cmd(_LCD_CLEAR);
                                Lcd_Out(1, 1, "Password Successfully Changed");        //Displaying "PSWD Changed"
                                Lcd_Out(2, 5, "Changed!!!");
                                msdelay(800);
                        }
                else
                                {
                                Lcd_Cmd(_LCD_CLEAR);
                                Lcd_Out(1, 1, "Passwords Mismatch!!");                  //Displaying "Passwords Mismatch!!"
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
TRISB=0X00;                                                  //Setting ports A,B,C,D all as output

while(1)
{

Y=1;                                                        //LED indicating that door is closed
Lcd_Init();

Lcd_Out(1, 1, "**YSK  Productions**");                        //Displaying "Welcome"
msdelay(300);
Lcd_Out(2, 4, "Press any key");                             //Displaying "Press any key.."
scan();                                                     //waiting fr user to press any key.... once any key pressed go ahead...
ch=menu();                                                  //ch tells what user wants to do... unlock or reset pswd

if(ch==1)                                                   //This begins when user presses 1 from menu list i.e unlocking option
        {

                for(j=0;j<3;j++)                            //this loop runs for chances to enter password..
                {
                s=0;
                Lcd_Cmd(_LCD_CLEAR);                        //clear display screen
                Lcd_Out(1, 1, "Enter Password");            //Displaying "Enter Password"
                Lcd_Cmd(_LCD_BLINK_CURSOR_ON);              //Display on, Cursor Blinking
                Lcd_Cmd(_LCD_SECOND_ROW);                   //Second line..
                        for(i=0;i<4;i++)
                                        {
                                        scan();
                                                                if(colloc == 0xE0)
                                                                        {
                                                                        Lcd_Chr_Cp('*');                        //Displaying data as ****.
                                                                        entry[i]=keypad[rowloc][0];             //storing simultaneously into array 'entry'
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

                                         }                              //for loop ends here

                Lcd_Cmd(_LCD_CLEAR);                                    // Clear display
                Lcd_Out(1, 1, "U hav entered...");                      //Displaying "U hav entered..."
                msdelay(100);

                Lcd_Cmd(_LCD_SECOND_ROW);                               //Second line..
                Lcd_Out_Cp(entry);                                      //Displaying "entered password by user"
                msdelay(350);
                Lcd_Cmd(_LCD_CLEAR);                                    // Clear display
x=authenticate(entry);
                Lcd_Cmd(_LCD_CLEAR);                                    //Clear display
                if(x==4 || x==3 || x==2 || x==1)
                        {
                        y=0; g=1;
                        Lcd_Out(1, 1, "CONGRATULATIONS");               //Displaying "CONGRATULATIONS"
                        msdelay(200);
                        Lcd_Out(1, 1, "Door unlocked!!");               //Displaying "Door unlocked!!"
                        msdelay(1000);                                  //Actual door opening time
                        y=1; g=0;
                        break;
                        }
                else
                        {
                        y=0;
                        b=1;
                        Lcd_Out(1, 1, "Wrong password!!!");             //Displaying "wrong pass!!!"
                        msdelay(1000);
                        Lcd_Cmd(_LCD_SECOND_ROW);                       //Second line..
                                        if(j==0)
                                                {
                                                 Lcd_Out(2, 1, "2 chances left..");                 //Displaying "2 chances left"
                                                 msdelay(500);
                                                }
                                        else if(j==1)
                                                {
                                                 Lcd_Out(2, 1, "1 chance left..");                  //Displaying "1 chance left"
                                                 msdelay(500);
                                                }
                                        else if(j==2)
                                                {
                                                 Lcd_Out(2, 1, "ALERT!!!!");                        //Displaying "ALERT!!!"
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
        }                //If loop of ch=1 ends here..
/*RESETTING password function*/
if(ch==2)                                        //This begins when user presses 2 from menu list i.e resetting passwrd
        {
         Reset_routine();
        }
}
}                                                                                                        //main ends here
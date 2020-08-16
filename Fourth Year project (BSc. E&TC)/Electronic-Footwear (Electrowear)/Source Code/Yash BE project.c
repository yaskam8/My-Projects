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

float threshold,interval=1000;
float measured,reference, base;

float Upperbound= 6000;
float Lowerbound= 200;
float max_data= 3295;
float min_data= 3282;
float scaler1=1;
float scaler2=2;
float scaler3=2;
float scaler4=1;
float scaler5=1;
float scaler6=0.5;


//float reference=8179;

void msdelay (unsigned int itime) //delay routine
 {
        unsigned int i,j;
         for(i=0; i<itime; i++)
          for(j=0; j<175; j++);
 }
 
int masterloop(void)
{
//float percent;
char txt1[6],txt2[6],txt3[6],txt4[6],final[3];
int i=0;
//float measured,reference=8179;
unsigned int res[4];
unsigned int ip1,vDisp1[3],Display1[4],D1[4];
unsigned int ip2,vDisp2[3],Display2[4],D2[4];
unsigned int ip3,vDisp3[3],Display3[4],D3[4];
unsigned int ip4,vDisp4[3],Display4[4],D4[4];
unsigned int ip5,vDisp5[3],Display5[4],D5[4];
unsigned int ip6,vDisp6[3],Display6[4],D6[4];
unsigned int ip7,vDisp7[3],Display7[4],D7[4];
unsigned int ip8,vDisp8[3],Display8[4],D8[4];

ip1 = ADC_Read(0)*scaler1;
       //trying out for producing an ascii value
                                                 vDisp1[0] = ip1 / 1000;
                                                 vDisp1[1] = (ip1 / 100) % 10;
                                                 vDisp1[2] = (ip1 % 100) / 10;
                                                 vDisp1[3] = ip1 % 10;                      //Extract 100, 10, 1 place value
                                                 Display1[0] = vDisp1[0] + 48 ;
                                                 Display1[1] = vDisp1[1] + 48;
                                                 Display1[2] = vDisp1[2] + 48;
                                                 Display1[3] = vDisp1[3] + 48;            //Convert to ASCII value
                                                 /*for(i=0;i<5;i++)
                                                 {LCD_chr(2, i, vDisp1[i]); } */
                                                  /*FloatToStr(res[3], txt4);
                                                  LCD_out(2, 4, txt4);       */

                                                 for(i=0;i<4;i++)
                                                 {
                                                     if(Display1[i]==48)
                                                     {
                                                     D1[i]=0;
                                                     }
                                                     else if(Display1[i]==49)
                                                     {
                                                     D1[i]=1;
                                                     }
                                                     else if(Display1[i]==50)
                                                     {
                                                     D1[i]=2;
                                                     }
                                                     else if(Display1[i]==51)
                                                     {
                                                     D1[i]=3;
                                                     }
                                                     else if(Display1[i]==52)
                                                     {
                                                     D1[i]=4;
                                                     }
                                                     else if(Display1[i]==53)
                                                     {
                                                     D1[i]=5;
                                                     }
                                                     else if(Display1[i]==54)
                                                     {
                                                     D1[i]=6;
                                                     }
                                                     else if(Display1[i]==55)
                                                     {
                                                     D1[i]=7;
                                                     }
                                                     else if(Display1[i]==56)
                                                     {
                                                     D1[i]=8;
                                                     }
                                                     else if(Display1[i]==57)
                                                     {
                                                     D1[i]=9;
                                                     }
                                                 }
                                                 /*for(i=0;i<4;i++)
                                                 {LCD_chr(2, i+1, Display1[i]);}  */


       ip2 = ADC_Read(1)*scaler2;
       //trying out for producing an ascii value
                                                 vDisp2[0] = ip2 / 1000;
                                                 vDisp2[1] = (ip2 / 100) % 10;
                                                 vDisp2[2] = (ip2 % 100) / 10;
                                                 vDisp2[3] = ip2 % 10;                      //Extract 100, 10, 1 place value
                                                 Display2[0] = vDisp2[0] + 48;
                                                 Display2[1] = vDisp2[1] + 48;
                                                 Display2[2] = vDisp2[2] + 48;
                                                 Display2[3] = vDisp2[3] + 48;            //Convert to ASCII value

                                                 for(i=0;i<4;i++)
                                                 {
                                                     if(Display2[i]==48)
                                                     {
                                                     D2[i]=0;
                                                     }
                                                     else if(Display2[i]==49)
                                                     {
                                                     D2[i]=1;
                                                     }
                                                     else if(Display2[i]==50)
                                                     {
                                                     D2[i]=2;
                                                     }
                                                     else if(Display2[i]==51)
                                                     {
                                                     D2[i]=3;
                                                     }
                                                     else if(Display2[i]==52)
                                                     {
                                                     D2[i]=4;
                                                     }
                                                     else if(Display2[i]==53)
                                                     {
                                                     D2[i]=5;
                                                     }
                                                     else if(Display2[i]==54)
                                                     {
                                                     D2[i]=6;
                                                     }
                                                     else if(Display2[i]==55)
                                                     {
                                                     D2[i]=7;
                                                     }
                                                     else if(Display2[i]==56)
                                                     {
                                                     D2[i]=8;
                                                     }
                                                     else if(Display2[i]==57)
                                                     {
                                                     D2[i]=9;
                                                     }
                                                 }
                                                /*for(i=0;i<4;i++)
                                                 {LCD_chr(2, i+1, Display2[i]);}  */

      ip3 = ADC_Read(2)*scaler3;
       //trying out for producing an ascii value
                                                 vDisp3[0] = ip3 / 1000;
                                                 vDisp3[1] = (ip3 / 100) % 10;
                                                 vDisp3[2] = (ip3 % 100) / 10;
                                                 vDisp3[3] = ip3 % 10;                      //Extract 100, 10, 1 place value
                                                 Display3[0] = vDisp3[0] + 48;
                                                 Display3[1] = vDisp3[1] + 48;
                                                 Display3[2] = vDisp3[2] + 48;
                                                 Display3[3] = vDisp3[3] + 48;            //Convert to ASCII value

                                                 for(i=0;i<4;i++)
                                                 {
                                                     if(Display3[i]==48)
                                                     {
                                                     D3[i]=0;
                                                     }
                                                     else if(Display3[i]==49)
                                                     {
                                                     D3[i]=1;
                                                     }
                                                     else if(Display3[i]==50)
                                                     {
                                                     D3[i]=2;
                                                     }
                                                     else if(Display3[i]==51)
                                                     {
                                                     D3[i]=3;
                                                     }
                                                     else if(Display3[i]==52)
                                                     {
                                                     D3[i]=4;
                                                     }
                                                     else if(Display3[i]==53)
                                                     {
                                                     D3[i]=5;
                                                     }
                                                     else if(Display3[i]==54)
                                                     {
                                                     D3[i]=6;
                                                     }
                                                     else if(Display3[i]==55)
                                                     {
                                                     D3[i]=7;
                                                     }
                                                     else if(Display3[i]==56)
                                                     {
                                                     D3[i]=8;
                                                     }
                                                     else if(Display3[i]==57)
                                                     {
                                                     D3[i]=9;
                                                     }
                                                 }
                                                 /*for(i=0;i<4;i++)
                                                 {LCD_chr(2, i+1, Display3[i]);}  */

      ip4 = ADC_Read(3)*scaler4;
       //trying out for producing an ascii value
                                                 vDisp4[0] = ip4 / 1000;
                                                 vDisp4[1] = (ip4 / 100) % 10;
                                                 vDisp4[2] = (ip4 % 100) / 10;
                                                 vDisp4[3] = ip4 % 10;                      //Extract 100, 10, 1 place value
                                                 Display4[0] = vDisp4[0] + 48;
                                                 Display4[1] = vDisp4[1] + 48;
                                                 Display4[2] = vDisp4[2] + 48;
                                                 Display4[3] = vDisp4[3] + 48;            //Convert to ASCII value

                                                 for(i=0;i<4;i++)
                                                 {
                                                     if(Display4[i]==48)
                                                     {
                                                     D4[i]=0;
                                                     }
                                                     else if(Display4[i]==49)
                                                     {
                                                     D4[i]=1;
                                                     }
                                                     else if(Display4[i]==50)
                                                     {
                                                     D4[i]=2;
                                                     }
                                                     else if(Display4[i]==51)
                                                     {
                                                     D4[i]=3;
                                                     }
                                                     else if(Display4[i]==52)
                                                     {
                                                     D4[i]=4;
                                                     }
                                                     else if(Display4[i]==53)
                                                     {
                                                     D4[i]=5;
                                                     }
                                                     else if(Display4[i]==54)
                                                     {
                                                     D4[i]=6;
                                                     }
                                                     else if(Display4[i]==55)
                                                     {
                                                     D4[i]=7;
                                                     }
                                                     else if(Display4[i]==56)
                                                     {
                                                     D4[i]=8;
                                                     }
                                                     else if(Display4[i]==57)
                                                     {
                                                     D4[i]=9;
                                                     }
                                                 }
                                                 /*for(i=0;i<4;i++)
                                                 {LCD_chr(2, i+1, Display4[i]);}  */


      ip5 = ADC_Read(4)*scaler5;
       //trying out for producing an ascii value
                                                 vDisp5[0] = ip5 / 1000;
                                                 vDisp5[1] = (ip5 / 100) % 10;
                                                 vDisp5[2] = (ip5 % 100) / 10;
                                                 vDisp5[3] = ip5 % 10;                      //Extract 100, 10, 1 place value
                                                 Display5[0] = vDisp5[0] + 48;
                                                 Display5[1] = vDisp5[1] + 48;
                                                 Display5[2] = vDisp5[2] + 48;
                                                 Display5[3] = vDisp5[3] + 48;            //Convert to ASCII value

                                                 for(i=0;i<4;i++)
                                                 {
                                                     if(Display5[i]==48)
                                                     {
                                                     D5[i]=0;
                                                     }
                                                     else if(Display5[i]==49)
                                                     {
                                                     D5[i]=1;
                                                     }
                                                     else if(Display5[i]==50)
                                                     {
                                                     D5[i]=2;
                                                     }
                                                     else if(Display5[i]==51)
                                                     {
                                                     D5[i]=3;
                                                     }
                                                     else if(Display5[i]==52)
                                                     {
                                                     D5[i]=4;
                                                     }
                                                     else if(Display5[i]==53)
                                                     {
                                                     D5[i]=5;
                                                     }
                                                     else if(Display5[i]==54)
                                                     {
                                                     D5[i]=6;
                                                     }
                                                     else if(Display5[i]==55)
                                                     {
                                                     D5[i]=7;
                                                     }
                                                     else if(Display5[i]==56)
                                                     {
                                                     D5[i]=8;
                                                     }
                                                     else if(Display5[i]==57)
                                                     {
                                                     D5[i]=9;
                                                     }
                                                 }
                                                 /*for(i=0;i<4;i++)
                                                 {LCD_chr(2, i+1, Display5[i]);}  */



      ip6 = ADC_Read(5)*scaler6;
       //trying out for producing an ascii value
                                                 vDisp6[0] = ip6 / 1000;
                                                 vDisp6[1] = (ip6 / 100) % 10;
                                                 vDisp6[2] = (ip6 % 100) / 10;
                                                 vDisp6[3] = ip6 % 10;                      //Extract 100, 10, 1 place value
                                                 Display6[0] = vDisp6[0] + 48;
                                                 Display6[1] = vDisp6[1] + 48;
                                                 Display6[2] = vDisp6[2] + 48;
                                                 Display6[3] = vDisp6[3] + 48;            //Convert to ASCII value

                                                 for(i=0;i<4;i++)
                                                 {
                                                     if(Display6[i]==48)
                                                     {
                                                     D6[i]=0;
                                                     }
                                                     else if(Display6[i]==49)
                                                     {
                                                     D6[i]=1;
                                                     }
                                                     else if(Display6[i]==50)
                                                     {
                                                     D6[i]=2;
                                                     }
                                                     else if(Display6[i]==51)
                                                     {
                                                     D6[i]=3;
                                                     }
                                                     else if(Display6[i]==52)
                                                     {
                                                     D6[i]=4;
                                                     }
                                                     else if(Display6[i]==53)
                                                     {
                                                     D6[i]=5;
                                                     }
                                                     else if(Display6[i]==54)
                                                     {
                                                     D6[i]=6;
                                                     }
                                                     else if(Display6[i]==55)
                                                     {
                                                     D6[i]=7;
                                                     }
                                                     else if(Display6[i]==56)
                                                     {
                                                     D6[i]=8;
                                                     }
                                                     else if(Display6[i]==57)
                                                     {
                                                     D6[i]=9;
                                                     }
                                                 }
                                                 /*for(i=0;i<4;i++)
                                                 {LCD_chr(2, i+1, Display6[i]);}  */


      ip7 = ADC_Read(6);
       //trying out for producing an ascii value
                                                 vDisp7[0] = ip7 / 1000;
                                                 vDisp7[1] = (ip7 / 100) % 10;
                                                 vDisp7[2] = (ip7 % 100) / 10;
                                                 vDisp7[3] = ip7 % 10;                      //Extract 100, 10, 1 place value
                                                 Display7[0] = vDisp7[0] + 48;
                                                 Display7[1] = vDisp7[1] + 48;
                                                 Display7[2] = vDisp7[2] + 48;
                                                 Display7[3] = vDisp7[3] + 48;            //Convert to ASCII value

                                                 for(i=0;i<4;i++)
                                                 {
                                                     if(Display7[i]==48)
                                                     {
                                                     D7[i]=0;
                                                     }
                                                     else if(Display7[i]==49)
                                                     {
                                                     D7[i]=1;
                                                     }
                                                     else if(Display7[i]==50)
                                                     {
                                                     D7[i]=2;
                                                     }
                                                     else if(Display7[i]==51)
                                                     {
                                                     D7[i]=3;
                                                     }
                                                     else if(Display7[i]==52)
                                                     {
                                                     D7[i]=4;
                                                     }
                                                     else if(Display7[i]==53)
                                                     {
                                                     D7[i]=5;
                                                     }
                                                     else if(Display7[i]==54)
                                                     {
                                                     D7[i]=6;
                                                     }
                                                     else if(Display7[i]==55)
                                                     {
                                                     D7[i]=7;
                                                     }
                                                     else if(Display7[i]==56)
                                                     {
                                                     D7[i]=8;
                                                     }
                                                     else if(Display7[i]==57)
                                                     {
                                                     D7[i]=9;
                                                     }
                                                 }
                                                 /*for(i=0;i<4;i++)
                                                 {LCD_chr(2, i+1, Display7[i]);}  */

      ip8 = ADC_Read(7);
       //trying out for producing an ascii value
                                                 vDisp8[0] = ip8 / 1000;
                                                 vDisp8[1] = (ip8 / 100) % 10;
                                                 vDisp8[2] = (ip8 % 100) / 10;
                                                 vDisp8[3] = ip8 % 10;                      //Extract 100, 10, 1 place value
                                                 Display8[0] = vDisp8[0] + 48;
                                                 Display8[1] = vDisp8[1] + 48;
                                                 Display8[2] = vDisp8[2] + 48;
                                                 Display8[3] = vDisp8[3] + 48;            //Convert to ASCII value

                                                 for(i=0;i<4;i++)
                                                 {
                                                     if(Display8[i]==48)
                                                     {
                                                     D8[i]=0;
                                                     }
                                                     else if(Display8[i]==49)
                                                     {
                                                     D8[i]=1;
                                                     }
                                                     else if(Display8[i]==50)
                                                     {
                                                     D8[i]=2;
                                                     }
                                                     else if(Display8[i]==51)
                                                     {
                                                     D8[i]=3;
                                                     }
                                                     else if(Display8[i]==52)
                                                     {
                                                     D8[i]=4;
                                                     }
                                                     else if(Display8[i]==53)
                                                     {
                                                     D8[i]=5;
                                                     }
                                                     else if(Display8[i]==54)
                                                     {
                                                     D8[i]=6;
                                                     }
                                                     else if(Display8[i]==55)
                                                     {
                                                     D8[i]=7;
                                                     }
                                                     else if(Display8[i]==56)
                                                     {
                                                     D8[i]=8;
                                                     }
                                                     else if(Display8[i]==57)
                                                     {
                                                     D8[i]=9;
                                                     }
                                                 }
                                                 /*for(i=0;i<4;i++)
                                                 {LCD_chr(2, i+1, Display8[i]);}  */

       res[3]=D1[3]+D2[3]+D3[3]+D4[3]+D5[3]+D6[3]+D7[3]+D8[3];
      //----------------------------------------calculation for res[2]
      if(res[3]>9 && res[3]<20)
      {
      res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+1;
      res[3]= res[3]-10;
      }
      else if(res[3]>19 && res[3]<30)
      {
      res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+2;
      res[3]= res[3]-20;
      }
      else if(res[3]>29 && res[3]<40)
      {
      res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+3;
      res[3]= res[3]-30;
      }
      else if(res[3]>39 && res[3]<50)
      {
      res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+4;
      res[3]= res[3]-40;
      }
      else if(res[3]>49 && res[3]<60)
      {
      res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+5;
      res[3]= res[3]-50;
      }
      else if(res[3]>59 && res[3]<70)
      {
      res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+6;
      res[3]= res[3]-60;
      }
      else if(res[3]>69 && res[3]<80)
      {
      res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2]+7;
      res[3]= res[3]-70;
      }
      else
      {
      res[2]= D1[2]+D2[2]+D3[2]+D4[2]+D5[2]+D6[2]+D7[2]+D8[2];
      }
       FloatToStr(res[3], txt4);
       LCD_out(2, 4, txt4);

      //----------------------------------------calculation for res[1]
      if(res[2]>9 && res[2]<20)
      {
      res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+1;
      res[2]= res[2]-10;
      }
      else if(res[2]>19 && res[2]<30)
      {
      res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+2;
      res[2]= res[2]-20;
      }
      else if(res[2]>29 && res[2]<40)
      {
      res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+3;
      res[2]= res[2]-30;
      }
      else if(res[2]>39 && res[2]<50)
      {
      res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+4;
      res[2]= res[2]-40;
      }
      else if(res[2]>49 && res[2]<60)
      {
      res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+5;
      res[2]= res[2]-50;
      }
      else if(res[2]>59 && res[2]<70)
      {
      res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+6;
      res[2]= res[2]-60;
      }
      else if(res[2]>69 && res[2]<80)
      {
      res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1]+7;
      res[2]= res[2]-70;
      }
      else
      {
      res[1]= D1[1]+D2[1]+D3[1]+D4[1]+D5[1]+D6[1]+D7[1]+D8[1];
      }

       FloatToStr(res[2], txt3);
       LCD_out(2, 3, txt3);

      //----------------------------------------calculation for res[0]
      if(res[1]>9 && res[1]<20)
      {
      res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+1;
      res[1]= res[1]-10;
      }
      else if(res[1]>19 && res[1]<30)
      {
      res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+2;
      res[1]= res[1]-20;
      }
      else if(res[1]>29 && res[1]<40)
      {
      res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+3;
      res[1]= res[1]-30;
      }
      else if(res[1]>39 && res[1]<50)
      {
      res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+4;
      res[1]= res[1]-40;
      }
      else if(res[1]>49 && res[1]<60)
      {
      res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+5;
      res[1]= res[1]-50;
      }
      else if(res[1]>59 && res[1]<70)
      {
      res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+6;
      res[1]= res[1]-60;
      }
      else if(res[1]>69 && res[1]<80)
      {
      res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0]+7;
      res[1]= res[1]-70;
      }
      else
      {
      res[0]= D1[0]+D2[0]+D3[0]+D4[0]+D5[0]+D6[0]+D7[0]+D8[0];
      }

       FloatToStr(res[1], txt2);
       LCD_out(2, 2, txt2);
       //msdelay(200);
       FloatToStr(res[0], txt1);
       LCD_out(2, 1, txt1);

       measured=res[0]*1000+res[1]*100+res[2]*10+res[3];
     /*  percent=(measured/reference)*100;
       FloatToStr(percent, percenttxt);
       LCD_out(2, 10, percenttxt);
       LCD_chr(2, 16, '%');      */
return measured;
}

float calculator(int measured)
{
float percent;
char percenttxt[6];
       percent=(measured/reference)*100;
       FloatToStr(percent, percenttxt);
       LCD_out(2, 10, percenttxt);
       LCD_chr(2, 16, '%');
return percent;
}

int convInt(char a)
{
int integer;
if(a==48)
   {
   integer=0;
   }
   else if(a==49)
   {
   integer=1;
   }
   else if(a==50)
   {
   integer=2;
   }
   else if(a==51)
   {
   integer=3;
   }
   else if(a==52)
   {
   integer=4;
   }
   else if(a==53)
   {
   integer=5;
   }
   else if(a==54)
   {
   integer=6;
   }
   else if(a==55)
   {
   integer=7;
   }
   else if(a==56)
   {
   integer=8;
   }
   else if(a==57)
   {
   integer=9;
   }
return integer;
}

float mod(float modulu)
{
float modulu;
if(modulu<0)
       {
       modulu=modulu*(-1);
       }
else
       {
       modulu=modulu;
       }
return modulu;
}


void main()
{
int compare,pressure;
char uart_rd,output[20],output1[20];
int PERCENT;
float x=0,y=0,op1,op2,Amp,Off;
float limit,limit1,limit2,REF,thresh_value,limit_value;            //This is a numeric percentage value prescribed to patient to limit the weight
char string[2];
unsigned short byteread,output3;

TRISC=0X00;
TRISA=0XFF;
TRISD=0X00;
TRISB=0X00;
TRISE=0X00;

Lcd_Init();
ADC_Init();                       // Initialize ADC module with default settings
//I2C1_Init(400000);              // initialize I2C communication
UART1_Init(38400);                // Initialize UART module at 9600 bps
Delay_ms(100);                    // Wait for UART module to stabilize
Lcd_Cmd(_LCD_CLEAR);
    //UART CODE STARTS HERE..

    Lcd_Out(1, 2, "Bluetooth waiting");
    Lcd_Out(2, 2, "for connection...");
    
Amp=((Upperbound-Lowerbound)/(max_data-min_data));    //5.0147;
Off=Upperbound-(Amp*max_data);
//FloatToStr(Amp, output);
//Lcd_Out(1, 1, output);
//FloatToStr(Off, output);
//Lcd_Out(1, 12, output);
/*while(1)
{
op1=masterloop();
op2=(Amp*op1)+Off;
 =(Amp*masterloop())+Off;
FloatToStr(op2, output);
Lcd_Out(1, 1, output);

FloatToStr(op1, output);
Lcd_Out(2, 10, output);
msdelay(500);
}  */

      while (!UART1_Data_Ready());     // If data is received
            {
            UART1_Read_Text(output, "ok", 255);    // reads text until 'OK' is found
            //UART1_Write_Text(output);             // sends back text
            //UART1_Write(10);                //LF
            //UART1_Write(13);                //CR
        
            UART1_Write_Text("Connection Successful!!");
            UART1_Write(10);                //LF
            UART1_Write(13);                //CR
            }
          msdelay(1000);

          /*            How to authinticate...
    compare = strcmp(output,password);
    if(compare==0)
    {
    UART1_Write_Text("Read barobar kelay bhavaa!! Zala connect!");
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Out(1, 4, "Electroware");
    Lcd_Out(2, 2, "Bluetooth connected!");
    }  */
    //msdelay(2000);
    
    // This loop intakes the initial base value..
    base =(Amp*masterloop())+Off;        // Here we set the maximum value of weight.

    UART1_Write_Text("Enter your limit... First Enter 10's place digit : ");
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR
    msdelay(1000);
    while (!UART1_Data_Ready());
            {
            UART1_Read_Text(output, "ok", 255);    // reads text until 'OK' is found
            //UART1_Write_Text(output);             // sends back text
            //UART1_Write(10);                //LF
            //UART1_Write(13);                //CR
            }
    //Lcd_Cmd(_LCD_CLEAR);
    //Lcd_Out(1, 1, "Getting limit: ");

    limit1= convInt(output[0]);              //At this point 10's place is accepted.

    UART1_Write_Text("Now Enter unit's place digit : ");
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR
    msdelay(1000);
    while (!UART1_Data_Ready());
    {
            UART1_Read_Text(output, "ok", 255);    // reads text until 'OK' is found
            //UART1_Write_Text(output);             // sends back text
            //UART1_Write(10);                //LF
            //UART1_Write(13);                //CR
    }
            
   limit2= convInt(output[0]);             //At this point 0's place is accepted.
            
            //UART1_Write(limit2);             // sends back text
            //UART1_Write(10);                //LF
            //UART1_Write(13);                //CR
            
   limit=(limit1*10)+limit2;       //Final limit calculation
   threshold=limit-50;
   FloatToStr(limit, output);

    UART1_Write_Text("Your prescribed limit is: ");
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR
    UART1_Write_Text(output);
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR

    //here starts algorithm to get maximum weight
    UART1_Write_Text("Put full pressure until you hear a 3 second buzzer.");
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR
    msdelay(1000);
    UART1_Write_Text("Press 'ok' when full pressure is applied.");
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR
    while (!UART1_Data_Ready());
            {
            UART1_Read_Text(output, "ok", 255);    // reads text until 'OK' is found
            }
    //Lcd_Cmd(_LCD_CLEAR);
    //Lcd_Out(1, 1, "Pressurize please!");
    msdelay(2000);                         //buffer time to apply pressure
    REF =(Amp*masterloop())+Off;;
    reference=REF - base;        // Here we set the maximum value of weight.
    if (reference<0)
                   {
                   reference=reference*(-1);
                   }
    //reference=mod(reference);
    PORTB.TRISB7=1;
    UART1_Write_Text("Thank you..");
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR
    msdelay(500);
    PORTB.TRISB7=0;               //buzzer goes off
    //Lcd_Cmd(_LCD_CLEAR);
    //Lcd_Out(1, 1, "Thanking you..");
    msdelay(2000);                //3 sec buzzer goes on..

     
    UART1_Write_Text("Electroware is ready to use now..");
    UART1_Write(10);                //LF
    UART1_Write(13);                //CR
    
    thresh_value= (threshold/100)*reference;
    limit_value=  (limit/100)*reference;
                                    {
                                         UART1_Write_Text("Base : ");
                                         //UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR
                                         FloatToStr(base, output);
                                         UART1_Write_Text(output);
                                         UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR

                                         UART1_Write_Text("Reading : ");
                                         //UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR
                                         FloatToStr(REF, output);
                                         UART1_Write_Text(output);
                                         UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR
                                         
                                         UART1_Write_Text("Reference : ");
                                         //UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR
                                         FloatToStr(reference, output);
                                         UART1_Write_Text(output);
                                         UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR
                                         
                                          UART1_Write_Text("Threshold value : ");
                                         //UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR
                                         FloatToStr(thresh_value, output);
                                         UART1_Write_Text(output);
                                         UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR
                                         
                                         UART1_Write_Text("Limit : ");
                                         //UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR
                                         FloatToStr(limit_value, output);
                                         UART1_Write_Text(output);
                                         UART1_Write(10);                //LF
                                         UART1_Write(13);                //CR

                                    }
///////////////////////////////////////////////////////////////
    //Lcd_Cmd(_LCD_CLEAR);
    //Lcd_Out(1, 4, "ELECRTOWARE");
    //Lcd_Cmd(_LCD_SECOND_ROW);
///////////////////////////////////////////////////////////////
msdelay(5000);
while(1)
  {
  
  {
                op2 =(Amp*masterloop())+Off;
                op1=op2-base;
                if (op1<0)
                   {
                   op1=op1*(-1);
                   }
                //op1=mod(op1);
                PERCENT=calculator(op1);
                   FloatToStr(op2, output);
                   UART1_Write_Text(output);
                   //UART1_Write(10);                //LF
                   UART1_Write(13);                //CR
                   FloatToStr(op1, output);
                   UART1_Write_Text(output);
                   UART1_Write(10);                //LF
                   UART1_Write(13);                //CR
                   msdelay(1000);
  }
  
        //if(PORTA.TRISA4==0)      Uncomment This to do reading first and then send all data at a time
           {
                UART1_Write_Text("Waiting for pressure..");
                UART1_Write(10);                //LF
                UART1_Write(13);                //CR
               do
               {
                op2=masterloop();
                op1=masterloop()-base;
                if (op1<0)
                   {
                   op1=op1*(-1);
                   }
                PERCENT=calculator(op1);
                   FloatToStr(op1, output);
                   UART1_Write_Text(output);
                   UART1_Write(10);                //LF
                   UART1_Write(13);                //CR
                   msdelay(1000);
               }while(PERCENT<threshold);
            msdelay(interval);               // waiting for 'interval/1000' sec before capturing the input values
                UART1_Write_Text("Crossed threshold :");
                //UART1_Write(10);                //LF
                UART1_Write(13);                //CR
            op2=masterloop();
            op1=masterloop()-base;
            if (op1<0)
                   {
                   op1=op1*(-1);
                   }
            PERCENT=calculator(op1);        //Sampling data after 'interval/1000' and calculating percentto write into memory
            pressure=PERCENT;

                   FloatToStr(op1, output);
                   UART1_Write_Text(output);
                   UART1_Write(10);                //LF
                   UART1_Write(13);                //CR
  //Here begins the writing process....
            if(PERCENT>=threshold)
              {
                  if(PERCENT>=limit)
                  {
                   PORTB.TRISB7=1;
                   UART1_Write_Text("ALERT!! Over-Pressurized!!!");
                   UART1_Write(10);                //LF
                   UART1_Write(13);                //CR
                   FloatToStr(pressure, output);
                   UART1_Write_Text(output);
                   UART1_Write(10);                //LF
                   UART1_Write(13);                //CR
                   msdelay(2000);            //1 sec buzzer goes on..
                   PORTB.TRISB7=0;
                  }
                  //msdelay(3000);               // waiting for 1 sec befoe writing into EEPROM.
                  //ANSEL  = 0;                // Configure AN pins as digital I/O
                  //ANSELH = 0;
                  /*I2C1_Init(400000);           // initialize I2C communication
                  I2C1_Start();                // issue I2C start signal
                  PORTC.RC0=I2C1_Wr(0xA2);     // WRITE .....send byte via I2C  (device address + W)
                  
                  PORTC.RC1=I2C1_Wr(x);        // send byte (address of EEPROM location)
                  PORTC.RC2=I2C1_Wr(PERCENT);  // send data (data to be written)
                  I2C1_Stop();                 // issue I2C stop signal
                  Delay_100ms();
                  x++;                             */

                      //following cycle is make the reading go back to <20
                      do{
                          op1=masterloop()-base;
                          PERCENT=calculator(op1);
                        }while(PERCENT>threshold);
                UART1_Write_Text("Under threshold. Ready for next step.");
                UART1_Write(10);                //LF
                UART1_Write(13);                //CR
               }

                msdelay(100);                 // This is the sampling frequency... after 0.1sec

            }                                 // if switch button=0 condition ends here

  //Here begins the reading process....  And simultaneously sending via BT HC-05
            //else                         Uncomment This to do reading first and then send all data at a time
            {
            //Lcd_Cmd(_LCD_CLEAR);                //clear display screen
                  /*if(y==255)
                  {
                  Lcd_Out(1, 2, "Bluetooth Transfer");
                  Lcd_Out(2, 6, "COMPLETE");
                  } */                             //Uncomment This to do reading first and then send all data at a time

                  //msdelay(1000);

                    //Lcd_Out(2, 4, "sending..     ");


                  //do                        Uncomment This to do reading first and then send all data at a time
                  {
                  UART1_Write_Text("YOUR PRESSURE is : ");
                  //UART1_Write(10);                //LF
                  UART1_Write(13);                //CR
                  FloatToStr(pressure, output);
                  UART1_Write_Text(output);
                  UART1_Write(10);                //LF
                  UART1_Write(13);                //CR
                  /*
                  I2C1_Start();              // issue I2C start signal

                  PORTC.RC5=I2C1_Wr(0xA2);   // send byte via I2C  (device address + W)
                  PORTC.RC6=I2C1_Wr(y);      //setting the pointer
                  I2C1_Repeated_Start();     // issue I2C signal repeated start
                  PORTC.RC5=I2C1_Wr(0xA3);   //reading command...
                  byteread = I2C1_Rd(0);     //reading the percent number from EEPROM
                  PORTD=byteread;            //sending that data on portD
                  ByteToStr(byteread, string);
                  LCD_out(2, 18, string);    //displaying the read data on lcd
                  msdelay(2000);             //Delay of 2 seconds..
                  I2C1_Stop();               // issue I2C stop signal
                  UART1_Write(byteread);
                  UART1_Write(10);                //LF
                  UART1_Write(13);                //CR
                  y++;  */
                 }//while(y==255);             Uncomment This to do reading first and then send all data at a time
            }
  }

}
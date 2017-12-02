#include<regx52.h>
void delayms(int);
void cmnd(void);
void delay(void);
void disp(void);

sbit COL1=P1^0;
sbit COL2=P1^1;
sbit COL3=P1^2;

sbit ROW1=P1^4;
sbit ROW2=P1^5;
sbit ROW3=P1^6;
sbit ROW4=P1^7;

unsigned char ROW=0,COL=0;
char value='\0', temp=0;
char keypad[4][3]=	{	'1','2','3',
				'4','5','6',
				'7','8','9',
				'*','0','#' };	  //look up table

char key(void);
void main(void)
{	int i;
	
  ROW1 = 0; //MAKE ALL ROWs IN KEYPAD TO ZERO
  ROW2 = 0;
	ROW3 = 0;
	ROW4 = 0;		
	COL1 = 1; // MAKE ALL COL'S AS HIGH
	COL2 = 1;
	COL3 = 1;

 
  while(1)
	{
		//LCD_init();
 P2=0x38;
 cmnd();
 P2=0x0F;
 cmnd();
 P2=0x01;
 cmnd();
 P2=0x06;
 cmnd();

		for(i=0;i<=3;i++)	//how many numbers you want to take	
		{   
			value =  key();//taking value from keypad
			delayms(50);				
			send_char(value);//sending value of keypad to lcd
			delayms(100);
		
		}
			}

} 
//checking which key is pressed
char key()
{
	
	while(1)
	{

		ROW1 = 0; //MAKE FIRST ROW IN KEYPAD TO ZERO
		ROW2 = 1;
		ROW3 = 1;
		ROW4 = 1;		
		COL1 = 1; // MAKE ALL COL'S AS HIGH
		COL2 = 1;
		COL3 = 1;
		if(COL1 == 0){while(COL1 == 0);ROW=1;COL=1;break;}  
		if(COL2 == 0){while(COL2 == 0);ROW=1;COL=2;break;}  
		if(COL3 == 0){while(COL3 == 0);ROW=1;COL=3;break;}  
		ROW1 = 1; 
		ROW2 = 0; //MAKE SECOND ROW IN KEYPAD TO ZERO
		ROW3 = 1;
		ROW4 = 1;		
		COL1 = 1; // MAKE ALL COL'S AS HIGH
		COL2 = 1;
		COL3 = 1;
		if(COL1 == 0){while(COL1 == 0);ROW=2;COL=1;break;}  
		if(COL2 == 0){while(COL2 == 0);ROW=2;COL=2;break;}  
		if(COL3 == 0){while(COL3 == 0);ROW=2;COL=3;break;}
		ROW1 = 1; 
		ROW2 = 1; 
		ROW3 = 0;//MAKE THIRD ROW IN KEYPAD TO ZERO
		ROW4 = 1;		
		COL1 = 1; // MAKE ALL COL'S AS HIGH
		COL2 = 1;
		COL3 = 1;
		if(COL1 == 0){while(COL1 == 0);ROW=3;COL=1;break;}  
		if(COL2 == 0){while(COL2 == 0);ROW=3;COL=2;break;}  
		if(COL3 == 0){while(COL3 == 0);ROW=3;COL=3;break;}
		ROW1 = 1; 
		ROW2 = 1; 
		ROW3 = 1;
		ROW4 = 0;//MAKE 4TH ROW IN KEYPAD TO ZERO		
		COL1 = 1; // MAKE ALL COL'S AS HIGH
		COL2 = 1;
		COL3 = 1;
		if(COL1 == 0){while(COL1 == 0);ROW=4;COL=1;break;}  
		if(COL2 == 0){while(COL2 == 0);ROW=4;COL=2;break;}  
		if(COL3 == 0){while(COL3 == 0);ROW=4;COL=3;break;}
		delayms(500);
	}

	return	keypad[ROW-1][COL-1];
}
void delayms(int x)
{
	int i=0;
	for(i=0;i<x;i++);
}
void send_char(char a)
{//displaying the keys pressed on keypad
	int i;
	P2=a;
	disp();
	delay();
 }
	
 void cmnd()
 {
  P0_0=0;
  P0_1=0;
  P0_2=1;
  P0_2=0;
  delay();
  }
  void disp()
  {
   P0_0=1;
   P0_1=0;
   P0_2=1;
   P0_2=0;
  delay();
  delay();
  }
 void delay()
 {
   int i;
   for(i=0;i<10000;i++)
   {
    P0_2=1;
	P0_0=0;//
	P0_1=1;//
	P0_2=1;//?
	}
 }
 
}	 
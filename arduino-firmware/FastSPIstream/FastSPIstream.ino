//FastSPIstream for Adalight/RPMlight with various bulb types.
//Built by RPMcCormick

#include <FastSPI_LED.h>

//------------------------------------------------------
// Config
//------------------------------------------------------

//LED communication-pin
#define PIN 4

//Number of LEDs
#define NUM 100

//Key bytes to syncronize begining of frame (BobLight prefix)
#define KEY1 0xFE
#define KEY2 0x00
#define KEY3 0x00

//Change order of RGB below for some LED pixel brands.
struct CRGB {unsigned char r; unsigned char g; unsigned char b;};
struct CRGB *leds;

//------------------------------------------------------
// Setup - Main Code
//------------------------------------------------------
void setup()
 {
  //FastSPI Setup (choose correct Chipset)
  FastSPI_LED.setLeds(NUM);
  FastSPI_LED.setChipset(CFastSPI_LED::SPI_TM1809);
  FastSPI_LED.setPin(PIN);
  FastSPI_LED.init();
  FastSPI_LED.start();
  leds = (struct CRGB*)FastSPI_LED.getRGBData(); 
  memset(leds, 0, NUM * 3);
  FastSPI_LED.show();

  //SerialPort Setup
  Serial.begin(115200);  //Baud Rate
  Serial.print("RPM\n"); //Signal Startup

  //Startup (brighten to full white, then off)
  for(int i=0; i<150; i++)
   {for(int j=0; j<NUM; j++)
     {leds[j].r = i;
      leds[j].g = i;
      leds[j].b = i;}
    FastSPI_LED.show();
    delay(15);}
  memset(leds, 0, NUM*3);
  FastSPI_LED.show();
  delay(500);
  
  for(int k=0; k<NUM; k++)
   {leds[k].r = 255;
    leds[k].g = 0;
    leds[k].b = 0;}
  FastSPI_LED.show();
  delay(500);

  for(int l=0; l<NUM; l++)
   {leds[l].r = 0;
    leds[l].g = 255;
    leds[l].b = 0;}
  FastSPI_LED.show();
  delay(500);

  for(int m=0; m<NUM; m++)
   {leds[m].r = 0;
    leds[m].g = 0;
    leds[m].b = 255;}
  FastSPI_LED.show();
  delay(500);

  for(int n=0; n<NUM; n++)
   {leds[n].r = 255;
    leds[n].g = 255;
    leds[n].b = 0;}
  FastSPI_LED.show();
  delay(500);

  for(int o=0; o<NUM; o++)
   {leds[o].r = 0;
    leds[o].g = 255;
    leds[o].b = 255;}
  FastSPI_LED.show();
  delay(500);

  for(int p=0; p<NUM; p++)
   {leds[p].r = 255;
    leds[p].g = 0;
    leds[p].b = 255;}
  FastSPI_LED.show();
  delay(500);

  for(int q=0; q<NUM; q++)
   {leds[q].r = 0;
    leds[q].g = 0;
    leds[q].b = 0;}
  FastSPI_LED.show();

  //Display Placment Pattern for 50-leds at 16x9 (15x8 + 4 corners)
  //leds[0].r = 255; leds[0].g = 255;  //Yellow Center Bottom
  //leds[1].g = 255; leds[2].g = 255; leds[3].g = 255; leds[4].g = 255; leds[5].g = 255; leds[6].g = 255; leds[7].g = 255;
  //leds[8].r = 255;  //Red Corner
  //leds[9].b = 255; leds[10].b = 255; leds[11].b = 255; leds[11].r = 63; leds[12].b = 255; leds[12].r = 255; leds[13].b = 255; leds[13].r = 255; leds[14].b = 255; leds[14].r = 63; leds[15].b = 255; leds[16].b = 255;
  //leds[17].r = 255;  //Red Corner
  //leds[18].g = 255; leds[19].g = 255; leds[20].g = 255; leds[21].g = 255; leds[22].g = 255; leds[23].g = 255; leds[24].g = 255;
  //leds[25].r = 255; leds[25].g = 255;  //Yellow Center Top
  //leds[26].g = 255; leds[27].g = 255; leds[28].g = 255; leds[29].g = 255; leds[30].g = 255; leds[31].g = 255; leds[32].g = 255;
  //leds[33].r = 255;  //Red Corner
  //leds[34].b = 255; leds[35].b = 255; leds[36].b = 255; leds[36].r = 63; leds[37].b = 255; leds[37].r = 255; leds[38].b = 255; leds[38].r = 255; leds[39].b = 255; leds[39].r = 63; leds[40].b = 255; leds[41].b = 255;
  //leds[42].r = 255;  //Red Corner
  //leds[43].g = 255; leds[44].g = 255; leds[45].g = 255; leds[46].g = 255; leds[47].g = 255; leds[48].g = 255; leds[49].g = 255;
  //FastSPI_LED.show();
 
  //MainLoop
  for(;;)
   {if (Serial.available())
     {if (Serial.read()==KEY1)
       {while (!Serial.available()) {}
        if (Serial.read()==KEY2)
         {while (!Serial.available()) {}
          if (Serial.read()==KEY3)
           {//Now Load All Bytes
            for (int pixel=0; pixel<NUM; pixel++)
             {while (!Serial.available()) {}
              leds[pixel].r = Serial.read();
              while (!Serial.available()) {}
              leds[pixel].g = Serial.read();
              while (!Serial.available()) {}
              leds[pixel].b = Serial.read();
             } 
            FastSPI_LED.show();
            //Serial.print(NUM);  //Signal Ready for Next Packet
 } } } } } }


//------------------------------------------------------
// End
//------------------------------------------------------

void loop()
{
  // loop() has more overhead then the for(;;) in setup above.
}

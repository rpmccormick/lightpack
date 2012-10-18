//------------------------------------------------------------------------------
//  MomoFastSPI
//------------------------------------------------------------------------------
//  by Ryan P. McCormick (https://svsrva.com)
//  Built for boblight/momo using the Arduino FastSPI library.
//------------------------------------------------------------------------------

#include <FastSPI_LED.h>

//------------------------------------------------------------------------------
// Config
//------------------------------------------------------------------------------

//Number of LEDs
#define NUM 50

//BaudRate:  (3key + (3rgb * NUM)) * MaxFPS * 10bits = MinBAUD
#define BAUD 115200

//Key bytes to syncronize begining of Frame.             [DEFAULT = FF 55 00]
#define KEY1 0xFF
//#define KEY2 0x55
//#define KEY3 0x0F

//LED communication-pin (SPI MOSI).                      [DEFAULT = 4]  (D4)
#define PIN 4

//Change order of RGB below for some LED pixel brands.   [DEFAULT = r; g; b;]
struct CRGB {unsigned char r; unsigned char g; unsigned char b;};
struct CRGB *leds;

//Choose correct LED Chipset below.                      [WS2811 = SPI_TM1809]

//------------------------------------------------------------------------------
// Setup
//------------------------------------------------------------------------------
void setup()
 {
  //FastSPI Setup
  FastSPI_LED.setLeds(NUM);
  FastSPI_LED.setChipset(CFastSPI_LED::SPI_TM1809);      //Choose LED Chipset
  FastSPI_LED.setPin(PIN);
  FastSPI_LED.init();
  FastSPI_LED.start();
  leds = (struct CRGB*)FastSPI_LED.getRGBData(); 
  memset(leds, 0, NUM * 3);
  FastSPI_LED.show();

  //SerialPort Setup and Announce Variables
  Serial.begin(BAUD);                                    //Set Baud Rate
  Serial.println("UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");    //Square-Waves for Client Auto-BAUD Detection
  Serial.println("                                ");
  Serial.println(" MomoFastSPI v0.2b by RPM       ");    //Version
  if (!Serial.available())                               //Skip if SP Data
   {Serial.print(" Baud: "); Serial.print(BAUD); Serial.println("                   "); 
    Serial.print(" Num:  "); Serial.print(NUM); Serial.println("                       ");
    Serial.print(" Key:  "); Serial.print(KEY1, HEX); Serial.print(" "); //Serial.print(KEY2, HEX); Serial.print(" 0"); Serial.print(KEY3, HEX);  Serial.println("                 ");
    Serial.print(" Pin:  "); Serial.print("D"); Serial.print(PIN); Serial.println("                       ");
    Serial.println(" Support: https://svsrva.com "); }
  Serial.println("                                ");

  //Startup Test (brighten to white, R,G,B, Off)
  if (!Serial.available())                               //Skip if SP Data
   {Serial.print("Running light test");
    for (int i=0; i<255; i++)
     {if (i==1) {Serial.print(".");}
      if (i==85) {Serial.print(".");}
      if (i==169) {Serial.print(".");}
      if (Serial.available())                            //Abort if SP Data
       {i = 256;}
      else
       {for (int j=0; j<NUM; j++)
         {if (i<150) {leds[j].r = i; leds[j].g = i; leds[j].b = i;}
          else if (i==150) {leds[j].r = 0; leds[j].g = 0; leds[j].b = 0;}
          else if (i<=185) {leds[j].r = 255; leds[j].g = 0; leds[j].b = 0;}
          else if (i<=220) {leds[j].r = 0; leds[j].g = 255; leds[j].b = 0;}
          else {leds[j].r = 0; leds[j].g = 0; leds[j].b = 255;} }
        FastSPI_LED.show();
        delay(12); } } 
    Serial.println("  complete!"); }

//------------------------------------------------------------------------------
//  Main Loop
//------------------------------------------------------------------------------
  long int k = 99999990;                                 //Time-Out Immediatly
  for(;;)
   {
    //Count Loops for Time-Out 
    while (k < 100000000)                                //Time-Out (100M=~5min)
     {k++;
      if (Serial.available())                            //Check for 3 KEY Bytes
       {if (Serial.read()==KEY1)
//         {while (!Serial.available()) {}
//          if (Serial.read()==KEY2)
//           {while (!Serial.available()) {}
//            if (Serial.read()==KEY3)
             {for (int pixel=0; pixel<NUM; pixel++)
               {
                while (!Serial.available()) {}
                leds[pixel].r = Serial.read();
               } 
              for (int pixel=0; pixel<NUM; pixel++)
               {
                while (!Serial.available()) {}
                leds[pixel].g = Serial.read();
               }
              for (int pixel=0; pixel<NUM; pixel++)
               {
                while (!Serial.available()) {}
                leds[pixel].b = Serial.read();
               }
               FastSPI_LED.show();                        //Send Array to LEDs
              Serial.print("U");                         //Signal for next Frame
              k = 0;                                     //Reset Time-Out
     } } }// } }

    //Time-Out (Turn Off LEDs)
    memset(leds, 0, NUM*3);
    FastSPI_LED.show();
    Serial.println();
    Serial.println("                                ");
    Serial.println("Time-Out...  Waiting for data...");
    Serial.println("Byte Form: [KEY][R1]..[Rn][B1]..[Bn][G1]..[Gn]");
    Serial.print("( "); Serial.print(KEY1, HEX); Serial.print(" "); //Serial.print(KEY2, HEX); Serial.print(" 0"); Serial.print(KEY3, HEX); Serial.println(" R1 G1 B1...Rn Gn Bn )");
    Serial.println("                                ");
    Serial.println("Will send 'U' after each Frame: ");
    k = 0;                                               //Reset Time-Out
 } }

//------------------------------------------------------------------------------
//  End
//------------------------------------------------------------------------------

void loop() {}  //loop() has more over-head then the for(;;) MainLoop above.

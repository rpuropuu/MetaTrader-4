//+------------------------------------------------------------------+
//|                                                Pivot4BoxesHW.mq4 |
//|                               Copyright © 2013, Poul_Trade_Forum |
//|                                                         Aborigen |
//|                                          http://forex.kbpauk.ru/ |
//+------------------------------------------------------------------+
#property copyright "Poul Trade Forum"
#property link      "http://forex.kbpauk.ru/"
//----
#property indicator_chart_window
//#property indicator_separate_window
#property indicator_buffers 7
#property indicator_color1 Yellow
#property indicator_color2 PaleGreen
#property indicator_color3 Pink
#property indicator_color4 PaleGreen
#property indicator_color5 Pink
#property indicator_color6 PaleGreen
#property indicator_color7 Pink
//---- input parameters
//---- buffers
extern int TOTAL = 2000;
extern int DrawHistoryOrders = 100;
extern bool DrawHistory = FALSE;
extern color COLOR_TEXT = White;
double PBuffer[];
double S1Buffer[];
double R1Buffer[];
double S2Buffer[];
double R2Buffer[];
double S3Buffer[];
double R3Buffer[];
int WShift[52];
double WD1[52];
//double WD2[52];
double WD3[52];
double WD4[52];
double WBox_Pivot[52];
double WBox_R1[52];
double WBox_S1[52];
double WBox_R2[52];
double WBox_S2[52];
double WBox_R3[52];
double WBox_S3[52];
datetime W[52];
string Pivot="",Sup1="S 1", Res1="R 1";
string Sup2="S 2", Res2="R 2", Sup3="S 3", Res3="R 3";
int fontsize=10;
double P,S1,R1,S2,R2,S3,R3;
double LastHigh,LastLow,x;
double num = 0;
double numlots = 0;
double profit = 0;
double allprofit = 0;
datetime V1,V2,V3,V4;

//datetime FLAG2,FLAG3,FLAG4;


//double Days[2][3];

//double V1_10;
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- TODO: add your code here
   ObjectDelete("Pivot");
   ObjectDelete("Sup1");
   ObjectDelete("Res1");
   ObjectDelete("Sup2");
   ObjectDelete("Res2");
   ObjectDelete("Sup3");
   ObjectDelete("Res3");
   ObjectDelete("Piv_Lots1");
   ObjectDelete("Piv_Lots2");
   ObjectDelete("Piv_SymbolCtrl");
   ObjectDelete("Piv_Profit1");
   ObjectDelete("Piv_Profit2");
   ObjectDelete("Piv_Free");
   ObjectDelete("Piv_Equ");
   ObjectDelete("Piv_Bal");
   ObjectDelete("Piv_-------------");
   ObjectDelete("Piv_------------");
   ObjectDelete("Piv_-----------");
   ObjectDelete("Piv_----------");
   ObjectDelete("Piv_---------");
   ObjectDelete("Piv_--------");
   ObjectDelete("Piv_-------");
   ObjectDelete("Box1_Piv");
   ObjectDelete("Piv_ThisSymbol");
   ObjectDelete("Piv_SymLastT0");
   ObjectDelete("Piv_SymLastT1");
   ObjectDelete("Piv_SymLastT2");
   ObjectDelete("Piv_SymLastT3");
   ObjectDelete("Piv_SymLastT4");
   ObjectDelete("Piv_SymLastT5");
   ObjectDelete("Piv_SymLastT6");
   ObjectDelete("Piv_SymLastT7");
   ObjectDelete("Piv_SymLastT8");
   ObjectDelete("Piv_SymLastT9");
   ObjectDelete("Piv_SymLastT10");
   ObjectDelete("Piv_SymLast0");
   ObjectDelete("Piv_SymLast1");
   ObjectDelete("Piv_SymLast2");
   ObjectDelete("Piv_SymLast3");
   ObjectDelete("Piv_SymLast4");
   ObjectDelete("Piv_SymLast5");
   ObjectDelete("Piv_SymLast6");
   ObjectDelete("Piv_SymLast7");
   ObjectDelete("Piv_SymLast8");
   ObjectDelete("Piv_SymLast9");
   ObjectDelete("Piv_SymLast10");
   ObjectDelete("Piv_SymDate0");
   ObjectDelete("Piv_SymDate1");
   ObjectDelete("Piv_SymDate2");
   ObjectDelete("Piv_SymDate3");
   ObjectDelete("Piv_SymDate4");
   ObjectDelete("Piv_SymDate5");
   ObjectDelete("Piv_SymDate6");
   ObjectDelete("Piv_SymDate7");
   ObjectDelete("Piv_SymDate8");
   ObjectDelete("Piv_SymDate9");
   ObjectDelete("Piv_SymDate10");
   
ObjectDelete("Box1_Piv");
ObjectDelete("S1_Day1");
ObjectDelete("S2_Day1");
ObjectDelete("S3_Day1");
ObjectDelete("R1_Day1");
ObjectDelete("R2_Day1");
ObjectDelete("R3_Day1");
ObjectDelete("Box1_PivLabel");
ObjectDelete("Box1_S1Label");
ObjectDelete("Box1_S2Label");
ObjectDelete("Box1_S3Label");
ObjectDelete("Box1_R1Label");
ObjectDelete("Box1_R2Label");
ObjectDelete("Box1_R3Label");

ObjectDelete("Box2_Piv");
ObjectDelete("S1_Day2");
ObjectDelete("S2_Day2");
ObjectDelete("S3_Day2");
ObjectDelete("R1_Day2");
ObjectDelete("R2_Day2");
ObjectDelete("R3_Day2");

ObjectDelete("Box2_PivLabel");
ObjectDelete("S1_Day2Label");
ObjectDelete("S2_Day2Label");
ObjectDelete("S3_Day2Label");
ObjectDelete("R1_Day2Label");
ObjectDelete("R2_Day2Label");
ObjectDelete("R3_Day2Label");

ObjectDelete("Box3_Piv");
ObjectDelete("S1_Day3");
ObjectDelete("S2_Day3");
ObjectDelete("S3_Day3");
ObjectDelete("R1_Day3");
ObjectDelete("R2_Day3");
ObjectDelete("R3_Day3");

ObjectDelete("Box3_PivLabel");
ObjectDelete("S1_Day3Label");
ObjectDelete("S2_Day3Label");
ObjectDelete("S3_Day3Label");
ObjectDelete("R1_Day3Label");
ObjectDelete("R2_Day3Label");
ObjectDelete("R3_Day3Label");   
ObjectDelete("Piv_ALLCtrl");    
ObjectDelete("PivRectangle");   
//---------------------------


ObjectDelete("Rectangle2");   
ObjectDelete("Rectangle3");
ObjectDelete("Rectangle4");
ObjectDelete("Box1_PivLab");
ObjectDelete("Box1_R1Lab");
ObjectDelete("Box1_R2Lab");
ObjectDelete("Box1_R3Lab");
ObjectDelete("Box1_S1Lab");
ObjectDelete("Box1_S2Lab");
ObjectDelete("Box1_S3Lab");
ObjectDelete("Box4_PivLabel");
ObjectDelete("S3_Day4Label");
ObjectDelete("S2_Day4Label");
ObjectDelete("S1_Day4Label");
ObjectDelete("R3_Day4Label");
ObjectDelete("R2_Day4Label");
ObjectDelete("R1_Day4Label");
ObjectDelete("Piv_Profit2C4");
ObjectDelete("Piv_Profit2C3");
ObjectDelete("Piv_Profit2C2");
ObjectDelete("Piv_Profit2C1");
ObjectDelete("Piv_Profit2C");
ObjectDelete("Piv_BalC");
ObjectDelete("Piv_EquC");
ObjectDelete("Piv_FreeC");
ObjectDelete("Piv_Lots1C");
ObjectDelete("Piv_Profit1C");

ObjectDelete("Piv_SymOrd");
ObjectDelete("Piv_SymOrdB");
ObjectDelete("Piv_SymOrdA");
ObjectDelete("Piv_SymOrdAB");
ObjectDelete("HLabelR");
//-----------------------------------
//int j = -1;   
     for (int cnt = 0; cnt < 500; cnt++){
          
              ObjectDelete("Piv_SymDateA"+cnt);
              ObjectDelete("Piv_SymLastA"+cnt);
              ObjectDelete("Piv_SymLastTA"+cnt);
              ObjectDelete("Piv_SymDateL"+cnt);
              ObjectDelete("Piv_SymDateP"+cnt);
              ObjectDelete("Piv_BackCSym"+cnt);
              ObjectDelete("Piv_BackCSymA"+cnt);
              ObjectDelete("Piv_SymDateA"+cnt);
              ObjectDelete("Piv_SymDateLS"+cnt);
              ObjectDelete("Piv_SymDateLA"+cnt);
              ObjectDelete("Piv_SymDatePA"+cnt);
              ObjectDelete("HLabelO"+cnt);
              ObjectDelete("HLabelS"+cnt);
              ObjectDelete("Trans"+cnt);
              ObjectDelete("OrdCommB"+cnt);
              ObjectDelete("Text—"+cnt);
              ObjectDelete("TextO"+cnt);
              ObjectDelete("Text—B"+cnt);
              ObjectDelete("TextOB"+cnt);
              ObjectDelete("WeekPivot"+cnt);
              ObjectDelete("WeekR1"+cnt);
              ObjectDelete("WeekS1"+cnt);
              ObjectDelete("WeekR2"+cnt);
              ObjectDelete("WeekS2"+cnt);
              ObjectDelete("WeekR3"+cnt);
              ObjectDelete("WeekS3"+cnt);
              ObjectDelete("PivWeek"+cnt);
              ObjectDelete("WRectangle"+cnt);
              ObjectDelete("Piv_SymOrderAB"+cnt);
              ObjectDelete("Piv_SymOrderA"+cnt);
              ObjectDelete("Piv_SymOrder"+cnt);
              ObjectDelete("Piv_SymOrderB"+cnt);
         
     //j++; 
     //if (j>DrawHistoryOrders)  break; 
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- indicator line
   SetIndexStyle(0,DRAW_LINE,STYLE_DOT,0,DarkGray);
   SetIndexStyle(1,DRAW_LINE,STYLE_DOT,0,SteelBlue);
   SetIndexStyle(2,DRAW_LINE,STYLE_DOT,0,SteelBlue);
   SetIndexStyle(3,DRAW_LINE,STYLE_DOT,0,Green);
   SetIndexStyle(4,DRAW_LINE,STYLE_DOT,0,Green);
   SetIndexStyle(5,DRAW_LINE,STYLE_DOT,0,Brown);
   SetIndexStyle(6,DRAW_LINE,STYLE_DOT,0,Brown);
   SetIndexBuffer(0,PBuffer);
   SetIndexBuffer(1,S1Buffer);
   SetIndexBuffer(2,R1Buffer);
   SetIndexBuffer(3,S2Buffer);
   SetIndexBuffer(4,R2Buffer);
   SetIndexBuffer(5,S3Buffer);
   SetIndexBuffer(6,R3Buffer);
//---- name for DataWindow and indicator subwindow label
   short_name="Pivot Point";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
//----
   SetIndexDrawBegin(0,1);
//----
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   num = 0;
   numlots = 0;
   profit = 0;
   allprofit = 0;
   int    counted_bars=IndicatorCounted();
   int limit, i;
//---- indicator calculation

for (i =52; i>=0; i--){
     ObjectCreate("PivWeek"+i,OBJ_VLINE,0,iTime(NULL,10080,i),Ask);
     ObjectSet("PivWeek"+i,OBJPROP_COLOR, CLR_NONE);
     ObjectSet("PivWeek"+i,OBJPROP_BACK, true);
     ObjectSet("PivWeek"+i,OBJPROP_SELECTABLE, false);
     ObjectSet("PivWeek"+i,OBJPROP_HIDDEN, true);
     ObjectSet("PivWeek"+i,OBJPROP_TIME1, iTime(NULL,10080,i));
W[i] = ObjectGet("PivWeek"+i,OBJPROP_TIME1);
WShift[i] = iBarShift(Symbol(),PERIOD_D1,W[i]);     
WD1[i] = iClose(Symbol(),PERIOD_D1, WShift[i]);
//WD2[i] = iOpen(Symbol(),PERIOD_D1, WShift[i]);
WD3[i] = iHigh(Symbol(),PERIOD_D1, WShift[i]);
WD4[i] = iLow(Symbol(),PERIOD_D1, WShift[i]);
WBox_Pivot[i] = (WD3[i]+WD4[i]+WD1[i])/3;
WBox_R1[i] = (2*WBox_Pivot[i])-WD4[i];
WBox_S1[i] = (2*WBox_Pivot[i])-WD3[i];
WBox_R2[i] = WBox_Pivot[i]+(WD3[i] - WD4[i]);
WBox_S2[i] = WBox_Pivot[i]-(WD3[i] - WD4[i]);
WBox_R3[i] = (2*WBox_Pivot[i])+(WD3[i]-(2*WD4[i]));
WBox_S3[i] = (2*WBox_Pivot[i])-((2* WD3[i])-WD4[i]);
if (i < 51){
WLine("WeekPivot"+i, White, W[i+1],W[i],WBox_Pivot[i+1]);
WLine("WeekR1"+i, DeepSkyBlue, W[i+1],W[i],WBox_R1[i+1]);
WLine("WeekS1"+i, DeepSkyBlue, W[i+1],W[i],WBox_S1[i+1]);
WLine("WeekR2"+i, GreenYellow, W[i+1],W[i],WBox_R2[i+1]);
WLine("WeekS2"+i, GreenYellow, W[i+1],W[i],WBox_S2[i+1]);
WLine("WeekR3"+i, Red, W[i+1],W[i],WBox_R3[i+1]);
WLine("WeekS3"+i, Red, W[i+1],W[i],WBox_S3[i+1]);
}
}
if (Period()>240){
for (i =52; i>=1; i--){
if (i < 50){
ObjectCreate("WRectangle"+i, OBJ_RECTANGLE, 0, W[i+1], WBox_R3[i],W[i], WBox_S3[i]);
ObjectSet("WRectangle"+i, OBJPROP_COLOR,0x401313);      
ObjectSet("WRectangle"+i, 0, W[i]);
ObjectSet("WRectangle"+i, 1, WBox_R3[i]);
ObjectSet("WRectangle"+i, 2, W[i-1]);
ObjectSet("WRectangle"+i, 3, WBox_S3[i]);
ObjectSet("WRectangle"+i,OBJPROP_SELECTABLE, false);
ObjectSet("WRectangle"+i,OBJPROP_HIDDEN, true);
}}
} else {
for (i =52; i>=1; i--){
if (i < 50){
ObjectDelete("WRectangle"+i);
}}
}
/*
ObjectCreate("HLabelR",OBJ_ARROW_RIGHT_PRICE,0,Time[0],Bid);
ObjectSet("HLabelR", 0, Time[0]);
ObjectSet("HLabelR", 1, Bid);
ObjectSet("HLabelR",OBJPROP_BACK,true);
ObjectSet("HLabelR",OBJPROP_SELECTABLE, false);
ObjectSet("HLabelR",OBJPROP_HIDDEN, true);
ObjectSet("HLabelR",OBJPROP_COLOR,Yellow);
*/


ObjectCreate("PivDay1",OBJ_VLINE,0,iTime(NULL,10080,0),Ask);
ObjectSet("PivDay1",OBJPROP_COLOR, CLR_NONE);
ObjectSet("PivDay1",OBJPROP_BACK, true);
ObjectSet("PivDay1",OBJPROP_SELECTABLE, false);
ObjectSet("PivDay1",OBJPROP_HIDDEN, true);
ObjectSet("PivDay1",0, iTime(NULL,10080,0));
V1 = ObjectGet("PivDay1",OBJPROP_TIME1);

ObjectCreate("PivDay2",OBJ_VLINE,0,iTime(NULL,10080,1),Ask);
ObjectSet("PivDay2",OBJPROP_COLOR, Green);
V2 = ObjectGet("PivDay2",OBJPROP_TIME1);

ObjectCreate("PivDay3",OBJ_VLINE,0,iTime(NULL,10080,2),Ask);
ObjectSet("PivDay3",OBJPROP_COLOR, Yellow);
V3 = ObjectGet("PivDay3",OBJPROP_TIME1);

ObjectCreate("PivDay4",OBJ_VLINE,0,iTime(NULL,10080,3),Ask);
ObjectSet("PivDay4",OBJPROP_COLOR, Red);
V4 = ObjectGet("PivDay4",OBJPROP_TIME1);

double D1 = iClose(Symbol(),PERIOD_D1, 0);
//double D2 = iOpen(Symbol(),PERIOD_D1, 0);
double D3 = iHigh(Symbol(),PERIOD_D1, 0);
double D4 = iLow(Symbol(),PERIOD_D1, 0);
double Box_Pivot = (D3+D4+D1)/3;
double Box_R1 = (2*Box_Pivot)-D4;
double Box_S1 = (2*Box_Pivot)-D3;
double Box_R2 = Box_Pivot+(D3 - D4);
double Box_S2 = Box_Pivot-(D3 - D4);
double Box_R3 = (2*Box_Pivot)+(D3-(2*D4));
double Box_S3 = (2*Box_Pivot)-((2* D3)-D4);

int Shift1 = iBarShift(Symbol(),PERIOD_D1,V1);
double D01 = iClose(Symbol(),PERIOD_D1, Shift1);
//double D02 = iOpen(Symbol(),PERIOD_D1, Shift1);
double D03 = iHigh(Symbol(),PERIOD_D1, Shift1);
double D04 = iLow(Symbol(),PERIOD_D1, Shift1);
double Box1_Pivot = (D03+D04+D01)/3;
double Box1_R1 = (2*Box1_Pivot)-D04;
double Box1_S1 = (2*Box1_Pivot)-D03;
double Box1_R2 = Box1_Pivot+(D03 - D04);
double Box1_S2 = Box1_Pivot-(D03 - D04);
double Box1_R3 = (2*Box1_Pivot)+(D03-(2*D04));
double Box1_S3 = (2*Box1_Pivot)-((2* D03)-D04);

int Shift2 = iBarShift(Symbol(),PERIOD_D1,V2);
double D11 = iClose(Symbol(),PERIOD_D1, Shift2);
//double D12 = iOpen(Symbol(),PERIOD_D1, Shift2);
double D13 = iHigh(Symbol(),PERIOD_D1, Shift2);
double D14 = iLow(Symbol(),PERIOD_D1, Shift2);
double Box2_Pivot = (D13+D14+D11)/3;
double Box2_R1 = (2*Box2_Pivot)-D14;
double Box2_S1 = (2*Box2_Pivot)-D13;
double Box2_R2 = Box2_Pivot+(D13 - D14);
double Box2_S2 = Box2_Pivot-(D13 - D14);
double Box2_R3 = (2*Box2_Pivot)+(D13-(2*D14));
double Box2_S3 = (2*Box2_Pivot)-((2* D13)-D14);

int Shift3 = iBarShift(Symbol(),PERIOD_D1,V3);
double D21 = iClose(Symbol(),PERIOD_D1, Shift3);
//double D22 = iOpen(Symbol(),PERIOD_D1, Shift3);
double D23 = iHigh(Symbol(),PERIOD_D1, Shift3);
double D24 = iLow(Symbol(),PERIOD_D1, Shift3);
double Box3_Pivot = (D23+D24+D21)/3;
double Box3_R1 = (2*Box3_Pivot)-D24;
double Box3_S1 = (2*Box3_Pivot)-D23;
double Box3_R2 = Box3_Pivot+(D23 - D24);
double Box3_S2 = Box3_Pivot-(D23 - D24);
double Box3_R3 = (2*Box3_Pivot)+(D23-(2*D24));
double Box3_S3 = (2*Box3_Pivot)-((2* D23)-D24);

int Shift4 = iBarShift(Symbol(),PERIOD_D1,V4);
double D31 = iClose(Symbol(),PERIOD_D1, Shift4);
//double D22 = iOpen(Symbol(),PERIOD_D1, Shift3);
double D33 = iHigh(Symbol(),PERIOD_D1, Shift4);
double D34 = iLow(Symbol(),PERIOD_D1, Shift4);
double Box4_Pivot = (D33+D34+D31)/3;
double Box4_R1 = (2*Box4_Pivot)-D34;
double Box4_S1 = (2*Box4_Pivot)-D33;
double Box4_R2 = Box4_Pivot+(D33 - D34);
double Box4_S2 = Box4_Pivot-(D33 - D34);
double Box4_R3 = (2*Box4_Pivot)+(D33-(2*D34));
double Box4_S3 = (2*Box4_Pivot)-((2* D33)-D34);


int ai_2 = 1;
int li_2 = 60 * (5 * Period());
datetime   l_datetime_21 = Time[0] + li_2 + 50 * (10 * ai_2 * Period());
datetime   l_datetime_22 = Time[0] + li_2 + 47 * (10 * (ai_2 + 1) * Period());
ObjectCreate("Rectangle2", OBJ_RECTANGLE, 0, l_datetime_21, Box2_R3,l_datetime_22, Box2_S3);
ObjectSet("Rectangle2", OBJPROP_COLOR,0x132013);      
ObjectSet("Rectangle2", 0, l_datetime_21);
ObjectSet("Rectangle2", 1, Box2_R3);
ObjectSet("Rectangle2", 2, l_datetime_22);
ObjectSet("Rectangle2", 3, Box2_S3);
ObjectSet("Rectangle2",OBJPROP_SELECTABLE, false);
ObjectSet("Rectangle2",OBJPROP_HIDDEN, true);

int ai_3 = 1;
int li_3 = 60 * (5 * Period());
datetime   l_datetime_31 = Time[0] + li_3 + 100 * (10 * ai_3 * Period());
datetime   l_datetime_32 = Time[0] + li_3 + 70 * (10 * (ai_3 + 1) * Period());
ObjectCreate("Rectangle3", OBJ_RECTANGLE, 0, l_datetime_31, Box3_R3,l_datetime_32, Box3_S3);
ObjectSet("Rectangle3", OBJPROP_COLOR, 0x114865);      
ObjectSet("Rectangle3", 0, l_datetime_31);
ObjectSet("Rectangle3", 1, Box3_R3);
ObjectSet("Rectangle3", 2, l_datetime_32);
ObjectSet("Rectangle3", 3, Box3_S3);
ObjectSet("Rectangle3",OBJPROP_SELECTABLE, false);
ObjectSet("Rectangle3",OBJPROP_HIDDEN, true);

int ai_4 = 1;
int li_4 = 60 * (5 * Period());
datetime   l_datetime_41 = Time[0] + li_4 + 149 * (10 * ai_4 * Period());
datetime   l_datetime_42 = Time[0] + li_4 + 95 * (10 * (ai_4 + 1) * Period());
ObjectCreate("Rectangle4", OBJ_RECTANGLE, 0, l_datetime_41, Box4_R3,l_datetime_42, Box4_S3);
ObjectSet("Rectangle4", OBJPROP_COLOR, 0x60);      
ObjectSet("Rectangle4", 0, l_datetime_41);
ObjectSet("Rectangle4", 1, Box4_R3);
ObjectSet("Rectangle4", 2, l_datetime_42);
ObjectSet("Rectangle4", 3, Box4_S3);
ObjectSet("Rectangle4",OBJPROP_SELECTABLE, false);
ObjectSet("Rectangle4",OBJPROP_HIDDEN, true);




      //--------------ÂÒÎË-ƒ÷-Û‚ÂÎË˜ËÎ-Ò‚ÓÔ-ÔÓ„‡ÏÏ‡-ÌÂ-·Û‰ÂÚ-‡·ÓÚ‡Ú¸----------------------
      //SymbolSwap = MarketInfo(Symbol(),MODE_SWAPLONG);
      //if (SymbolSwap > swap) return(0);
      //--------------ÔËÒ‚‡Ë‚‡ÂÏ-ÔÂÂÏÂÌÌ˚Ï-ÌÂÓ·ıÓ‰ËÏ˚Â-Ô‡‡ÏÂÚ˚---------------------------
     for (int cnt = 0 ; cnt <= OrdersTotal() ; cnt++){
          if (OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)){
              if (OrderType() == OP_BUY || OrderType() == OP_SELL) numlots += OrderLots();
              if (OrderType() == OP_BUY || OrderType() == OP_SELL) allprofit += OrderProfit();
              if (OrderSymbol() == Symbol()) num += OrderLots();
              if (OrderSymbol() == Symbol()) profit += OrderProfit();
              }
          }
          
     Text("Piv_Lots1", "All Lots  "+DoubleToString(numlots,2), LightGray,20,3,50,55);
     BackColor("Piv_Lots1C", "gggggggg", Navy,20,3,50,55);
     Text("Piv_Lots2", "Lots  "+DoubleToString(num,2), LightGray,20,1,50,60);
     Text("Piv_Profit1", "All Profit "+DoubleToString(allprofit,2), LightGray,20,3,50,15);
     Text("Piv_Profit2", "Profit  "+DoubleToString(profit,2), LightGray,20,1,50,90);
     Text("Piv_Free", "Free  "+DoubleToString(AccountFreeMargin(),2), LightGray,20,3,50,95);
     
     if (allprofit >= 0) BackColor("Piv_Profit1C", "gggggggg", ForestGreen,20,3,50,15);
         else BackColor("Piv_Profit1C", "gggggggg", Crimson,20,3,50,15);
     if (profit >= 0){
         BackColor("Piv_Profit2C", "gggggggg", ForestGreen,20,1,50,10);
         BackColor("Piv_Profit2C1", "gggggggg", ForestGreen,20,1,50,35);
         BackColor("Piv_Profit2C2", "gggggggg", ForestGreen,20,1,50,60);
         BackColor("Piv_Profit2C3", "gggggggg", ForestGreen,20,1,50,80);
         BackColor("Piv_Profit2C4", "gggggggg", ForestGreen,20,1,50,100);
         }
         else{
         BackColor("Piv_Profit2C", "gggggggg", Crimson,20,1,50,10);
         BackColor("Piv_Profit2C1", "gggggggg", Crimson,20,1,50,35);
         BackColor("Piv_Profit2C2", "gggggggg", Crimson,20,1,50,60);
         BackColor("Piv_Profit2C3", "gggggggg", Crimson,20,1,50,80);
         BackColor("Piv_Profit2C4", "gggggggg", Crimson,20,1,50,100);
         }
     if (AccountFreeMargin() >= 0) BackColor("Piv_FreeC", "gggggggg", ForestGreen,20,3,50,95);
         else  BackColor("Piv_FreeC", "gggggggg", Crimson,20,3,50,95);
         
     Text("Piv_Equ", "Equ  "+DoubleToString(AccountEquity(),2), LightGray,20,3,50,125);
     Text("Piv_Bal", "Bal  "+DoubleToString(AccountBalance(),2), LightGray,20,3,50,155);
     BackColor("Piv_EquC", "gggggggg", ForestGreen,20,3,50,125);
     BackColor("Piv_BalC", "gggggggg", ForestGreen,20,3,50,155);
     Text("Piv_ThisSymbol", Symbol()+"           Last Orders", LightGray,12,1,50,130);
     Text("Piv_SymbolCtrl", Symbol(), White,38,1,50,0);
     Text("Piv_ALLCtrl", "All Last Orders   ", LightGray,18,1,50,280);
     
     int j = 0;
     for (cnt = OrdersHistoryTotal(); cnt >= OrdersHistoryTotal()-TOTAL; cnt--){
          if (OrderSelect(cnt,SELECT_BY_POS,MODE_HISTORY)){
          if (OrderSymbol() == Symbol() && (OrderType() == 0 || OrderType() == 1)){
              if (OrderProfit() > 0) BackColor("Piv_BackCSym"+j,"ggggggggggggggggg", DarkOliveGreen,10,1,50,160+15*j);
              if (OrderProfit() <= 0) BackColor("Piv_BackCSym"+j,"ggggggggggggggggg", Maroon,10,1,50,160+15*j);
              if (OrderType()== 0) Text("Piv_SymDate"+j,"BUY ", COLOR_TEXT,10,1,200,160+15*j);
              if (OrderType()== 1) Text("Piv_SymDate"+j,"SELL", COLOR_TEXT,10,1,200,160+15*j);
              Text("Piv_SymDateL"+j,OrderLots(), COLOR_TEXT,10,1,150,160+15*j);
              Text("Piv_SymDateP"+j,OrderProfit(), COLOR_TEXT,10,1,50,160+15*j);
              j++;
          }
          if (j>=8) break;
          
          }
     }
     j = 0;
     for (cnt = OrdersHistoryTotal(); cnt >= OrdersHistoryTotal()-(OrdersHistoryTotal()-10); cnt--){
          if (OrderSelect(cnt,SELECT_BY_POS,MODE_HISTORY)){
          if (OrderType() == 0 || OrderType() == 1){
              if (OrderProfit() > 0) BackColor("Piv_BackCSymA"+j,"ggggggggggggggggg", DarkOliveGreen,10,1,50,310+15*j);
              if (OrderProfit() <= 0) BackColor("Piv_BackCSymA"+j,"ggggggggggggggggg", Maroon,10,1,50,310+15*j);
              if (OrderType()== 0) Text("Piv_SymDateA"+j,"BUY ", COLOR_TEXT,10,1,170,310+15*j);
              if (OrderType()== 1) Text("Piv_SymDateA"+j,"SELL", COLOR_TEXT,10,1,170,310+15*j);
              Text("Piv_SymDateLS"+j,OrderSymbol(), COLOR_TEXT,10,1,210,310+15*j);
              Text("Piv_SymDateLA"+j,OrderLots(), COLOR_TEXT,10,1,140,310+15*j);
              Text("Piv_SymDatePA"+j,OrderProfit(), COLOR_TEXT,10,1,50,310+15*j);
              
              j++;
              }
         }
         if (j>=15) break;
     }    
     
     
     
     if (Period() <= 240 && DrawHistory == TRUE){
     j = 0;
     for (cnt = OrdersHistoryTotal(); cnt >= OrdersHistoryTotal()-TOTAL; cnt--){
          if (OrderSelect(cnt,SELECT_BY_POS,MODE_HISTORY)){
          if (OrderSymbol() == Symbol() && (OrderType() == 0 || OrderType() == 1)){
               ObjectCreate("HLabelO"+j,OBJ_ARROW_LEFT_PRICE,0,OrderOpenTime(),OrderOpenPrice());
               ObjectSet("HLabelO"+j,OBJPROP_BACK,false);
               if (OrderType() == 0) ObjectSet("HLabelO"+j,OBJPROP_COLOR,PaleGreen);
               if (OrderType() == 1) ObjectSet("HLabelO"+j,OBJPROP_COLOR,Pink);
               ObjectCreate("HLabelS"+j,OBJ_ARROW_LEFT_PRICE,0,OrderCloseTime(),OrderClosePrice());
               ObjectSet("HLabelS"+j,OBJPROP_BACK,false);
               if (OrderProfit()>=0) ObjectSet("HLabelS"+j,OBJPROP_COLOR, PaleGreen);
               if (OrderProfit()<0) ObjectSet("HLabelS"+j,OBJPROP_COLOR, Pink);
               ObjectCreate("Trans"+j,OBJ_TREND,0,OrderOpenTime(),OrderOpenPrice(),OrderCloseTime(),OrderClosePrice());
               ObjectSet("Trans"+j,OBJPROP_BACK,true);
               ObjectSet("Trans"+j,OBJPROP_RAY,false);
               if (OrderProfit()>=0) ObjectSet("Trans"+j,OBJPROP_COLOR, Green);
               if (OrderProfit()<0) ObjectSet("Trans"+j,OBJPROP_COLOR, Red);
               ObjectSet("Trans"+j,OBJPROP_STYLE, STYLE_DOT);
               ObjectCreate("Text—"+j,OBJ_TEXT,0,OrderCloseTime()-500*Period(),OrderClosePrice()+2*Point);
               if (OrderProfit() >= 0) ObjectSetText("Text—"+j,OrderLots()+"  "+OrderProfit(),8,"Comic Sans MS",PaleGreen);
               if (OrderProfit() < 0) ObjectSetText("Text—"+j,OrderLots()+"  "+OrderProfit(),8,"Comic Sans MS",Pink);
               ObjectSet("Text—"+j,OBJPROP_BACK,false);
               ObjectSet("Text—"+j,0,OrderCloseTime()-600*Period());
               ObjectSet("Text—"+j,1,OrderClosePrice()+2*Point);
               if (Symbol() == "XAUUSD")ObjectSet("Text—"+j,1,OrderClosePrice()+20*Point);
               ObjectCreate("Text—B"+j,OBJ_TEXT,0,OrderCloseTime()-500*Period(),OrderClosePrice()+2*Point);
               if (OrderProfit() >= 0) ObjectSetText("Text—B"+j,"ggggggggggg",10,"Webdings",DarkGreen);
               if (OrderProfit() < 0) ObjectSetText("Text—B"+j,"ggggggggggg",10,"Webdings",Maroon);
               ObjectSet("Text—B"+j,OBJPROP_BACK,true);
               ObjectSet("Text—B"+j,0,OrderCloseTime()-500*Period());
               ObjectSet("Text—B"+j,1,OrderClosePrice()+2*Point);               
               if (Symbol() == "XAUUSD")ObjectSet("Text—B"+j,1,OrderClosePrice()+20*Point);

              j++;
          }
          if (j>=DrawHistoryOrders) break;
          
          }
     }
     }
     else{
     j = 0;
     for (cnt = OrdersHistoryTotal(); cnt >= OrdersHistoryTotal()-TOTAL; cnt--){
          if (OrderSelect(cnt,SELECT_BY_POS,MODE_HISTORY)){
               ObjectDelete("HLabelO"+j);
               ObjectDelete("HLabelS"+j);
               ObjectDelete("Trans"+j);
               ObjectDelete("OrdCommB"+j);
               ObjectDelete("Text—"+j);
               ObjectDelete("TextO"+j);
               ObjectDelete("Text—B"+j);
               ObjectDelete("TextOB"+j);
               j++;
          
          if (j>=DrawHistoryOrders) break;
          
          }
     }
     j = 0;
     for (cnt = 30; cnt >= 0; cnt--){
          ObjectDelete("Piv_SymOrder"+j);
          ObjectDelete("Piv_SymOrderB"+j);
          ObjectDelete("Piv_SymOrderA"+j);
          ObjectDelete("Piv_SymOrderAB"+j);
          ObjectDelete("HLabelN"+j);
          j++;

     }
     
     }
     Text("Piv_SymOrd","    NOW OPEND  "+Symbol(), LightGray,12,4,10,20);
     BackColor("Piv_SymOrdB","ggggggggggggggg", Navy,12,4,10,20);
     j = 0;
     for (cnt = OrdersTotal(); cnt >= 0; cnt--){
          if (OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)){
          if (OrderSymbol() == Symbol() && (OrderType() == 0 || OrderType() == 1)){
          if (OrderType() == 0)Text("Piv_SymOrder"+j,OrderTicket()+"  BUY  "+OrderLots()+"  "+OrderProfit(), PaleGreen,12,4,10,40+15*j);
          if (OrderType() == 1)Text("Piv_SymOrder"+j,OrderTicket()+"  SELL "+OrderLots()+"  "+OrderProfit(), Pink,12,4,10,40+15*j);
          ObjectCreate("HLabelN"+j,OBJ_ARROW_LEFT_PRICE,0,OrderOpenTime(),OrderOpenPrice());
          ObjectSet("HLabelN"+j,OBJPROP_BACK,true);
          ObjectSet("HLabelN"+j,OBJPROP_SELECTABLE, false);
          ObjectSet("HLabelN"+j,OBJPROP_HIDDEN, true);
          if (OrderType() == 0) ObjectSet("HLabelN"+j,OBJPROP_COLOR,Yellow);
          if (OrderType() == 1) ObjectSet("HLabelN"+j,OBJPROP_COLOR,Magenta);
          if (OrderProfit() >= 0) BackColor("Piv_SymOrderB"+j, "ggggggggggggggg", DarkOliveGreen,12,4,10,42+15*j);
          if (OrderProfit() < 0) BackColor("Piv_SymOrderB"+j, "ggggggggggggggg", Maroon,12,4,10,42+15*j);
          j++;
          }
        }
     }
     j++;
     j++;
     Text("Piv_SymOrdA","        NOW ALL OPEND", LightGray,12,4,10,30+15*j);
     BackColor("Piv_SymOrdAB","ggggggggggggggg", Navy,12,4,10,30+15*j);
for (cnt = OrdersTotal(); cnt >= 0; cnt--){
          if (OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)){
          if (OrderSymbol() != Symbol() && (OrderType() == 0 || OrderType() == 1)){
          if (OrderType() == 0)Text("Piv_SymOrderA"+j,OrderSymbol()+"  BUY  "+OrderLots()+"  "+OrderProfit(), PaleGreen,12,4,10,50+15*j);
          if (OrderType() == 1)Text("Piv_SymOrderA"+j,OrderSymbol()+"  SELL "+OrderLots()+"  "+OrderProfit(), Pink,12,4,10,50+15*j);
          if (OrderProfit() >= 0) BackColor("Piv_SymOrderAB"+j, "ggggggggggggggg", DarkOliveGreen,12,4,10,52+15*j);
          if (OrderProfit() < 0) BackColor("Piv_SymOrderAB"+j, "ggggggggggggggg", Maroon,12,4,10,52+15*j);
          j++;
          }
        }
     }
//==============================================================================================

Lab("Box1_PivLab", DarkGray, V1, Box_Pivot);
Lab("Box1_S1Lab", SteelBlue, V1, Box_S1);
Lab("Box1_S2Lab", Green, V1, Box_S2);
Lab("Box1_S3Lab", Brown, V1, Box_S3);
Lab("Box1_R1Lab", SteelBlue, V1, Box_R1);
Lab("Box1_R2Lab", Green, V1, Box_R2);
Lab("Box1_R3Lab", Brown, V1, Box_R3);

Line("Box1_Piv",White, 100, 0,Box1_Pivot);
Line("S1_Day1",DeepSkyBlue, 100, 0,Box1_S1);
Line("S2_Day1",GreenYellow, 100, 0,Box1_S2);
Line("S3_Day1",Red, 100, 0,Box1_S3);
Line("R1_Day1",DeepSkyBlue, 100, 0,Box1_R1);
Line("R2_Day1",GreenYellow, 100, 0,Box1_R2);
Line("R3_Day1",Red, 100, 0,Box1_R3);
Label("Box1_PivLabel", White, V1, Box1_Pivot);
Label("Box1_S1Label", DeepSkyBlue, V1, Box1_S1);
Label("Box1_S2Label", GreenYellow, V1, Box1_S2);
Label("Box1_S3Label", Red, V1, Box1_S3);
Label("Box1_R1Label", DeepSkyBlue, V1, Box1_R1);
Label("Box1_R2Label", GreenYellow, V1, Box1_R2);
Label("Box1_R3Label", Red, V1, Box1_R3);

LineBox1("Box2_Piv",White, 0, 0,Box2_Pivot);
LineBox1("S1_Day2",DeepSkyBlue, 0, 0,Box2_S1);
LineBox1("S2_Day2",GreenYellow, 0, 0,Box2_S2);
LineBox1("S3_Day2",Red, 0, 0,Box2_S3);
LineBox1("R1_Day2",DeepSkyBlue, 0, 0,Box2_R1);
LineBox1("R2_Day2",GreenYellow, 0, 0,Box2_R2);
LineBox1("R3_Day2",Red, 0, 0,Box2_R3);

LineBox2("Box3_Piv",White, 0, 0,Box3_Pivot);
LineBox2("S1_Day3",DeepSkyBlue, 0, 0,Box3_S1);
LineBox2("S2_Day3",GreenYellow, 0, 0,Box3_S2);
LineBox2("S3_Day3",Red, 0, 0,Box3_S3);
LineBox2("R1_Day3",DeepSkyBlue, 0, 0,Box3_R1);
LineBox2("R2_Day3",GreenYellow, 0, 0,Box3_R2);
LineBox2("R3_Day3",Red, 0, 0,Box3_R3);

LineBox3("Box4_Piv",White, 0, 0,Box4_Pivot);
LineBox3("S1_Day4",DeepSkyBlue, 0, 0,Box4_S1);
LineBox3("S2_Day4",GreenYellow, 0, 0,Box4_S2);
LineBox3("S3_Day4",Red, 0, 0,Box4_S3);
LineBox3("R1_Day4",DeepSkyBlue, 0, 0,Box4_R1);
LineBox3("R2_Day4",GreenYellow, 0, 0,Box4_R2);
LineBox3("R3_Day4",Red, 0, 0,Box4_R3);


//==============================================================================================

   if (counted_bars==0)
     {
      x=Period();
      if (x>240) return(-1);
      /*ObjectCreate("Pivot", OBJ_TEXT, 0, 0,0);
      ObjectSetText("Pivot", "      PIV",fontsize,"Arial",Magenta);
      ObjectCreate("Sup1", OBJ_TEXT, 0, 0, 0);
      ObjectSetText("Sup1", "      S 1",fontsize,"Arial",PaleGreen);
      ObjectCreate("Res1", OBJ_TEXT, 0, 0, 0);
      ObjectSetText("Res1", "      R 1",fontsize,"Arial",PaleGreen);
      ObjectCreate("Sup2", OBJ_TEXT, 0, 0, 0);
      ObjectSetText("Sup2", "      S 2",fontsize,"Arial",Pink);
      ObjectCreate("Res2", OBJ_TEXT, 0, 0, 0);
      ObjectSetText("Res2", "      R 2",fontsize,"Arial",Pink);
      ObjectCreate("Sup3", OBJ_TEXT, 0, 0, 0);
      ObjectSetText("Sup3", "      S 3",fontsize,"Arial",Red);
      ObjectCreate("Res3", OBJ_TEXT, 0, 0, 0);
      ObjectSetText("Res3", "      R 3",fontsize,"Arial",Red);*/
     }
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
   //   if(counted_bars>0) counted_bars--;
   limit=(Bars-counted_bars)-1;
//---- 
if (x>240) return(-1);
   else{  
   for(i=limit; i>=0;i--)
     {
      if (High[i+1]>LastHigh) LastHigh=High[i+1];
      if (Low[i+1]<LastLow) LastLow=Low[i+1];
      if (TimeDay(Time[i])!=TimeDay(Time[i+1]))
        {
         P=(LastHigh+LastLow+Close[i+1])/3;
         R1=(2*P)-LastLow;
         S1=(2*P)-LastHigh;
         R2=P+(LastHigh - LastLow);
         S2=P-(LastHigh - LastLow);
         R3=(2*P)+(LastHigh-(2*LastLow));
         S3=(2*P)-((2* LastHigh)-LastLow);
         LastLow=Open[i]; LastHigh=Open[i];
//----
         ObjectMove("Pivot", 0, Time[i],P);
         ObjectMove("Sup1", 0, Time[i],S1);
         ObjectMove("Res1", 0, Time[i],R1);
         ObjectMove("Sup2", 0, Time[i],S2);
         ObjectMove("Res2", 0, Time[i],R2);
         ObjectMove("Sup3", 0, Time[i],S3);
         ObjectMove("Res3", 0, Time[i],R3);
        }
      PBuffer[i]=P;
      S1Buffer[i]=S1;
      R1Buffer[i]=R1;
      S2Buffer[i]=S2;
      R2Buffer[i]=R2;
      S3Buffer[i]=S3;
      R3Buffer[i]=R3;
     }
    }
//----

   return(0);
  }
color Text(string name, string txt, color C, int w, int p, int X, int Y)
{  
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name, OBJPROP_CORNER, p);
   ObjectSet(name, OBJPROP_BACK, false);
   ObjectSet(name, OBJPROP_XDISTANCE, X);
   ObjectSet(name, OBJPROP_YDISTANCE, Y);
   ObjectSetText(name,txt,w,"Comic Sans MS", C);
   ObjectSet(name,OBJPROP_SELECTABLE, false);
   ObjectSet(name,OBJPROP_HIDDEN, true);
   return(0);
}

color BackColor(string name, string txt, color C, int w, int p, int X, int Y)
{  
   ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
   ObjectSet(name, OBJPROP_CORNER, p);
   ObjectSet(name, OBJPROP_BACK, true);
   ObjectSet(name, OBJPROP_XDISTANCE, X);
   ObjectSet(name, OBJPROP_YDISTANCE, Y);
   ObjectSetText(name,txt,w,"Webdings", C);
   ObjectSet(name,OBJPROP_SELECTABLE, false);
   ObjectSet(name,OBJPROP_HIDDEN, true);
   return(0);
}
//+------------------------------------------------------------------+
color LineBox1(string name, color C, int X, int Y,double L)
{  
   int ai_28 = 1;
   int li_56 = 60 * (5 * Period());
   datetime   l_datetime_32 = Time[0] + li_56 + 50 * (10 * ai_28 * Period());
   datetime   l_datetime_36 = Time[0] + li_56 + 48 * (10 * (ai_28 + 1) * Period());
      
   
   ObjectCreate(name+"Label", OBJ_ARROW_RIGHT_PRICE, 0, l_datetime_32, L);
   ObjectSet(name+"Label", OBJPROP_COLOR, C);
   ObjectSet(name+"Label", 0, l_datetime_32);
   ObjectSet(name+"Label", 1, L);
   ObjectSet(name+"Label", OBJPROP_BACK, false);
   ObjectSet(name+"Label",OBJPROP_SELECTABLE, false);
   ObjectSet(name+"Label",OBJPROP_HIDDEN, true);
   return(0);
}

color LineBox2(string name, color C, int X, int Y,double L)
{  
   int ai_28 = 1;
   int li_56 = 60 * (5 * Period());
   datetime   l_datetime_32 = Time[0] + li_56 + 100 * (10 * ai_28 * Period());
   datetime   l_datetime_36 = Time[0] + li_56 + 72 * (10 * (ai_28 + 1) * Period());
      
   
   ObjectCreate(name+"Label", OBJ_ARROW_RIGHT_PRICE, 0, l_datetime_32, L);
   ObjectSet(name+"Label", OBJPROP_COLOR, C);
   ObjectSet(name+"Label", 0, l_datetime_32);
   ObjectSet(name+"Label", 1, L);
   ObjectSet(name+"Label", OBJPROP_BACK, false);
   ObjectSet(name+"Label",OBJPROP_SELECTABLE, false);
   ObjectSet(name+"Label",OBJPROP_HIDDEN, true);
   return(0);
}


color LineBox3(string name, color C, int X, int Y,double L)
{  
   int ai_28 = 1;
   int li_56 = 60 * (5 * Period());
   datetime   l_datetime_32 = Time[0] + li_56 + 149 * (10 * ai_28 * Period());
   datetime   l_datetime_36 = Time[0] + li_56 + 95 * (10 * (ai_28 + 1) * Period());

   
   ObjectCreate(name+"Label", OBJ_ARROW_RIGHT_PRICE, 0, l_datetime_32, L);
   ObjectSet(name+"Label", OBJPROP_COLOR, C);
   ObjectSet(name+"Label", 0, l_datetime_32);
   ObjectSet(name+"Label", 1, L);
   ObjectSet(name+"Label", OBJPROP_BACK, false);
   ObjectSet(name+"Label",OBJPROP_SELECTABLE, false);
   ObjectSet(name+"Label",OBJPROP_HIDDEN, true);
   return(0);
}

color Line(string name, color C, int X, int Y,double L)
{  
   ObjectCreate(name, OBJ_TREND, 0, V1, L, Time[0], L);
   ObjectSet(name, 0, V1);
   ObjectSet(name, 2, Time[0]);
   ObjectSet(name, 1, L);
   ObjectSet(name, 3, L);
   ObjectSet(name, OBJPROP_RAY, false);
   ObjectSet(name, OBJPROP_BACK, false);
   ObjectSet(name, OBJPROP_COLOR, C);
   ObjectSet(name, OBJPROP_WIDTH, 2);
   ObjectSet(name,OBJPROP_SELECTABLE, false);
   ObjectSet(name,OBJPROP_HIDDEN, true);
   return(0);
}
color WLine(string name, color C, datetime T1,datetime T2,double WL)
{  
   ObjectCreate(name, OBJ_TREND, 0, T1, WL, T2, WL);
   ObjectSet(name, 0, T1);
   ObjectSet(name, 2, T2);
   ObjectSet(name, 1, WL);
   ObjectSet(name, 3, WL);
   ObjectSet(name, OBJPROP_RAY, false);
   ObjectSet(name, OBJPROP_BACK, false);
   ObjectSet(name, OBJPROP_COLOR, C);
   ObjectSet(name, OBJPROP_WIDTH, 2);
   ObjectSet(name,OBJPROP_SELECTABLE, false);
   ObjectSet(name,OBJPROP_HIDDEN, true);
   return(0);
}

color Label(string name, color C, datetime D, double p)
{  
   ObjectCreate(name, OBJ_ARROW_RIGHT_PRICE, 0, Time[0], p);
   ObjectSet(name, 0, Time[0]);
   ObjectSet(name, 1, p);
   ObjectSet(name, OBJPROP_COLOR, C);
   ObjectSet(name, OBJPROP_BACK, false);
   ObjectSet(name,OBJPROP_SELECTABLE, false);
   ObjectSet(name,OBJPROP_HIDDEN, true);
   return(0);
}

color Lab(string name, color C, datetime D, double p)
{  
   ObjectCreate(name, OBJ_ARROW_RIGHT_PRICE, 0, Time[0]+25000, p);
   ObjectSet(name, 0, Time[0]+400*Period());
   ObjectSet(name, 1, p);
   ObjectSet(name, OBJPROP_COLOR, C);
   ObjectSet(name, OBJPROP_BACK, false);
   ObjectSet(name,OBJPROP_SELECTABLE, false);
   ObjectSet(name,OBJPROP_HIDDEN, true);
   return(0);
}
//+------------------------------------------------------------------+

/*******************************************************************************************/
/*                                                        WatcherPanel.mq4                 */
/*                                                        Copyright © 2014, rpuropuu       */
/*                                                        pr3dator@bk.ru                   */
/*******************************************************************************************/
#property copyright "Copyright © 2014, Derun Grigoriy"
//===========================================================================================
//--------------ВХОДНЫЕ-ДАННЫЕ---------------------------------------------------------------
//===========================================================================================
//--------------можно-изменить-при-активации-робота------------------------------------------
//extern double  Lots0        = 0.02;   //минимальный объем ордера, не подлежащий изменениям

//extern 
string  BaseLot      = 0.15;   //
//extern 
string  LOTS         = 0.05;   //
extern int     MagicNumber  = 0;      //магическое число ордеров
extern int     Glubina      = 3;      //последние свечи для определения шипа
extern int     slippage     = 1;      //проскальзывание при закрытии ордера целиком, в пунктах
extern int     takeprofit   = 60;
extern int     stoploss     = 5;
extern bool    alert        = true;

//--------------внутренние-переменные-робота-изменять-нельзя---------------------------------
int            cnt          = 0;      //переменная для массивов
double         stop         = 0;      //
int            timeprev     = 0;      //переменная для запоминания времени открытия последней свечи
double         lo           = 0;
double         hi           = 0;
double         tp           = 0;
double         LotToClose   = 0;
double         chek         = 0;
int            TP           = 0;
int            away         = 0;     
double         numlots      = 0;
string         TEXT;
//string         namestop, nametp;
//int            ticket;
//===========================================================================================
//--------------ТЕЛО-ПРОГРАММЫ---------------------------------------------------------------
//===========================================================================================
void deinit(){
ObjectDelete("WatcherFLAG");
ObjectDelete("WatcherBACK");
ObjectDelete("WatcherBACKo");
ObjectDelete("WatcherBACKc");
ObjectDelete("WatcherMAIN");
ObjectDelete("WatcherLots");
ObjectDelete("WatcherSTOP");
ObjectDelete("WatcherSTOPh");
ObjectDelete("WatcherSTOPnl");
ObjectDelete("WatcherBUY");
ObjectDelete("WatcherSELL");
ObjectDelete("WatcherInput");
ObjectDelete("WatcherBUY+++");
ObjectDelete("WatcherBUY++");
ObjectDelete("WatcherBUY+");
ObjectDelete("WatcherSELL---");
ObjectDelete("WatcherSELL--");
ObjectDelete("WatcherSELL-");

}
void OnInit(){
BaseLot = NormalizeDouble(AccountFreeMargin()*0.000006,2);
/*
      ObjectCreate(0,"WatcherBACK",OBJ_RECTANGLE_LABEL ,1,0,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_XSIZE,358);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_YSIZE,150);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_BACK,true);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_ZORDER,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_BORDER_COLOR,CLR_NONE);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_BGCOLOR,CLR_NONE);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_COLOR,CLR_NONE);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_BORDER_TYPE,BORDER_RAISED);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_XDISTANCE,360);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_YDISTANCE,150);*/
      
      ObjectCreate(0,"WatcherBACKo",OBJ_RECTANGLE_LABEL ,1,0,0);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_XSIZE,165);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_YSIZE,105);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_BACK,true);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_ZORDER,1);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_BGCOLOR,Navy);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_BORDER_TYPE,BORDER_RAISED);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_XDISTANCE,350);
      ObjectSetInteger(0,"WatcherBACKo",OBJPROP_YDISTANCE,113);
      
      ObjectCreate(0,"WatcherBACKc",OBJ_RECTANGLE_LABEL ,1,0,0);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_XSIZE,165);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_YSIZE,105);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_BACK,true);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_ZORDER,1);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_BGCOLOR,0x60);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_BORDER_TYPE,BORDER_RAISED);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_XDISTANCE,180);
      ObjectSetInteger(0,"WatcherBACKc",OBJPROP_YDISTANCE,113); 
      
      ObjectCreate("WatcherFLAG", OBJ_BUTTON, 1, 0, 0);
      ObjectSet("WatcherFLAG", OBJPROP_XDISTANCE, 172);
      ObjectSet("WatcherFLAG", OBJPROP_YDISTANCE, 108);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_XSIZE,20);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_YSIZE,20);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherFLAG",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherFLAG",OBJPROP_TEXT,"O");
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BGCOLOR,Red);
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_COLOR,White);
            

      ObjectCreate("WatcherMAIN", OBJ_BUTTON, 1, 0, 0);
      ObjectSet("WatcherMAIN", OBJPROP_XDISTANCE, 147);
      ObjectSet("WatcherMAIN", OBJPROP_YDISTANCE, 108);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_XSIZE,125);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_YSIZE,20);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherMAIN",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_STATE,true);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherMAIN",OBJPROP_TEXT,"WATCHER ON");
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_BGCOLOR,Green);
      ObjectSetInteger(0,"WatcherMAIN",OBJPROP_COLOR,White);
      
      ObjectCreate("WatcherLots", OBJ_BUTTON, 1, 0, 0);
      ObjectSet("WatcherLots", OBJPROP_XDISTANCE, 292);
      ObjectSet("WatcherLots", OBJPROP_YDISTANCE, 82);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_XSIZE,50);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_YSIZE,16);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherLots",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherLots",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherLots",OBJPROP_TEXT,"LOTS");
      ObjectSetInteger(0,"WatcherLots",OBJPROP_BGCOLOR,Blue);
      ObjectSetInteger(0,"WatcherLots",OBJPROP_COLOR,White);

      ObjectCreate(0,"WatcherSTOP",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_XSIZE,150);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_YSIZE,20);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherSTOP",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherSTOP",OBJPROP_TEXT,"CLOSE ALL "+Symbol());
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_XDISTANCE,173);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_YDISTANCE,30);
      
      ObjectCreate(0,"WatcherSTOPh",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_XSIZE,150);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_YSIZE,20);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherSTOPh",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherSTOPh",OBJPROP_TEXT,"CLOSE HALF "+Symbol());
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_XDISTANCE,173);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_YDISTANCE,56);
      
      ObjectCreate(0,"WatcherSTOPnl",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_XSIZE,150);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_YSIZE,20);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherSTOPnl",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherSTOPnl",OBJPROP_TEXT,"SET NO LOSS "+Symbol());
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_XDISTANCE,173);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_YDISTANCE,82);           

      ObjectCreate(0,"WatcherBUY",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_XSIZE,150);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_YSIZE,20);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherBUY",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherBUY",OBJPROP_TEXT,"BUY "+Symbol());
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BGCOLOR,0x132013);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_COLOR,PaleGreen);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_XDISTANCE,342);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_YDISTANCE,108);
      
      ObjectCreate(0,"WatcherSELL",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_XSIZE,150);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_YSIZE,20);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherSELL",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherSELL",OBJPROP_TEXT,"SELL "+Symbol());
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_XDISTANCE,342);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_YDISTANCE,30);
      
      ObjectCreate(0,"WatcherInput",OBJ_EDIT,1,0,0);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_ALIGN,ALIGN_RIGHT);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_XSIZE,50);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_YSIZE,20);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherInput",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherInput",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherInput",OBJPROP_TEXT,BaseLot);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_BGCOLOR,White);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_COLOR,Black);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_XDISTANCE,292);
      ObjectSetInteger(0,"WatcherInput",OBJPROP_YDISTANCE,58);
      
      ObjectCreate(0,"WatcherBUY+++",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_XSIZE,45);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_YSIZE,10);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherBUY+++",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherBUY+++",OBJPROP_TEXT,"+ + +");
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_BGCOLOR,Green);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_XDISTANCE,238);
      ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_YDISTANCE,80);    
      
      ObjectCreate(0,"WatcherBUY++",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_XSIZE,45);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_YSIZE,10);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherBUY++",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherBUY++",OBJPROP_TEXT,"+ +");
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_BGCOLOR,Green);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_XDISTANCE,238);
      ObjectSetInteger(0,"WatcherBUY++",OBJPROP_YDISTANCE,63); 
      
      ObjectCreate(0,"WatcherBUY+",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_XSIZE,45);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_YSIZE,10);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherBUY+",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherBUY+",OBJPROP_TEXT,"+");
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_BGCOLOR,Green);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_XDISTANCE,238);
      ObjectSetInteger(0,"WatcherBUY+",OBJPROP_YDISTANCE,47);             
      
      
      ObjectCreate(0,"WatcherSELL---",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_XSIZE,45);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_YSIZE,10);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherSELL---",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherSELL---",OBJPROP_TEXT,"- - -");
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_BGCOLOR,Red);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_XDISTANCE,342);
      ObjectSetInteger(0,"WatcherSELL---",OBJPROP_YDISTANCE,80);    
      
      ObjectCreate(0,"WatcherSELL--",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_XSIZE,45);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_YSIZE,10);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherSELL--",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherSELL--",OBJPROP_TEXT,"- -");
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_BGCOLOR,Red);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_XDISTANCE,342);
      ObjectSetInteger(0,"WatcherSELL--",OBJPROP_YDISTANCE,63); 
      
      ObjectCreate(0,"WatcherSELL-",OBJ_BUTTON,1,0,0);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_XSIZE,45);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_YSIZE,10);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_CORNER,CORNER_RIGHT_LOWER);
      ObjectSetString(0,"WatcherSELL-",OBJPROP_FONT,"Comic Sans MS");
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_FONTSIZE,10);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_BACK,0);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_ZORDER,5);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_STATE,false);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetString(0,"WatcherSELL-",OBJPROP_TEXT,"-");
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_BGCOLOR,Red);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_XDISTANCE,342);
      ObjectSetInteger(0,"WatcherSELL-",OBJPROP_YDISTANCE,47);             
            
}




void OnChartEvent(const int id,         // идентификатор события  
                  const long& lparam,   // параметр события типа long
                  const double& dparam, // параметр события типа double
                  const string& sparam) // параметр события типа string
  {
//string namestop, nametp;  
double buf;
int ticket;
if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherFLAG")
     {
     bool FLAG = ObjectGetInteger(0,"WatcherFLAG",OBJPROP_STATE);
     if (FLAG == true){
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BGCOLOR,Green);
      ObjectSetString(0,"WatcherFLAG",OBJPROP_TEXT,"l");
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_COLOR,White);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BGCOLOR,Green);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BGCOLOR,Red);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BGCOLOR,Red);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BGCOLOR,Red);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BGCOLOR,Red);
         }
     if (FLAG == false){
      ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BGCOLOR,Red);
      ObjectSetString(0,"WatcherFLAG",OBJPROP_TEXT,"O");
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_COLOR,PaleGreen);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BGCOLOR,0x132013);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BGCOLOR,Maroon);      
         }

     }

if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherMAIN")
     {
     bool flag = ObjectGetInteger(0,"WatcherMAIN",OBJPROP_STATE);
     if (flag == true){
         ObjectSetInteger(0,"WatcherMAIN",OBJPROP_BGCOLOR,Green);
         ObjectSetString(0,"WatcherMAIN",OBJPROP_TEXT,"WATCHER ON");
         }
     if (flag == false){
         ObjectSetInteger(0,"WatcherMAIN",OBJPROP_BGCOLOR,Red);
         ObjectSetString(0,"WatcherMAIN",OBJPROP_TEXT,"WATCHER OFF");
         }
     }

if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherSTOP" && ObjectGetInteger(0,"WatcherFLAG",OBJPROP_STATE) == true)
     {
    for (int trade = OrdersTotal(); trade >= 0; trade--) {
         if (OrderSelect(trade, SELECT_BY_POS, MODE_TRADES) == true){
         if (OrderSymbol() != Symbol()) continue;
            if (OrderType() == OP_BUY) {
                if (OrderClose(OrderTicket(), OrderLots(), Bid, slippage, CLR_NONE) == true) Alert(OrderSymbol()+" ордер "+OrderLots()+" закрыт "+OrderProfit());
                   else Alert(Symbol()+" Ордер не закрыт!");
            }
            if (OrderType() == OP_SELL) {
                if (OrderClose(OrderTicket(), OrderLots(), Ask, slippage, CLR_NONE) == true) Alert(OrderSymbol()+" ордер "+OrderLots()+" закрыт "+OrderProfit());
                   else Alert(Symbol()+" Ордер не закрыт!");
            }
          }
     }     
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BGCOLOR,Red);
     ObjectSetString(0,"WatcherFLAG",OBJPROP_TEXT,"O");
     ObjectSetInteger(0,"WatcherSTOP",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherBUY",OBJPROP_COLOR,PaleGreen);
     ObjectSetInteger(0,"WatcherSELL",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOP",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_COLOR,Pink);    
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BGCOLOR,0x132013);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BGCOLOR,Maroon);     
     }

     
   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherSTOPh" && ObjectGetInteger(0,"WatcherFLAG",OBJPROP_STATE) == true)
     {
    for (trade = OrdersTotal(); trade >= 0; trade--) {
         if (OrderSelect(trade, SELECT_BY_POS, MODE_TRADES) == true){
         if (OrderSymbol() != Symbol()) continue;
            if (OrderType() == OP_BUY) {
                if (OrderClose(OrderTicket(), NormalizeDouble((OrderLots()/2),2), Bid, slippage, CLR_NONE) == true) Alert(OrderSymbol()+" половина ордера закрыта "+OrderProfit());
                   else Alert(Symbol()+" Ордер не изменён!");
            }
            if (OrderType() == OP_SELL) {
                if (OrderClose(OrderTicket(), NormalizeDouble((OrderLots()/2),2), Ask, slippage, CLR_NONE) == true) Alert(OrderSymbol()+" половина ордера закрыта "+OrderProfit());
                   else Alert(Symbol()+" Ордер не изменён!");
            }
          }
     }    
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BGCOLOR,Red);
     ObjectSetString(0,"WatcherFLAG",OBJPROP_TEXT,"O"); 
     ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherBUY",OBJPROP_COLOR,PaleGreen);
     ObjectSetInteger(0,"WatcherSELL",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOP",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BGCOLOR,0x132013);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BGCOLOR,Maroon);     
     }     

   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherSTOPnl" && ObjectGetInteger(0,"WatcherFLAG",OBJPROP_STATE) == true)
     {
    for (trade = OrdersTotal(); trade >= 0; trade--) {
         if (OrderSelect(trade, SELECT_BY_POS, MODE_TRADES) == true){
         if (OrderSymbol() != Symbol()) continue;
            bool res=OrderModify(OrderTicket(),0,NormalizeDouble(OrderOpenPrice(),Digits),0,0,0);
              if (!res && alert){
                  Alert(Symbol()+" Ошибка модификации ордера ");
                  PlaySound("alert.wav");
                  }
                  else {
                  
                  Alert(Symbol()+" Ордер переведён в безубыток.");
                  PlaySound("alert2.wav");
                  }
          }
     }     
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BGCOLOR,Red);
     ObjectSetString(0,"WatcherFLAG",OBJPROP_TEXT,"O");
     ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherBUY",OBJPROP_COLOR,PaleGreen);
     ObjectSetInteger(0,"WatcherSELL",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOP",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BGCOLOR,0x132013);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BGCOLOR,Maroon);     
     }
     
   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherBUY" && ObjectGetInteger(0,"WatcherFLAG",OBJPROP_STATE) == true)
     {
     buf=StringToDouble(ObjectGetString(0,"WatcherInput",OBJPROP_TEXT));
     ticket=OrderSend(Symbol(),OP_BUY, NormalizeDouble(buf,2),NormalizeDouble(Ask,Digits),slippage,0,0,DoubleToString(buf, 2),MagicNumber,0,CLR_NONE);
     if (ticket == -1) Alert(Symbol()+" Ордер не открыт!");
     
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BGCOLOR,Red);
     ObjectSetString(0,"WatcherFLAG",OBJPROP_TEXT,"O");
     ObjectSetInteger(0,"WatcherBUY",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherBUY",OBJPROP_COLOR,PaleGreen);
     ObjectSetInteger(0,"WatcherSELL",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOP",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BGCOLOR,0x132013);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BGCOLOR,Maroon);     
     }
     
   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherSELL" && ObjectGetInteger(0,"WatcherFLAG",OBJPROP_STATE) == true)
     {
     buf=StringToDouble(ObjectGetString(0,"WatcherInput",OBJPROP_TEXT));
     ticket=OrderSend(Symbol(),OP_SELL, NormalizeDouble(buf,2),NormalizeDouble(Bid,Digits),slippage,0,0,DoubleToString(buf, 2),MagicNumber,0,CLR_NONE);
     if (ticket == -1) Alert(Symbol()+" Ордер не открыт!");
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherFLAG",OBJPROP_BGCOLOR,Red);
     ObjectSetString(0,"WatcherFLAG",OBJPROP_TEXT,"O");
     ObjectSetInteger(0,"WatcherSELL",OBJPROP_STATE,false);
     ObjectSetInteger(0,"WatcherBUY",OBJPROP_COLOR,PaleGreen);
     ObjectSetInteger(0,"WatcherSELL",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOP",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_COLOR,Pink);
     ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_COLOR,Pink);
      ObjectSetInteger(0,"WatcherBUY",OBJPROP_BGCOLOR,0x132013);
      ObjectSetInteger(0,"WatcherSELL",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOP",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPh",OBJPROP_BGCOLOR,Maroon);
      ObjectSetInteger(0,"WatcherSTOPnl",OBJPROP_BGCOLOR,Maroon);     
     }
   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherSELL-")
     {
     buf=StringToDouble(ObjectGetString(0,"WatcherInput",OBJPROP_TEXT));
     buf = buf - 0.01;
     ObjectSetString(0,"WatcherInput",OBJPROP_TEXT, NormalizeDouble(buf,2));
     ObjectSetInteger(0,"WatcherSELL-",OBJPROP_STATE,false);
     }

   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherSELL--")
     {
     buf=StringToDouble(ObjectGetString(0,"WatcherInput",OBJPROP_TEXT));
     buf = buf - 0.1;
     ObjectSetString(0,"WatcherInput",OBJPROP_TEXT, NormalizeDouble(buf,2));
     ObjectSetInteger(0,"WatcherSELL--",OBJPROP_STATE,false);
     }
     
   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherSELL---")
     {
     buf=StringToDouble(ObjectGetString(0,"WatcherInput",OBJPROP_TEXT));
     buf = buf - 1;
     ObjectSetString(0,"WatcherInput",OBJPROP_TEXT, NormalizeDouble(buf,2));
     ObjectSetInteger(0,"WatcherSELL---",OBJPROP_STATE,false);
     }     
     
        if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherBUY+")
     {
     buf=StringToDouble(ObjectGetString(0,"WatcherInput",OBJPROP_TEXT));
     buf = buf + 0.01;
     ObjectSetString(0,"WatcherInput",OBJPROP_TEXT, NormalizeDouble(buf,2));
     ObjectSetInteger(0,"WatcherBUY+",OBJPROP_STATE,false);
     }

   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherBUY++")
     {
     buf=StringToDouble(ObjectGetString(0,"WatcherInput",OBJPROP_TEXT));
     buf = buf + 0.1;
     ObjectSetString(0,"WatcherInput",OBJPROP_TEXT, NormalizeDouble(buf,2));
     ObjectSetInteger(0,"WatcherBUY++",OBJPROP_STATE,false);
     }
     
   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherBUY+++")
     {
     buf=StringToDouble(ObjectGetString(0,"WatcherInput",OBJPROP_TEXT));
     buf = buf + 1;
     ObjectSetString(0,"WatcherInput",OBJPROP_TEXT, NormalizeDouble(buf,2));
     ObjectSetInteger(0,"WatcherBUY+++",OBJPROP_STATE,false);
     }  
   if(id==CHARTEVENT_OBJECT_CLICK && sparam == "WatcherLots")
     {
     ObjectSetString(0,"WatcherInput",OBJPROP_TEXT, NormalizeDouble(AccountFreeMargin()*0.000006,2));
     ObjectSetInteger(0,"WatcherLots",OBJPROP_STATE,false);
     }  
     
     
//ChartRedraw();
}


 



int start(){
   bool flag = ObjectGetInteger(0,"WatcherMAIN",OBJPROP_STATE);
   //if (flag == false) return(0);




TP           = takeprofit;
away         = stoploss;
/*ObjectCreate(0, "Lots",OBJ_LABEL,0,Time[50],Ask);     
      //--------------если-ДЦ-увеличил-своп-программа-не-будет-работать----------------------
      //SymbolSwap = MarketInfo(Symbol(),MODE_SWAPLONG);
      //if (SymbolSwap > swap) return(0);
      //--------------присваиваем-переменным-необходимые-параметры---------------------------
     for (cnt = 0 ; cnt <= OrdersTotal() ; cnt++){
          if (OrderType() == OP_BUY || OrderType() == OP_SELL) numlots += OrderLots();
          }
     TEXT = DoubleToString(numlots,2);
     ObjectSetText("Lots", TEXT, 20, "Comic Sans MS", Gold);
     ObjectSet("Lots", OBJPROP_CORNER, CORNER_RIGHT_UPPER);*/
     
      if (IsTradeContextBusy()) return(0);
      for (cnt = 0 ; cnt <= OrdersTotal() ; cnt++){
          if (OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)){
          if (OrderSymbol() != Symbol()) continue;
          if (OrderStopLoss() == OrderOpenPrice()) continue;
          if (OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP) continue;
          //int ticket = OrderTicket();
          if (NormalizeDouble(StrToDouble(OrderComment()),2) != NormalizeDouble(OrderLots(),2)){
              bool res=OrderModify(OrderTicket(),0,NormalizeDouble(OrderOpenPrice(),Digits),0,0,0);
              if (!res && alert){
                  Alert("Ошибка модификации ордера "+Symbol());
                  PlaySound("alert.wav");
                  }
                  else {
                  
                  Alert("Ордер переведён в безубыток."+Symbol());
                  PlaySound("alert2.wav");
                  }
              continue;
              }
           //Alert("123445");              
          StartControl(OrderTicket());
          }
          }
      //timeprev = Time[0];
return(0);      
}
//===========================================================================================
//--------------ФУНКЦИЯ-КОНТРОЛЯ-ОРДЕРОВ-ДО-ВЫСТАВЛЕНИЯ-БУ-----------------------------------
//===========================================================================================
double StartControl(int ticket){
   
   bool flag = ObjectGetInteger(0,"WatcherMAIN",OBJPROP_STATE);
   //if (flag == false) return(0);
      string namestop, nametp;
          if (Symbol() == "XAUUSD"){
          TP           = takeprofit*10;
          away         = stoploss*10;
      }
      namestop = "CtrStop"+IntegerToString(ticket,9,'_');
      nametp  = "CtrTP"+IntegerToString(ticket,9,'_');
//===========================================================================================
if (OrderType() == OP_SELL){
          if (ObjectFind(0,namestop) == -1){
                     
              ObjectCreate(0,namestop,OBJ_HLINE,0,0, NormalizeDouble(Bid+away*Point,Digits));
              ObjectSet(namestop,OBJPROP_COLOR,Red);
              ObjectSet(namestop,OBJPROP_STYLE,STYLE_DOT);
              ObjectCreate(0,nametp,OBJ_HLINE,0,0, NormalizeDouble((OrderOpenPrice()-TP*Point), Digits));
              ObjectSet(nametp,OBJPROP_COLOR,Aqua);
              ObjectSet(nametp,OBJPROP_STYLE,STYLE_DOT);
          }
          if (ObjectFind(0,namestop) != -1){
           
              stop = ObjectGet(namestop,OBJPROP_PRICE1);
              if ((iOpen(Symbol(),60,0) > stop && iOpen(Symbol(),60,0) < iClose(Symbol(),60,1)) || Ask > (stop + away*Point)) {
                  if (OrderClose(ticket, OrderLots(), Bid, slippage, Red) == true){
                  ObjectDelete(0,namestop);
                  ObjectDelete(0,nametp);
                  Alert("Сработал StopLoss "+Symbol()+" "+OrderProfit());
                  }
                  }
          }
          if (ObjectFind(0,nametp) != -1){
                   
              tp = ObjectGet(nametp,OBJPROP_PRICE1);
              chek = NormalizeDouble(StrToDouble(OrderComment()), 2);
              if (Ask < tp && chek == OrderLots()){
                  LotToClose = NormalizeDouble(OrderLots()*0.5,2);
                  if (OrderClose(ticket, LotToClose, Bid, slippage, Red) == true){
                      ObjectDelete(0,nametp);
                      ObjectDelete(0,namestop);
                      Alert("Ордер частично закрыт "+Symbol()+" "+OrderProfit()*0.5);
                      }
              }
          }
      } 
//===========================================================================================
if (OrderType() == OP_BUY){
          if (ObjectFind(0,namestop) == -1){
              ObjectCreate(0,namestop,OBJ_HLINE,0,0, NormalizeDouble(Ask-away*Point, Digits));
              ObjectSet(namestop,OBJPROP_COLOR,Red);
              ObjectSet(namestop,OBJPROP_STYLE,STYLE_DOT);
              ObjectCreate(0,nametp,OBJ_HLINE,0,0, NormalizeDouble((OrderOpenPrice()+TP*Point), Digits));
              ObjectSet(nametp,OBJPROP_COLOR,Aqua);
              ObjectSet(nametp,OBJPROP_STYLE,STYLE_DOT);
          }
          if (ObjectFind(0,namestop) != -1){
              stop = ObjectGet(namestop,OBJPROP_PRICE1);
              if ((iOpen(Symbol(),60,0) < stop && iOpen(Symbol(),60,0) > iClose(Symbol(),60,1))|| Bid < (stop - away*Point)) {
                  if (OrderClose(ticket, OrderLots(), Bid, slippage, Red) == true){
                  ObjectDelete(0,namestop);
                  ObjectDelete(0,nametp);
                  Alert("Сработал StopLoss "+Symbol()+" "+OrderProfit());
                  }
              }
          }
          if (ObjectFind(0,nametp) != -1){
              tp = ObjectGet(nametp,OBJPROP_PRICE1);
              chek = NormalizeDouble(StrToDouble(OrderComment()), 2);
              if (Bid > tp && chek == OrderLots()){
                  LotToClose = NormalizeDouble(OrderLots()*0.5,2);
                  if (OrderClose(ticket, LotToClose, Bid, slippage, Red) == true){
                      ObjectDelete(0,nametp);
                      ObjectDelete(0,namestop);
                      Alert("Ордер частично закрыт "+Symbol()+" "+OrderProfit()*0.5);
                      }
              }
          }
      } 
return(0);
}
//----------------------------------------------------------------------------------------
bool Rectangle(color C){
      
      ObjectCreate(0,"WatcherBACK",OBJ_RECTANGLE_LABEL ,1,0,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_XSIZE,358);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_YSIZE,150);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_CORNER,CORNER_LEFT_LOWER);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_BACK,true);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_SELECTED,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_HIDDEN,1);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_ZORDER,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_BORDER_COLOR,Gray);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_BGCOLOR,C);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_COLOR,Gray);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_BORDER_TYPE,BORDER_RAISED);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_XDISTANCE,0);
      ObjectSetInteger(0,"WatcherBACK",OBJPROP_YDISTANCE,118);
Sleep(1000);
if (ObjectFind("WatcherBACK") == true) return(true); else return(false);
}
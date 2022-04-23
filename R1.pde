import controlP5.*;

ControlP5 cp5;
Slider H;
Slider S;
Slider V;

int MaxColor;

int time;
int type;
int size;
int dist;

float Hue;
float Saturation=500;
float Value=1000;

float X, Y;
float Cx, Cy;
float Angle;

int a=0;
int b=0;
int c=3;
float scale;
int flag = 0;
int A=280;

Triangle t;

void setup() {
  size(1250, 600);
  MaxColor = width;
  colorMode(HSB, MaxColor); // HSB表色系(レンジはウィンドウ幅)
  
  background(MaxColor-1);   // 背景を白にする
  frameRate(15);            // フレームレートは15fps
  translate(0,0);
  cp5 = new ControlP5(this);
  H = cp5.addSlider("Hue",0,1000,Hue,820,50,200,20);
  cp5 = new ControlP5(this);
  S = cp5.addSlider("Saturation",0,600,Saturation,820,80,200,20);
  cp5 = new ControlP5(this);
  V = cp5.addSlider("Value",0,1000,Value,820,110,200,20);
  String[] button = {"Default", "Transparent","Stroke"}; //描画パターンのボタン作成
  for(int i = 0;i<=2;i++)
  {
      cp5.addButton(button[i])
        .setLabel(button[i])
        .setPosition(820,230 + i*100)
        .setSize(120,60);
  }
  
  String[] colorbutton = {"Slider", "Time","Area"};//カラー設定用のボタン作成
  for(int i = 0;i<=2;i++)
  {
      cp5.addButton(colorbutton[i])
        .setLabel(colorbutton[i])
        .setPosition(950,230 + i*100)
        .setSize(120,60);
  }
  
  String[] backbutton = {"White", "BaseColor","Black"}; //背景設定用のボタン作成
  for(int i = 0;i<=2;i++)
  {
      cp5.addButton(backbutton[i])
        .setLabel(backbutton[i])
        .setPosition(1080,230 + i*100)
        .setSize(120,60);
  }

  Angle = 0;
  dist=0;
}

void draw(){
    float speed = dist(mouseX, mouseY, pmouseX, pmouseY); //スピードを計測
    backgroundcontrol();
    pushMatrix();
    fill(800);
    noStroke();
    rect(800,0,width,600);//ボタンやスライダなどの設定用のエリアを作成
    popMatrix();
    control();
    rect(850,150,50,50);
    if(mouseX <=800){
        if(mousePressed == true){
            c=3;
            if(size<=300){
                size = (millis() - time)/20; //sizeが300以下の場合、時間に応じて拡大
            }
            if(type==0){
                ellipse(mouseX,mouseY,size,size);//eと入力したらマウスを中心に円が描画される
            } else if(type == 1){
                strokeWeight(speed/4);//スピードに応じて線の太さが変わる
                linecontrol();
                line(400,300,mouseX,mouseY);
            } else if(type==2){
                  pushMatrix();
                  translate(mouseX, mouseY);
                  rotate(millis() - time);
                  rect(0,0,size/3,size/3);
                  popMatrix();
            } else if(type==3){
                circle();
            } else if(type==4){
                t = new Triangle(mouseX, mouseY, size);
                t.draw(millis() - time);
            } else if(type==5){
               Sin();
            } else if(type==6){
                Cos();
            } else if(type==7){
                Sin();
                Cos();
            } else if(type==8){
                noFill();
                linecontrol();
                ellipse(mouseX,mouseY,(millis() - time)/10*9%1000-speed/10,(millis() - time)/10*9%1000-speed/10);
            }
            
        } else {
            time = millis();
            size = 0;
            scale = 0;
        }
    }
}

void fadeToWhite() {  // 描画後の時間経過に応じて薄くする
  noStroke();
  fill(MaxColor-1, MaxColor*0.05);  // 透過率95%の白色でウィンドウ全体を描画
  rectMode(CORNER);
  rect(0, 0, 800, height);
}

void keyPressed() {
    if (key == 'e') {
        type=0;
    } else if(key == 'l'){
        type =1;
    } else if(key =='r'){
        type = 2;
    } else if(key == 'o'){
        type = 3;
    } else if(key == 't'){
        type = 4;
    } else if(key == 's'){
        type = 5;
    } else if(key == 'c'){
        type = 6;
    } else if(key == 'w'){
        type = 7;
    } else if(key=='h'){
        type = 8;
    } else if(key == 'S'){
      //画像を作成
        PImage img = createImage(width, height, RGB);
     
        //画面を画像にコピー
        loadPixels();
        img.pixels = pixels;
        img.updatePixels();
         
        //画像のピクセル情報を切り出して保存
        img = img.get(0, 0, width-450, height);
        img.save("drawing.png");
     
    } 
    time = millis();
}

void circle() {
  float speed = dist(mouseX, mouseY, pmouseX, pmouseY);
  Angle += 10;
  dist=5;
  if(scale<250){scale+=dist-speed/100;Angle+=20;}
  X = 400;
  Y = height/2;
  
  pushMatrix();
  translate(X, Y);
  ellipse(((scale) * cos(radians(Angle))), ((scale) * sin(radians(Angle))),size/3-speed/10, size/3-speed/10);
  popMatrix();
}

void Default(){a=0;}

void Transparent(){a=1;}

void Stroke(){a=2;}

void Slider(){b=0;}

void Time(){ b=1;}

void Area(){b=2;}

void White(){c=0;}

void BaseColor(){ c=1;}

void Black(){c=2;}

void control(){
    if(a==1){fadeToWhite();}
    else if(a==2){stroke(0,0,0);strokeWeight(3);}
    else if(a==0){noStroke();}
    if(b==0){fill(Hue, Saturation, Value);}
    else if(b==1){fill((millis()/5)%1000, Saturation, Value);}
    else if(b==2){fill(mouseX*1.25 , mouseY*5/3, Value);}
}

void linecontrol(){
    if(b==0){stroke(Hue, Saturation, Value);}
    else if(b==1){stroke((millis()/5)%1000, Saturation, Value);}
    else if(b==2){stroke(mouseX*1.25 , mouseY*5/3, Value);}
}

void backgroundcontrol(){
    if(c==0){background(MaxColor-1);}
    if(c==1){background(Hue, Saturation, Value);}
    if(c==2){background(0);}
}

void Sin(){
    float speed = dist(mouseX, mouseY, pmouseX, pmouseY);
    float x = (millis() - time)/8;
    if(sin(x * 0.01)<0){speed = -speed;}
    float y = height / 2 - sin(x * 0.01)*A + speed/10;
    ellipse(x%800, y, 15, 15);
}

void Cos(){
    float speed = dist(mouseX, mouseY, pmouseX, pmouseY);
    float x = (millis() - time)/8;
    if(cos(x * 0.01)<0){speed = -speed;}
    float y = height / 2 - cos(x * 0.01)*A + speed/10;
    ellipse(x%800, y, 15, 15);
}
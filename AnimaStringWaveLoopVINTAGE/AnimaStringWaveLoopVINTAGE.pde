/**
* AnimaStringWaveLoopVINTAGE: A cillexia project by Christian Bietsch
* Website: www.cillexia.net
*/

// ========== RECORD SETTINGS ==========
static final int TOTAL_FRAMES = 800;                        // Total frames to record
static boolean RECORD = false;                              // record
static final String NAME = "AnimaStringWaveLoopVINTAGE";    // name
static final String FORMAT = "png";                         // formate

int counter = 0;                                            // counts frames

// ========== INFO ==========
String INFO_WEBSITE = "cillexia.net";
String INFO_NAME = "Vintage String Wave";
String INFO_AUTHOR = "Christian Bietsch";
int INFO_SIZE = 42;
color INFO_COLOR = color(74*0.75, 44*0.75, 24*0.75);
String LOGO = "cillexia_logo_backgroundTRANSPARENT_128x128.png";
PImage logo;

// ========== String Wave ==========
float total = 200.0;
float factor = -1.0;
boolean drawDots = true;
int r = 600;
PImage image;
color BRAUN = color(74, 44, 24);

void setup() {
  size(1280, 1400);
  
  // LOGO
  logo = loadImage(LOGO);
  
  // Background Image
  image = loadImage("vintage_paper_1280×1920.png");
  image.resize(width, height);
}

//** File name: folder/name.format */
final String fileName() { return NAME+"/"+NAME+nf(counter,4)+"."+FORMAT; }

void INFO() {
  // NAME
  fill(INFO_COLOR);
  textSize(INFO_SIZE);
  textAlign(CENTER, CENTER);
  text(INFO_NAME, 0, -height*0.47);
  
  // AUTHOR
  fill(INFO_COLOR);
  textSize(INFO_SIZE*0.7);
  textAlign(LEFT, CENTER);
  text("Animation by "+INFO_AUTHOR, -width*0.4625, height*0.47);
  
  // cillexia
  fill(INFO_COLOR);
  textSize(INFO_SIZE);
  textAlign(CENTER, CENTER);
  text(INFO_WEBSITE, 0, height*0.465);
  
  // LOGO
  tint(INFO_COLOR);
  image(logo, width*0.5-logo.width, height*0.5-logo.height);
}

void draw() {
  final float progress = RECORD ? float(counter) / TOTAL_FRAMES : float(counter % TOTAL_FRAMES) / TOTAL_FRAMES;
  draw(progress);
  if (RECORD && counter == 0) { println("Start to record: "+ NAME); }
  if (RECORD) { saveFrame(fileName()); }
  counter++;
  if (RECORD) { println("Save: "+ counter +"/"+TOTAL_FRAMES); }
  if (RECORD && counter == TOTAL_FRAMES) { println("DONE"); exit(); }
}

/** Draws each anima frame with progress [0.0...1.0] */
void draw(float progress) {
  boolean reverse = progress < 0.5;
  factor = reverse ? (0.5-progress)*2.0 : (progress-0.5)*2.0;
  
  translate(width*0.5, height*0.5);
  background(image);
  
  // draw ring
  stroke(BRAUN);
  noFill();
  circle(0, 0, r*2);
  
  // draw dots on ring
  if (drawDots) {
    for (int i = 0; i < total; i++) {
      PVector v = getVector(i);
      fill(BRAUN);
      circle(v.x, v.y, r*0.025);
    }
  }
  
  // draw lines
  for (int i = 0; i < total; i++) {
    PVector a = getVector(i);
    PVector b = getVector(i * factor);
    if (reverse) {
      a.y = -a.y;
      b.y = -b.y;
    }
    line(a.x, a.y, b.x, b.y);
  }
  
  // INFO
  INFO();
}

PVector getVector(float index) {
  float angle = map(index % total, 0, total, 0, TWO_PI);
  PVector v = PVector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}

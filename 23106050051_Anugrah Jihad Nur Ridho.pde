// Variabel untuk rotasi
float pitch = 0;
float yaw = 0;
float roll = 0;
// Variabel untuk translasi
float crab = 0;
float ped = 0;
float zoom = -200;
// Variabel untuk cahaya
float lightX = 0;
float lightY = -1;
float lightZ = -1;
boolean raytrace = true;
boolean textureOn = true;
PFont font;

void setup() {
  size(800, 600, P3D);
  font = createFont("Arial", 60, true);
}

void draw() {
  background(20);

  // Setup lighting
  if (raytrace) {
    ambientLight(50, 50, 50);
    directionalLight(200, 200, 200, lightX, lightY, lightZ);
    specular(255, 255, 255);
    shininess(5.0);
  } else {
    ambientLight(100, 100, 100);
  }

  // Apply transformations
  pushMatrix();
  translate(width/2 + crab, height/2 + ped, zoom);
  rotateX(pitch);
  rotateY(yaw);
  rotateZ(roll);

  // Draw 3D AJNR text
  draw3DAJNR();

  popMatrix();

  // Display controls
  displayControls();
}

void draw3DAJNR() {
  // Set material properties
  if (textureOn) {
    fill(100, 150, 255);
  } else {
    fill(200);
  }
  
  stroke(50);
  strokeWeight(1);

  // Draw each letter with geometric shapes
  pushMatrix();
  translate(-120, 0, 0); // Posisi huruf A
  drawGeometric3DA();
  popMatrix();

  pushMatrix();
  translate(-40, 0, 0); // Posisi huruf J
  drawGeometric3DJ();
  popMatrix();

  pushMatrix();
  translate(40, 0, 0);  // Posisi huruf N
  drawGeometric3DN();
  popMatrix();

  pushMatrix();
  translate(120, 0, 0); // Posisi huruf R
  drawGeometric3DR();
  popMatrix();
}

// Huruf A dibuat dari 3 box: 2 diagonal dan 1 horizontal
void drawGeometric3DA() {
  if (textureOn) {
    fill(100, 150, 255);
  } else {
    fill(200);
  }
  
  // Left diagonal stroke (rotated box)
  pushMatrix();
  translate(-10, -5, 0);
  rotateZ(radians(15)); // Rotasi untuk membuat diagonal
  box(8, 50, 15);
  popMatrix();
  
  // Right diagonal stroke (rotated box)
  pushMatrix();
  translate(10, -5, 0);
  rotateZ(radians(-15)); // Rotasi berlawanan
  box(8, 50, 15);
  popMatrix();
  
  // Horizontal crossbar
  pushMatrix();
  translate(0, 5, 0);
  box(25, 6, 15);
  popMatrix();
}

// Huruf J dibuat dari cylinder untuk lengkungan dan box untuk batang
void drawGeometric3DJ() {
  if (textureOn) {
    fill(80, 120, 200);
  } else {
    fill(180);
  }
  
  // Vertical stroke (main body)
  pushMatrix();
  translate(5, -10, 0);
  box(8, 35, 15);
  popMatrix();
  
  // Top horizontal bar
  pushMatrix();
  translate(-5, -27, 0);
  box(25, 6, 15);
  popMatrix();
  
  // Bottom curve (menggunakan beberapa box kecil untuk simulasi lengkungan)
  pushMatrix();
  translate(-5, 15, 0);
  box(15, 8, 15);
  popMatrix();
  
  pushMatrix();
  translate(-15, 20, 0);
  box(8, 8, 15);
  popMatrix();
  
  pushMatrix();
  translate(-20, 10, 0);
  box(8, 15, 15);
  popMatrix();
}

// Huruf N dibuat dari 3 box: 2 vertikal dan 1 diagonal
void drawGeometric3DN() {
  if (textureOn) {
    fill(120, 170, 230);
  } else {
    fill(220);
  }
  
  // Left vertical stroke
  pushMatrix();
  translate(-15, 0, 0);
  box(8, 50, 15);
  popMatrix();
  
  // Right vertical stroke
  pushMatrix();
  translate(15, 0, 0);
  box(8, 50, 15);
  popMatrix();
  
  // Diagonal stroke (rotated box)
  pushMatrix();
  translate(0, 0, 0);
  rotateZ(radians(-33)); // Rotasi untuk membuat diagonal dari kiri atas ke kanan bawah
  box(8, 56, 15);
  popMatrix();
}

// Huruf R dibuat dari beberapa box untuk membentuk bentuk R
void drawGeometric3DR() {
  if (textureOn) {
    fill(150, 100, 255);
  } else {
    fill(160);
  }
  
  // Left vertical backbone
  pushMatrix();
  translate(-15, 0, 0);
  box(8, 50, 15);
  popMatrix();
  
  // Top horizontal stroke
  pushMatrix();
  translate(-5, -22, 0);
  box(20, 6, 15);
  popMatrix();
  
  // Right vertical stroke (upper part for the loop)
  pushMatrix();
  translate(10, -10, 0);
  box(8, 24, 15);
  popMatrix();
  
  // Middle horizontal stroke (bottom of the loop)
  pushMatrix();
  translate(-5, 2, 0);
  box(20, 6, 15);
  popMatrix();
  
  // Diagonal leg (rotated box)
  pushMatrix();
  translate(0, 15, 0);
  rotateZ(radians(-30)); // Rotasi untuk membuat kaki diagonal
  box(8, 25, 15);
  popMatrix();
  
  // Additional small box to complete the R shape
  pushMatrix();
  translate(5, -22, 0);
  box(6, 6, 15);
  popMatrix();
}

void displayControls() {
  // Menggunakan push/pop matrix untuk memastikan teks kontrol tidak terpengaruh transformasi 3D
  pushMatrix();
  camera(); // Reset kamera ke default untuk teks 2D
  noLights(); // Matikan lampu untuk teks 2D agar warna solid
  
  fill(255); // Warna teks putih
  textAlign(LEFT);
  textSize(12);

  int yPos = 20;
  int yStep = 15;

  text("Controls:", 10, yPos); yPos += yStep;
  text("W/S: Pitch (" + nf(degrees(pitch),0,1) + " deg)", 10, yPos); yPos += yStep;
  text("A/D: Yaw (" + nf(degrees(yaw),0,1) + " deg)", 10, yPos); yPos += yStep;
  text("Q/E: Roll (" + nf(degrees(roll),0,1) + " deg)", 10, yPos); yPos += yStep;
  text("Arrow Keys: Move (Crab: " + crab + ", Ped: " + ped + ")", 10, yPos); yPos += yStep;
  text("+/-: Zoom (" + zoom + ")", 10, yPos); yPos += yStep;
  yPos += yStep; // Spasi
  text("T: Toggle Texture (" + (textureOn ? "ON" : "OFF") + ")", 10, yPos); yPos += yStep;
  text("R: Toggle Raytrace/Light (" + (raytrace ? "ON" : "OFF") + ")", 10, yPos); yPos += yStep;
  yPos += yStep; // Spasi
  text("Light Controls:", 10, yPos); yPos += yStep;
  text("I/K: Light Y (" + nf(lightY, 1, 1) + ")", 10, yPos); yPos += yStep;
  text("J/L: Light X (" + nf(lightX, 1, 1) + ")", 10, yPos); yPos += yStep;
  text("U/O: Light Z (" + nf(lightZ, 1, 1) + ")", 10, yPos); yPos += yStep;

  popMatrix();
}

void keyPressed() {
  float rotSpeed = 0.1; // Kecepatan rotasi
  float moveSpeed = 10; // Kecepatan translasi
  float zoomSpeed = 20; // Kecepatan zoom
  float lightMoveSpeed = 0.1; // Kecepatan pergerakan cahaya

  // Rotation controls
  if (key == 'w' || key == 'W') {
    pitch -= rotSpeed;
  }
  if (key == 's' || key == 'S') {
    pitch += rotSpeed;
  }
  if (key == 'a' || key == 'A') {
    yaw -= rotSpeed;
  }
  if (key == 'd' || key == 'D') {
    yaw += rotSpeed;
  }
  if (key == 'q' || key == 'Q') {
    roll -= rotSpeed;
  }
  if (key == 'e' || key == 'E') {
    roll += rotSpeed;
  }

  // Translation controls
  if (key == CODED) {
    if (keyCode == LEFT) {
      crab -= moveSpeed;
    }
    if (keyCode == RIGHT) {
      crab += moveSpeed;
    }
    if (keyCode == UP) {
      ped -= moveSpeed;
    }
    if (keyCode == DOWN) {
      ped += moveSpeed;
    }
  }

  // Zoom controls
  if (key == '+' || key == '=') {
    zoom += zoomSpeed;
  }
  if (key == '-' || key == '_') {
    zoom -= zoomSpeed;
  }

  // Toggle texture
  if (key == 't' || key == 'T') {
    textureOn = !textureOn;
  }

  // Toggle raytrace/lighting
  if (key == 'r' || key == 'R') {
    raytrace = !raytrace;
  }

  // Light controls
  if (key == 'i' || key == 'I') {
    lightY -= lightMoveSpeed;
  }
  if (key == 'k' || key == 'K') {
    lightY += lightMoveSpeed;
  }
  if (key == 'j' || key == 'J') {
    lightX -= lightMoveSpeed;
  }
  if (key == 'l' || key == 'L') {
    lightX += lightMoveSpeed;
  }
  if (key == 'u' || key == 'U') {
    lightZ -= lightMoveSpeed;
  }
  if (key == 'o' || key == 'O') {
    lightZ += lightMoveSpeed;
  }
}

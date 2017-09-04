int lim;

int is_brot(double c_re, double c_im, double gz_re, double gz_im) {
  double z_re = gz_re;
  double z_im = gz_im;
  
  for (int i = 0; i < lim; i++) {
    if (z_re * z_re + z_im * z_im > 4) {
      return i;
    } else {
      double z_n = z_re * z_re - z_im * z_im + c_re;
      z_im = z_im * z_re * 2 + c_im;
      z_re = z_n;
    }
  }
  
  return lim;
}

double get_x(int x) {
  return (1.0 * x) / (height / 4) - 2;
}

double get_y(int y) {
  return (1.0 * y) / (height / 4) - 2;
}


color get_colour(int val, float mag) {
  int r = (int)((sin(((1.0 * val) / lim) * mag * 2 * PI + 0 * 2 * PI / 3) + 1) * 255 / 2);
  int g = (int)((sin(((1.0 * val) / lim) * mag * 2 * PI + 1 * 2 * PI / 3) + 1) * 255 / 2);
  int b = (int)((sin(((1.0 * val) / lim) * mag * 2 * PI + 2 * 2 * PI / 3) + 1) * 255 / 2);
  
  return color(r, g, b);
}

void draw_brot() {
  loadPixels();
  
  int i = 0;
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (x < width / 2) {
        int conv_time = is_brot(get_x(x), get_y(y), 0, 0);
      
        color c;
      
        if (conv_time == lim) {
          c = color(255);
        } else {
          c = get_colour(conv_time, 5);
        }
      
        pixels[i] = c;
      }
      
      i++;
    }
  }
  
  updatePixels();
}

void draw_julia(double gz_re, double gz_im) {
  loadPixels();
  
  int i = 0;
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (x > width / 2) {
        int conv_time = is_brot(gz_re, gz_im, get_x(x - width / 2), get_y(y));
      
        color c;
      
        if (conv_time == lim) {
          c = color(255);
        } else {
          c = get_colour(conv_time, 5);
        }
      
        pixels[i] = c;
      }
      
      i++;
    }
  }
  
  updatePixels();
}

void setup() {
  size(1400, 700);
  
  lim = 100;
  
  draw_brot();

}

void draw() {
  draw_julia(get_x(mouseX), get_y(mouseY));
}

void keyPressed() {
  switch (keyCode) {
    case 'R':
      setup();
      break;

    case 'H':
      lim = 1000;
      break;      
    case 'I':
      lim += 100;
      break;
    case 'U':
      lim -= 100;
      break;
    case 'T':
      lim = 100;
      break;
    default:
      break;
  }
}

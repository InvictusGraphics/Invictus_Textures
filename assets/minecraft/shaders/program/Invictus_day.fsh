#version 130

uniform sampler2D DiffuseSampler;
varying vec2 texCoord;

//Gimp curves in GLSL using optimized polynomials. WolframAlpha "(formula); where 0<x<1"

float value(float x) {
  return -0.431563 * (-3.31715+x) * x;
}

float red(float x){
  return value(x * (1.28208+x * (-1.20581+0.923728*x)));
               //x * (1.28208+x * (-1.20581+0.923728*x))
}

float green(float x){
  return value((0.904053+0.095947*x) * x);
}

float blue(float x){
  return value(-1.71421 * (-1.52461+x) * x * (0.111982+x));
}

void main() {
  vec4 color = texture2D(DiffuseSampler, texCoord);

  color.r = red(color.r);
  color.g = green(color.g);
  color.b = blue(color.b);

  gl_FragColor = color;
}

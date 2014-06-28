#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D PrevSampler;
varying vec2 texCoord;

vec4 threshold(vec4 x){
  //weight of average leans toward night and does not affect day.   //y = .5(1 + tanh(10x-1.5))
  return (0.5 * (1.0 + tanh(7.0 * x - 3.0)));
}

float distribute(float x){
  //sin(25x/pi) * 0.02
  return sin((25*x) / 3.14159) * 0.02;
}

void main() {
  
  vec4 total = vec4(0.0);

  for (float x = -0.02; x < 0.02; x += .005) {
    for (float y = -0.02; y < 0.02; y += .005){
      total += threshold((texture2D(DiffuseSampler, vec2( texCoord.x + distribute(x), texCoord.y + distribute(y)))));
    }
  }

  total /= 64;
  
  gl_FragColor = total;
}
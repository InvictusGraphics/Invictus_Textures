#version 120

uniform sampler2D DiffuseSampler;
uniform sampler2D PrevSampler;
varying vec2 texCoord;

float distribute(float x){
  //sin(25x/pi) * 0.02
  return sin((25*x) / 3.14159) * 0.02;
}

void main() {
  
  vec4 total = vec4(0.0);

  for (float x = -0.02; x < 0.02; x += .005) {
    for (float y = -0.02; y < 0.02; y += .005){
      total += (texture2D(DiffuseSampler, vec2( texCoord.x + distribute(x), texCoord.y + distribute(y))));
    }
  }

  total /= 64;
  
  gl_FragColor = total;
}
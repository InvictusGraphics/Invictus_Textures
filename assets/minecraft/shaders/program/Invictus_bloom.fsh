#version 120

uniform sampler2D DiffuseSampler;
uniform sampler2D PrevSampler;
varying vec2 texCoord;

uniform float range;

varying vec2 blurCoords[64];


void main() {
  
  vec4 total = vec4(0);
  for(int index = 0; index <= 64; index++){
   total += (texture2D(DiffuseSampler, vec2(blurCoords[index])));
  }
  total /= 64;
  
  gl_FragColor = total*range;
}
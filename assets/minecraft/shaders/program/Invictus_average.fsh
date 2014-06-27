#version 120

uniform sampler2D DiffuseSampler;
uniform sampler2D PrevSampler;
varying vec2 texCoord;


varying vec2 sampleCoords[64];


void main() {
  
  vec4 samples_prev = vec4(0.0); 
  vec4 samples_current = vec4(0.0); 
  for(int index = 0; index <= 64; index++){
    samples_prev += texture2D(PrevSampler, vec2(sampleCoords[index]));
    samples_current += texture2D(DiffuseSampler, vec2(sampleCoords[index]));
  }

  samples_prev /= 64.0;
  samples_current /= 64.0;
  gl_FragColor = samples_prev * 0.98 + samples_current * 0.02;
}
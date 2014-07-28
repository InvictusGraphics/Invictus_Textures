#version 120

uniform sampler2D DiffuseSampler;
uniform sampler2D AverageSampler;
varying vec2 texCoord;

float threshold = 0.5;

float binary_threshold(float value){
  return (value > threshold ? 1.0 : 0.0);
}


float desaturate(vec4 saturated){
  return ((saturated.r + saturated.g + saturated.b) / 3.0);
}

void main() {
  vec4 color = texture2D(DiffuseSampler, texCoord);

  //desaturate(color);
  gl_FragColor = vec4(binary_threshold(desaturate(color)));
}

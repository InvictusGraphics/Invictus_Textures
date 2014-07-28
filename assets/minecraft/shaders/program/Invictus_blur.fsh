#version 130

uniform sampler2D DiffuseSampler;

varying vec2 texCoord;

vec4 base[9] = vec4[9](
  texture2D(DiffuseSampler, vec2(texCoord.x + -0.005, texCoord.y + -0.005)),
  texture2D(DiffuseSampler, vec2(texCoord.x + -0.005, texCoord.y + 0.0)),
  texture2D(DiffuseSampler, vec2(texCoord.x + -0.005, texCoord.y + 0.005)),
  texture2D(DiffuseSampler, vec2(texCoord.x + 0.0, texCoord.y + -0.005)),
  texture2D(DiffuseSampler, vec2(texCoord.x + 0.0, texCoord.y + 0.0)),
  texture2D(DiffuseSampler, vec2(texCoord.x + 0.0, texCoord.y + 0.005)),
  texture2D(DiffuseSampler, vec2(texCoord.x + 0.005, texCoord.y + -0.005)),
  texture2D(DiffuseSampler, vec2(texCoord.x + 0.005, texCoord.y + 0.0)),
  texture2D(DiffuseSampler, vec2(texCoord.x + 0.005, texCoord.y + 0.005)));


    //Kernel ~ hardcoded blur
float kernel[9] = float[9]( .0625, .125, .0625, .125, .25, .125, .0625, .125, .0625 );

/*
vec4 opacity_threshold(vec4 x){
  //weight of average leans toward night and does not affect day.   //y = .5(1 + tanh(10x-1.5))
  return (0.5 * (1.0 + tanh(7.0 * x - 3.0)));
}
*/

void main() {
  vec4 color = vec4(0.0);
  for (int i = 0; i <= 8; i++) {
    color = base[i] * kernel[i] + color;
  }
  gl_FragColor = color;
}

#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D BlurSampler;
uniform sampler2D AverageSampler;
uniform sampler2D FogSampler;

varying vec2 texCoord;


float threshold(float x){
  //weight of average leans toward night and does not affect day.   //y = .5(1 + tanh(10x-1.5))
  return (0.5 * (1.0 + tanh(5.0 * x - 0.5)));
}


float desaturate(vec4 saturated){
  return ((saturated.r + saturated.g + saturated.b) / 3.0);
}


void main() {

  vec4 color_day = texture2D(DiffuseSampler, texCoord);                   //store day value
  float color_blur = desaturate(texture2D(BlurSampler, texCoord));                 //store bloom value
  vec4 color_fog = texture2D(FogSampler, texCoord);                       //store fog value
  float color_average = desaturate(texture2D(AverageSampler, texCoord));  //store average scene value

  float frag_lightness = desaturate(color_day);                //store lightness of current fragment

  vec4 color_night = vec4(frag_lightness);                                //store night value
  /* ~~~~~~~ */
  vec4 color = mix(color_night, color_day, threshold(mix(color_average, 1.0, frag_lightness)));
  color = mix(color + vec4(color_blur * 1.3, color_blur * 1.2, color_blur * 1.15, color_day.w), color, mix(threshold(color_average), 1.0, frag_lightness));

  gl_FragColor = color;
}
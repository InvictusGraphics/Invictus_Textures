#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D BloomSampler;
uniform sampler2D AverageSampler;

varying vec2 texCoord;


float threshold(float x){
  //weight of average leans toward night and does not affect day.   //y = .5(1 + tanh(10x-1.5))
  return (0.5 * (1.0 + tanh(10.0 * x - 1.5)));
}


float desaturate(vec4 saturated){
  return ((saturated.r + saturated.g + saturated.b) / 3.0);
}


void main() {

  vec4 color_day = texture2D(DiffuseSampler, texCoord);                   //store day value
  vec4 color_bloom = texture2D(DiffuseSampler, texCoord);                 //store bloom value
  float color_average = desaturate(texture2D(DiffuseSampler, texCoord));  //store average scene value

  float frag_lightness = threshold(desaturate(color_day));                //store lightness of current fragment

  vec4 color_night = vec4(frag_lightness);                                //store night value


  /* ~~~~~~~ */
  color_day = mix(color_bloom + color_day, color_day, threshold(color_average));   //blend bloom into daylight based on average lightness of scene

  float opacity = mix(color_average, 1.0, frag_lightness);              //calculate opacity of daylight fragment via the average of scene and fragment lightness

  gl_FragColor = mix(color_night, color_day, opacity);                  //return frag color with the blend of night and day
}
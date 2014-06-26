#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D PrevSampler;
varying vec2 texCoord;

float frame_lightness(){
  vec4 samples = vec4(0.0, 0.0, 0.0, 0.0); 
  for (float x = 0.0; x<= 1.0; x += 0.1){
    for (float y = 0.0; y<= 1.0; y += 0.1){
      samples += texture2D(DiffuseSampler, vec2(x, y));
    }
  }
  return (((samples.r + samples.g + samples.b) / 3.0) / 100.0); //averages the 100 samples
}

float previous_frame_lightness(){
  vec4 samples = vec4(0.0, 0.0, 0.0, 0.0); 
  for (float x = 0.0; x<= 1.0; x += 0.1){
    for (float y = 0.0; y<= 1.0; y += 0.1){
      samples += texture2D(PrevSampler, vec2(x, y));
    }
  }
  return (((samples.r + samples.g + samples.b) / 3.0) / 100.0); //averages the 100 samples

}

float desaturate(vec4 saturated){
  return (saturated.r + saturated.g + saturated.b) / 3.0;
}

float threshold(float x){
  //weight of average leans toward night and does not affect day.   //y = .5(1 + tanh(6x-1.5))
  return (0.5 * (1.0 + tanh(6.0 * x - 1.5)));
}

vec4 bloom(){
  float range = 0.008;
  
  vec4 total = vec4(0);
  int samples = 0;
  for(float x = texCoord.x - range; x < texCoord.x + range; x += 0.0005)
  {
    for(float y = texCoord.y - range; y < texCoord.y + range; y += 0.0005)
    {
      total += (texture2D(DiffuseSampler, vec2(x, y)));
      samples++;
    }
  }
  total = total / samples;
  total.r = total.r * 1.3;
  total.b = total.b * 1.05;
  // Set the current fragment to the original texture pixel, with our bloom value added on
  return total;
  }

void main() {

  vec4 color_day = texture2D(DiffuseSampler, texCoord);     //store day value

  float frag_lightness = threshold(desaturate(color_day));  //store lightness of standard value
  float frame_lightness = frame_lightness();
  //float frame_lightness = (frame_lightness() + (previous_frame_lightness() * 49.0) / 50.0);                        //store average lightness of scene

  vec4 color_night;                                         //store night value
    color_night.r = mix(frag_lightness * 0.4, color_day.r * 0.9, 0.5);
    color_night.g = mix(frag_lightness * 0.4, color_day.g * 0.5, 0.5);
    color_night.b = mix(frag_lightness * 0.4, color_day.b, 0.5);


  /* ~~~~~~~ */
  color_day = mix(bloom()*1.5 + color_day, color_day, threshold(frame_lightness));   //blend bloom into daylight based on average lightness of scene

  float opacity = threshold(mix(frame_lightness, 1.0, frag_lightness));          //calculate opacity of daylight fragment via the average of scene and fragment lightness

  gl_FragColor = mix(color_night, color_day, opacity);                   //return frag color with the blend of night and day
}
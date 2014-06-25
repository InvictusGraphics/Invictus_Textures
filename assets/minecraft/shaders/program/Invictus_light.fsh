#version 130

uniform sampler2D DiffuseSampler;
varying vec2 texCoord;

float average(){
  vec4 samples = vec4(0.0, 0.0, 0.0, 0.0); 
  for (float x = 0.0; x<= 1.0; x += 0.1){
    for (float y = 0.0; y<= 1.0; y += 0.1){
      samples += texture2D(DiffuseSampler, vec2(x, y));
    }
  }
  return (((samples.r + samples.g + samples.b) / 3.0) / 100.0); //averages the 100 samples
}

float threshold(float x){
  //weight of average leans toward night and does not affect day.   //y = .5(1 + tanh(6x-1.5))
  return (0.5 * (1.0 + tanh(6.0 * x - 1.5)));
}

float desaturate(vec4 saturated){
  return (saturated.r + saturated.g + saturated.b) / 3.0;
}

void main() {

  vec4 color = texture2D(DiffuseSampler, texCoord); 	//input standard color
  
  float frag_lightness = desaturate(color);

  vec4 desat;
  desat.r = mix(color.r * 1.162, frag_lightness, 0.6);
  desat.g = mix(color.g, frag_lightness, 0.9);    //calculate night lighting
  desat.b = mix(color.b * 1.464, frag_lightness, 0.0);

  //save weighted fragment ... sorry this is so discombobulated
  gl_FragColor = mix(
      desat, 
      color, 
      (mix(
        threshold(average()),
        1.0, 
        threshold(frag_lightness) /*/ 2.0*/)) //Dividing here determines resaturation of light objects in dark scenes
    );
}
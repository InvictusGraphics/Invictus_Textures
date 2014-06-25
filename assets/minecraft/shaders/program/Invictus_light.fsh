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
  return (0.5 * (1 + tanh(6.0 * x - 1.5)));
}

void main() {

  vec4 color = texture2D(DiffuseSampler, texCoord); 	//input standard color

  float desat = (color.r + color.g + color.b) / 3.0;    //calculate a desaturated channel


  //return weighted output
  gl_FragColor = mix(desat, color, (threshold(average())));
}
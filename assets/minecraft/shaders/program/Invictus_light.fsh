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

float desaturate(vec4 saturated){
  return (saturated.r + saturated.g + saturated.b) / 3.0;
}

float threshold(float x){
  //weight of average leans toward night and does not affect day.   //y = .5(1 + tanh(6x-1.5))
  return (0.5 * (1.0 + tanh(6.0 * x - 1.5)));
}

vec4 bloom(){
  float range = 0.01;
  
  vec4 total = vec4(0);
  int samples = 0;
  for(float x = texCoord.x - range; x < texCoord.x + range; x += 0.002)
  {
    for(float y = texCoord.y - range; y < texCoord.y + range; y += 0.002)
    {
      total += (texture2D(DiffuseSampler, vec2(x, y)));
      samples++;
    }
  }
  total = total / samples;
  //bloom.r = bloom.r * 1.1;
  // Set the current fragment to the original texture pixel, with our bloom value added on
  return total;
  }

void main() {

  vec4 color = texture2D(DiffuseSampler, texCoord); 	 //input standard color
  float frag_lightness = threshold(desaturate(color));
  vec4 desat;
  desat.r = mix(frag_lightness, color.r, 0.2);  //calculate night lighting
  desat.g = mix(frag_lightness, color.g, 0.1);
  desat.b = mix(frag_lightness, color.b*1.414, 0.5);

  float average = average();
  vec4 color_day = mix(bloom() + color, color, threshold(average));
  float mixer = threshold(mix(average, 1.0, frag_lightness));
  //save weighted fragment and filter out light fragments in darkness weighting
  color = mix(desat, color_day, mixer);
  gl_FragColor = color;
}

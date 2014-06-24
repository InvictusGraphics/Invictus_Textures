uniform sampler2D DiffuseSampler;
varying vec2 texCoord;

float desaturate(vec4 input){
  float channel = (input.x + input.y + input.z) / 3.0;
  return channel;
}

void main() {
  vec4 color = texture2D(DiffuseSampler, texCoord); 		//input standard color
  
  float total = 0.0;

  vec2 position = (0.0, 0.0);
  float samples = 0.0; 
  for (position.x; position.x <= 1.0; position.x += 0.1){
    for (position.y; position.y <= 1.0; position.x += 0.1){
      total = total + desaturate(texture2D(DiffuseSampler, position));
      samples++;

    }
  }

  float average = total / samples;

    //Screen
  color = (1.0 - ((1.0 - color) * (1.0 - color)));

  vec4 desat;
  desat.xyz = (desaturate(color), desaturate(color), desaturate(color));    //calculate desaturated image

  //formula to return weighted output
  gl_FragColor = ((color / (1.0 - average)) + (desat / average)) / 2.0;
}
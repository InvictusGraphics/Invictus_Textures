uniform sampler2D DiffuseSampler;
uniform sampler2D BlurSampler;
varying vec2 texCoord;
uniform sampler2D buffer;

/*
void blur(vec4 color){
    //testing the method
 color = color_blur;
}
*/

void main() {
  vec4 color = texture2D(DiffuseSampler, texCoord); 		//input standard color
  vec4 color_blur = texture2D(BlurSampler, texCoord);

  vec4 desat;
  desat.xyz = ((color.x + color.y + color.z) / 3.0); 	  //calculate desaturated image 

    //Screen
  color = (1.0 - ((1.0 - color) * (1.0 - color)));

  //blur(color);

  gl_FragColor = (color + desat) / 2.0;

  //formula to return weighted output
  //TODO: calculate average
  //gl_FragColor = ((color / (1.0 - average)) + (desat / average)) / 2.0;
}
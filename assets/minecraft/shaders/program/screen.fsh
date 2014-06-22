//Shoeboxam

uniform sampler2D DiffuseSampler;
varying vec2 texCoord;
//uniform average;


void main() {
  vec4 color = texture2D(DiffuseSampler, texCoord); 		//input color
  vec4 desat;
  desat.xyz = ((color.x + color.y + color.z) / 3.0); 	//calculate desaturated image 
  //vec2 average = texture2D(texCoord);

  color = (color + (1.0 - ((1.0 - color) * (1.0 - color))))/2.0;
  //gl_FragColor = ((color / (1.0 - average)) + (desat / average)) / 2.0;
  gl_FragColor = (desat + color) / 2.0;
}
uniform sampler2D DiffuseSampler;
varying vec2 texCoord;

void main() {
  vec4 color_average = texture2DProjLod(DiffuseSampler, texCoord.xyx, 5.0);
  vec4 color = texture2D(DiffuseSampler, texCoord); 		//input standard color


    //Screen
  color = (1.0 - ((1.0 - color) * (1.0 - color)));

  vec4 desat;
  desat.xyz = (color.x, color.y, color.z) / 3.0;    //calculate desaturated image

  //formula to return weighted output
  gl_FragColor = ((color / (1.0 - color_average)) + (desat / color_average)) / 2.0;
}
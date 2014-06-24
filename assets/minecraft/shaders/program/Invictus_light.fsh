uniform sampler2D DiffuseSampler;
varying vec2 texCoord;

void main() {

  vec4 color_average = texture2DProjLod(DiffuseSampler, vec3(texCoord.x, texCoord.y,0.0), 100.0);
  vec4 color = texture2D(DiffuseSampler, texCoord); 		//input standard color

    //Screen
  //color = (1.0 - ((1.0 - color) * (1.0 - color)));

  vec4 desat;
  desat.xyz = (color.x, color.y, color.z) / 3.0;    //calculate desaturated image
  color_average.xyz = (color_average.x, color_average.y, color_average.z) / 3.0;

  //formula to return weighted output
  gl_FragColor = ((desat * (2.0 - color_average)) + (color * (1.0 + color_average)))/ 2.0;
}
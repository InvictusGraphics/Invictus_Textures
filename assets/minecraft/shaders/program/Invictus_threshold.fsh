#version 130

uniform sampler2D DiffuseSampler;
varying vec2 texCoord;


float isolation_threshold(vec4 x){
  //picks out light parts of a scene
  return .5 * (1.0 + tanh(6 * x - 2.1));
}

void main() {
  gl_FragColor = vec4(isolation_threshold(texture2D(DiffuseSampler, texCoord)));
}

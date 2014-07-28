#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D AverageSampler;
varying vec2 texCoord;

float desaturate(vec4 saturated){
  return dot(saturated.rgb, vec3(1.0)) * 0.33; //Thank you lycene from Bukkit forums!
}

float isolation_threshold(float x){
  //picks out light parts of a scene
  return .5 * (1.0 + tanh(6 * x - 2.1));
}

float opacity_threshold(float x){
  return .5 * (1.0 - tanh(9.0 * x - 2));
}

void main() {
  float average = desaturate(texture2D(AverageSampler, texCoord));
  float color = desaturate(texture2D(DiffuseSampler, texCoord));

  gl_FragColor = vec4(mix(0.0, isolation_threshold(color), opacity_threshold(average)));
}

#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D ThresholdSampler;
uniform sampler2D AverageSampler;

varying vec2 texCoord;

vec4 artificial_light = vec4( 0.388, 0.137, 0.0, 1.0 );
vec4 night_light = vec4( 0.0, 0.075, 0.212, 1.0 );

/*
float desaturate(vec4 saturated){
  return dot(CurrTexel.rgb, vec3(1.0)) * 0.33; //Thank you lycene from Bukkit forums!
}
*/

float red(float x){
  return .5 * (1.0 + tanh(3.2 * x - 1.5));
}

float blue(float x){
  return 1;
}

void main() {

  vec4 color_diffuse = texture2D(DiffuseSampler, texCoord);
  vec4 color_average = texture2D(AverageSampler, texCoord);
  vec4 color_threshold = texture2D(ThresholdSampler, texCoord);

  artificial_light = (mix(vec4(0.0), artificial_light, color_threshold.r)); //mask artificial light with threshold

  vec4 color_bloom = vec4(color_diffuse.rgb + color_threshold.rgb, color_diffuse.w); //infuse bloom
  color_bloom = mix(color_diffuse, color_bloom, color_diffuse/ 2);

  //color_bloom = mix(color_bloom, color_diffuse, color_average);
  gl_FragColor = color_bloom;
}

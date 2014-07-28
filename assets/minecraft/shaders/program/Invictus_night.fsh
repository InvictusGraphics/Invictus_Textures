#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D ThresholdSampler;

varying vec2 texCoord;

vec4 artificial_light = vec4( 0.888, 0.437, 0.3, 1.0 );
vec4 night_light = vec4( 0.0, 0.075, 0.212, 1.0 );

float desaturate(vec4 saturated){
  return dot(saturated.rgb, vec3(1.0)) * 0.33; //Thank you lycene from Bukkit forums!
}

void main() {
  vec4 color_diffuse = texture2D(DiffuseSampler, texCoord);
  vec4 color_threshold = texture2D(ThresholdSampler, texCoord);

  float frag_lightness = desaturate(color_diffuse);

  vec4 color_bloom = mix(vec4(0.0), artificial_light, color_threshold.r); //colorize bloom
  color_diffuse += color_bloom;
  color_diffuse = mix(color_diffuse, vec4(frag_lightness), frag_lightness ); // desat

  gl_FragColor = color_diffuse;
}

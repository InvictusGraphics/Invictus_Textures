#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D ThresholdSampler;

varying vec2 texCoord;

vec4 artificial_light = vec4( 0.388, 0.137, 0.0, 1.0 );
vec4 night_light = vec4( 0.0, 0.075, 0.212, 1.0 );

float desaturate(vec4 saturated){
  return dot(saturated.rgb, vec3(1.0)) * 0.33; //Thank you lycene from Bukkit forums!
}

void main() {
  vec4 color_diffuse = texture2D(DiffuseSampler, texCoord);
  vec4 color_threshold = texture2D(ThresholdSampler, texCoord);

  float color_lightness = desaturate(color_diffuse);

  color_diffuse = mix(vec4(0.0), artificial_light, color_threshold.r); //add bloom
  color_diffuse = mix(vec4(color_lightness), color_diffuse, (1.0-color_threshold.r) ); //add desat

  gl_FragColor = color_diffuse;
}

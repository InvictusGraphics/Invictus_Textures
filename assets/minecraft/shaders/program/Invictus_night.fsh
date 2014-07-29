#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D BlurSampler;

varying vec2 texCoord;

vec4 artificial_light = vec4( 0.9, 0.3, 0.0, 0.0 );
vec4 night_light = vec4( 0.0, 0.075, 0.212, 1.0 );

float desaturate(vec4 saturated){
  return dot(saturated.rgb, vec3(1.0)) * 0.33; //Thank you lycene from Bukkit forums!
}

float isolation_threshold(float x){
  //picks out light parts of a scene
  return .5 * (1.0 + tanh(7 * x - 2.5));
}

float opacity_threshold(float x){
  //Determines fade into saturation around torches
  return .5 * (1.0 + tanh(10 * x - 1.));
}


void main() {
  vec4 color_diffuse = texture2D(DiffuseSampler, texCoord);
  float color_bloom = isolation_threshold(desaturate(texture2D(BlurSampler, texCoord)));

  float frag_lightness = desaturate(color_diffuse);


  color_diffuse = mix(vec4(frag_lightness/20), color_diffuse, opacity_threshold(frag_lightness)); // desat
  color_diffuse.rgb += mix(color_bloom, 0.0, frag_lightness);
  gl_FragColor = color_diffuse;
}

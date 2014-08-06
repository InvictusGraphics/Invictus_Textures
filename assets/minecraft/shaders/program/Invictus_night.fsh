#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D BlurSampler;

varying vec2 texCoord;

vec4 artificial_light = vec4( 1.0, 0.902, 0.569, 0.0 );
vec4 night_light = vec4( 0.05, 0.07, 0.1, 1.0 );

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
  vec4 color_blur = texture2D(BlurSampler, texCoord);
  float bloom_mask = isolation_threshold(desaturate(color_blur)); //calc bloom

  float frag_lightness = desaturate(color_diffuse); //Calculate average lightness of single fragment

  vec4 color_bloom = mix(vec4(0.0), artificial_light, bloom_mask); //colorize artificial light

  color_diffuse *= 1.0-desaturate(night_light); //darken diffuse amount that is added by night light
  color_diffuse += mix(vec4(0.0), night_light, 1.0 - bloom_mask); //add night light, filtered by inverse bloom


  color_diffuse = mix(vec4(frag_lightness/20), color_diffuse, opacity_threshold(frag_lightness)); // desat
  color_diffuse += mix((color_blur+artificial_light)/2.0, vec4(0.0), 1-bloom_mask); //filter bloom on lightness, add to diffuse
  color_diffuse = mix(color_diffuse, (artificial_light+color_blur) / 2.0, bloom_mask);
  gl_FragColor = color_diffuse;
}

#version 130

uniform sampler2D DiffuseSampler;
uniform sampler2D DaySampler;
uniform sampler2D NightSampler;
uniform sampler2D AverageSampler;

varying vec2 texCoord;


float desaturate(vec4 saturated){
  return dot(saturated.rgb, vec3(1.0)) * 0.33; //Thank you lycene from Bukkit forums!
}

float opacity_threshold_day(float x){
  return .5 * (1.0 + tanh(8.0 * x - 2))-x;
}

float opacity_threshold_night(float x){
  return .25 * (1.0 - tanh(9.0 * x - 1.9));
}

void main() {
  float average = desaturate(texture2D(AverageSampler, texCoord)); //Average lightness

  vec4 color = texture2D(DiffuseSampler, texCoord);
  vec4 color_day = texture2D(DaySampler, texCoord);
  vec4 color_night = texture2D(NightSampler, texCoord);

  color = vec4(mix(color, color_day, opacity_threshold_day(average)));
  color = vec4(mix(color, color_night, opacity_threshold_night(average)));

  gl_FragColor = color;
}

#version 120

uniform sampler2D DiffuseSampler;
uniform sampler2D PastSampler;
uniform float opacity;

varying vec2 texCoord;

void main() {
  vec4 diffuse = texture2D(DiffuseSampler, texCoord);
  vec4 past = texture2D(PastSampler, texCoord);

  gl_FragColor = mix(diffuse, past, opacity);
}

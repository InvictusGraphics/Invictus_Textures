#version 120

uniform sampler2D DiffuseSampler;
uniform sampler2D PastSampler;
uniform float opacity;

varying vec2 texCoord;

void main() {
  gl_FragColor = mix(texture2D(DiffuseSampler, texCoord), texture2D(PastSampler, texCoord), opacity); //mix current frag with past frag at given opacity
}

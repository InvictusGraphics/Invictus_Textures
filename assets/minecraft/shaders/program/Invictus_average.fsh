#version 120

uniform sampler2D DiffuseSampler;

/*
Only using 25 samples because it samples from the looped blur.
Explicitly listed because dependent samples are not well optimized.
*/

void main() {

gl_FragColor = ((
texture2D(DiffuseSampler, vec2(0.1, 0.1)) +
texture2D(DiffuseSampler, vec2(0.1, 0.3)) +
texture2D(DiffuseSampler, vec2(0.1, 0.5)) +
texture2D(DiffuseSampler, vec2(0.1, 0.7)) +
texture2D(DiffuseSampler, vec2(0.1, 0.9)) +

texture2D(DiffuseSampler, vec2(0.3, 0.1)) +
texture2D(DiffuseSampler, vec2(0.3, 0.3)) +
texture2D(DiffuseSampler, vec2(0.3, 0.5)) +
texture2D(DiffuseSampler, vec2(0.3, 0.7)) +
texture2D(DiffuseSampler, vec2(0.3, 0.9)) +

texture2D(DiffuseSampler, vec2(0.5, 0.1)) +
texture2D(DiffuseSampler, vec2(0.5, 0.3)) +
texture2D(DiffuseSampler, vec2(0.5, 0.5)) +
texture2D(DiffuseSampler, vec2(0.5, 0.7)) +
texture2D(DiffuseSampler, vec2(0.5, 0.9)) +

texture2D(DiffuseSampler, vec2(0.7, 0.1)) +
texture2D(DiffuseSampler, vec2(0.7, 0.3)) +
texture2D(DiffuseSampler, vec2(0.7, 0.5)) +
texture2D(DiffuseSampler, vec2(0.7, 0.7)) +
texture2D(DiffuseSampler, vec2(0.7, 0.9)) +

texture2D(DiffuseSampler, vec2(0.9, 0.1)) +
texture2D(DiffuseSampler, vec2(0.9, 0.3)) +
texture2D(DiffuseSampler, vec2(0.9, 0.5)) +
texture2D(DiffuseSampler, vec2(0.9, 0.7)) +
texture2D(DiffuseSampler, vec2(0.9, 0.9)) ) / 25.0);
}

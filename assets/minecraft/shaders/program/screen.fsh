uniform sampler2D DiffuseSampler;
varying vec2 texCoord;
void main() {
vec4 color = texture2D(DiffuseSampler, texCoord);
gl_FragColor = (color + (1.0 - ((1.0 - color) * (1.0 - color))))/2.0;
}

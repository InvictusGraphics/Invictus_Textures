//http://www.gamerendering.com/2008/10/11/gaussian-blur-filter-shader/
uniform sampler2D DiffuseSampler;
varying vec2 texCoord;
uniform float resolution;
const float blurSize = 1.0/resolution;

void main(void)
{
   vec4 sum = vec4(0.0);

   // blur in y (vertical)
   // take nine samples, with the distance blurSize between them
   sum += texture2D(DiffuseSampler, vec2(texCoord.x - 4.0*blurSize, texCoord.y)) * 0.05;
   sum += texture2D(DiffuseSampler, vec2(texCoord.x - 3.0*blurSize, texCoord.y)) * 0.09;
   sum += texture2D(DiffuseSampler, vec2(texCoord.x - 2.0*blurSize, texCoord.y)) * 0.12;
   sum += texture2D(DiffuseSampler, vec2(texCoord.x - blurSize, texCoord.y)) * 0.15;
   sum += texture2D(DiffuseSampler, vec2(texCoord.x, texCoord.y)) * 0.16;
   sum += texture2D(DiffuseSampler, vec2(texCoord.x + blurSize, texCoord.y)) * 0.15;
   sum += texture2D(DiffuseSampler, vec2(texCoord.x + 2.0*blurSize, texCoord.y)) * 0.12;
   sum += texture2D(DiffuseSampler, vec2(texCoord.x + 3.0*blurSize, texCoord.y)) * 0.09;
   sum += texture2D(DiffuseSampler, vec2(texCoord.x + 4.0*blurSize, texCoord.y)) * 0.05;

   gl_FragColor = sum;
}

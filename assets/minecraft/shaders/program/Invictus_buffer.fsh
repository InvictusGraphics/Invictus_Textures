uniform sampler2D DiffuseSampler;
varying vec2 texCoord;


void main() {
  //vec4 color = texture2D(DiffuseSampler, texCoord);     //input color
  gl_FragColor = texture2D(DiffuseSampler, texCoord);                         //output color //multiplied to test multiple passes
}

  //void glGenFramebuffers(GLsizei n, GLuint *ids);
  //void glBindFramebuffer(GLenum target, GLuint framebuffer);
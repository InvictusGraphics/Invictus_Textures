uniform sampler2D DiffuseSampler;
varying vec2 texCoord;


void main() {
  vec4 color = texture2D(DiffuseSampler, texCoord);     //input color

/*
  // The framebuffer, which regroups 0, 1, or more textures, and 0 or 1 depth buffer.
  GLuint FramebufferName = 0;
  glGenFramebuffers(1, &FramebufferName);
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);

  // The texture we're going to render to
  GLuint FramebufferName;
  glGenTextures(1, &FramebufferName);
 
  // "Bind" the newly created texture : all future texture functions will modify this texture
  glBindTexture(GL_TEXTURE_2D, FramebufferName);
 
  // Give an empty image to OpenGL ( the last "0" )
  glTexImage2D(GL_TEXTURE_2D, 0,GL_RGB, 1024, 768, 0,GL_RGB, GL_UNSIGNED_BYTE, 0);
 
  // Poor filtering. Needed !
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

  // The depth buffer
  GLuint depthrenderbuffer;
  glGenRenderbuffers(1, &depthrenderbuffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depthrenderbuffer);
  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, 1024, 768);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthrenderbuffer);

  // Always check that our framebuffer is ok
  if(glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
  return false;

  // Render to our framebuffer
  glBindFramebuffer(GL_FRAMEBUFFER, FramebufferName);
  glViewport(0,0,1024,768); // Render on the whole framebuffer, complete from the lower left corner to the upper right

  layout(location = 0) out vec3 color;*/

  gl_FragColor = color * (color * 1.2);                         //output color //multiplied to test multiple passes
}

  //void glGenFramebuffers(GLsizei n, GLuint *ids);
  //void glBindFramebuffer(GLenum target, GLuint framebuffer);
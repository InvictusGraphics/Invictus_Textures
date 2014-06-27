#version 120

attribute vec4 Position;

uniform mat4 ProjMat;
uniform vec2 OutSize;
varying vec2 texCoord;

varying vec2 sampleCoords[64];

void main(){
  vec4 outPos = ProjMat * vec4(Position.xy, 0.0, 1.0);
  gl_Position = vec4(outPos.xy, 0.2, 1.0);

  texCoord = Position.xy / OutSize;
  texCoord.y = 1.0 - texCoord.y;

  for (int index = 0; index <= 64; index++){
  	int y = int(mod(float(index), 8.0));   	//calculate column
    int x = index / 8;                      // calculate row
    sampleCoords[index] = vec2(x, y);
  }
}
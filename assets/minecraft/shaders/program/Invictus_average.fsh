#version 120

uniform sampler2D DiffuseSampler;

/*
Python script to generate list of samples
for x in range (1, 10):
    print ' '
    for y in range (1, 10):
        print 'texture2D(DiffuseSampler, vec2(' + str((x/10.0)) + ', ' + str((y/10.0)) + ')) +'

Explicit coordinates apparently improves framerate.. *crosses fingers*
*/

void main() {

gl_FragColor = ((
texture2D(DiffuseSampler, vec2(0.1, 0.1)) +
texture2D(DiffuseSampler, vec2(0.1, 0.2)) +
texture2D(DiffuseSampler, vec2(0.1, 0.3)) +
texture2D(DiffuseSampler, vec2(0.1, 0.4)) +
texture2D(DiffuseSampler, vec2(0.1, 0.5)) +
texture2D(DiffuseSampler, vec2(0.1, 0.6)) +
texture2D(DiffuseSampler, vec2(0.1, 0.7)) +
texture2D(DiffuseSampler, vec2(0.1, 0.8)) +
texture2D(DiffuseSampler, vec2(0.1, 0.9)) +

texture2D(DiffuseSampler, vec2(0.2, 0.1)) +
texture2D(DiffuseSampler, vec2(0.2, 0.2)) +
texture2D(DiffuseSampler, vec2(0.2, 0.3)) +
texture2D(DiffuseSampler, vec2(0.2, 0.4)) +
texture2D(DiffuseSampler, vec2(0.2, 0.5)) +
texture2D(DiffuseSampler, vec2(0.2, 0.6)) +
texture2D(DiffuseSampler, vec2(0.2, 0.7)) +
texture2D(DiffuseSampler, vec2(0.2, 0.8)) +
texture2D(DiffuseSampler, vec2(0.2, 0.9)) +

texture2D(DiffuseSampler, vec2(0.3, 0.1)) +
texture2D(DiffuseSampler, vec2(0.3, 0.2)) +
texture2D(DiffuseSampler, vec2(0.3, 0.3)) +
texture2D(DiffuseSampler, vec2(0.3, 0.4)) +
texture2D(DiffuseSampler, vec2(0.3, 0.5)) +
texture2D(DiffuseSampler, vec2(0.3, 0.6)) +
texture2D(DiffuseSampler, vec2(0.3, 0.7)) +
texture2D(DiffuseSampler, vec2(0.3, 0.8)) +
texture2D(DiffuseSampler, vec2(0.3, 0.9)) +

texture2D(DiffuseSampler, vec2(0.4, 0.1)) +
texture2D(DiffuseSampler, vec2(0.4, 0.2)) +
texture2D(DiffuseSampler, vec2(0.4, 0.3)) +
texture2D(DiffuseSampler, vec2(0.4, 0.4)) +
texture2D(DiffuseSampler, vec2(0.4, 0.5)) +
texture2D(DiffuseSampler, vec2(0.4, 0.6)) +
texture2D(DiffuseSampler, vec2(0.4, 0.7)) +
texture2D(DiffuseSampler, vec2(0.4, 0.8)) +
texture2D(DiffuseSampler, vec2(0.4, 0.9)) +

texture2D(DiffuseSampler, vec2(0.5, 0.1)) +
texture2D(DiffuseSampler, vec2(0.5, 0.2)) +
texture2D(DiffuseSampler, vec2(0.5, 0.3)) +
texture2D(DiffuseSampler, vec2(0.5, 0.4)) +
texture2D(DiffuseSampler, vec2(0.5, 0.5)) +
texture2D(DiffuseSampler, vec2(0.5, 0.6)) +
texture2D(DiffuseSampler, vec2(0.5, 0.7)) +
texture2D(DiffuseSampler, vec2(0.5, 0.8)) +
texture2D(DiffuseSampler, vec2(0.5, 0.9)) +

texture2D(DiffuseSampler, vec2(0.6, 0.1)) +
texture2D(DiffuseSampler, vec2(0.6, 0.2)) +
texture2D(DiffuseSampler, vec2(0.6, 0.3)) +
texture2D(DiffuseSampler, vec2(0.6, 0.4)) +
texture2D(DiffuseSampler, vec2(0.6, 0.5)) +
texture2D(DiffuseSampler, vec2(0.6, 0.6)) +
texture2D(DiffuseSampler, vec2(0.6, 0.7)) +
texture2D(DiffuseSampler, vec2(0.6, 0.8)) +
texture2D(DiffuseSampler, vec2(0.6, 0.9)) +

texture2D(DiffuseSampler, vec2(0.7, 0.1)) +
texture2D(DiffuseSampler, vec2(0.7, 0.2)) +
texture2D(DiffuseSampler, vec2(0.7, 0.3)) +
texture2D(DiffuseSampler, vec2(0.7, 0.4)) +
texture2D(DiffuseSampler, vec2(0.7, 0.5)) +
texture2D(DiffuseSampler, vec2(0.7, 0.6)) +
texture2D(DiffuseSampler, vec2(0.7, 0.7)) +
texture2D(DiffuseSampler, vec2(0.7, 0.8)) +
texture2D(DiffuseSampler, vec2(0.7, 0.9)) +

texture2D(DiffuseSampler, vec2(0.8, 0.1)) +
texture2D(DiffuseSampler, vec2(0.8, 0.2)) +
texture2D(DiffuseSampler, vec2(0.8, 0.3)) +
texture2D(DiffuseSampler, vec2(0.8, 0.4)) +
texture2D(DiffuseSampler, vec2(0.8, 0.5)) +
texture2D(DiffuseSampler, vec2(0.8, 0.6)) +
texture2D(DiffuseSampler, vec2(0.8, 0.7)) +
texture2D(DiffuseSampler, vec2(0.8, 0.8)) +
texture2D(DiffuseSampler, vec2(0.8, 0.9)) +

texture2D(DiffuseSampler, vec2(0.9, 0.1)) +
texture2D(DiffuseSampler, vec2(0.9, 0.2)) +
texture2D(DiffuseSampler, vec2(0.9, 0.3)) +
texture2D(DiffuseSampler, vec2(0.9, 0.4)) +
texture2D(DiffuseSampler, vec2(0.9, 0.5)) +
texture2D(DiffuseSampler, vec2(0.9, 0.6)) +
texture2D(DiffuseSampler, vec2(0.9, 0.7)) +
texture2D(DiffuseSampler, vec2(0.9, 0.8)) +
texture2D(DiffuseSampler, vec2(0.9, 0.9)) ) / 81.0);
}

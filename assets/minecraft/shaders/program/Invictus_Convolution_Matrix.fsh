#version 120

uniform sampler2D DiffuseSampler;
varying vec2 texCoord;

/*
#Python scripts to generate texture samples. Explicit samples seem to help framerate.
depth = .005

for x in range(3):
    for y in range(3):
        print("\t\ttexture2D(DiffuseSampler, vec2(texCoord.x + "+ str((x-1)*depth) + ", texCoord.y + "+ str((y-1)*depth) + ")),\n"),

	index table
	0 1 2
	3 4 5
	6 7 8

		index 4 is center of convolution matrix
*/


        	//Base image
	vec4 base[9] = vec4[9](
		texture2D(DiffuseSampler, vec2(texCoord.x + -0.005, texCoord.y + -0.005)),
		texture2D(DiffuseSampler, vec2(texCoord.x + -0.005, texCoord.y + 0.0)),
		texture2D(DiffuseSampler, vec2(texCoord.x + -0.005, texCoord.y + 0.005)),
		texture2D(DiffuseSampler, vec2(texCoord.x + 0.0, texCoord.y + -0.005)),
		texture2D(DiffuseSampler, vec2(texCoord.x + 0.0, texCoord.y + 0.0)),
		texture2D(DiffuseSampler, vec2(texCoord.x + 0.0, texCoord.y + 0.005)),
		texture2D(DiffuseSampler, vec2(texCoord.x + 0.005, texCoord.y + -0.005)),
		texture2D(DiffuseSampler, vec2(texCoord.x + 0.005, texCoord.y + 0.0)),
		texture2D(DiffuseSampler, vec2(texCoord.x + 0.005, texCoord.y + 0.005)));


			//Kernel ~ default
	float kernel[9] = float[9](0.0);


void original(){
	kernel[4] = 1.0;
}

void sharpen(){
	kernel[1] -= 1.0;
	kernel[3] -= 1.0;
	kernel[4] += 5.0;
	kernel[5] -= 1.0;
	kernel[7] -= 1.0;
}

void blur(){

	for (int i = 0; i <= 8; i++) {
		kernel[i] += (1.0/9.0);
	}
}

void edge_detect(){
	kernel[1] += 1.0;
	kernel[3] += 1.0;
	kernel[4] -= 4.0;
	kernel[5] += 1.0;
	kernel[7] += 1.0;
}

void emboss(){
	kernel[0] -= 2.0;
	kernel[1] -= 1.0;
	kernel[3] -= 1.0;
	kernel[4] += 1.0;
	kernel[5] += 1.0;
	kernel[7] += 1.0;
	kernel[8] += 2.0;
}

void main() {

	//sharpen();
	blur();
	edge_detect();
	emboss();
	//original();

	vec4 color = vec4(0.0);
	for (int i = 0; i <= 8; i++) {
		color += (base[i] * kernel[i]);
	}
	gl_FragColor = color;
}



/*
#Old script in case I decide to go back to separate variables~

depth = .01
for x in range(3):
    for y in range(3):
        print("vec4 _" + str(x) + '_' + str(y) + " = texture2D(DiffuseSampler, vec2(texCoord.x + "+ str((x-1)*depth) + ", texCoord.y + "+ str((y-1)*depth) + ");")

	_1_1 _2_1 _3_1
	_1_2 _2_2 _3_2
	_1_3 _2_3 _3_3

			_2_2 is center of convolution matrix

*/

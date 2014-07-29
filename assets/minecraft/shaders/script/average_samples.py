#generates the code in the average fragment shader
for x in range(1, 10, 2):
    print ' '
    for y in range(1, 10, 2):
        print 'texture2D(DiffuseSampler, vec2(' + str((x/10.0)) + ', ' + str((y/10.0)) + ')) +'

#Explicit coordinates apparently improves framerate..
#Reads inside branching structures cannot be predicted/preloaded/cached as well

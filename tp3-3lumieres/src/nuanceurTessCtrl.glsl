#version 410
uniform float TessLevelInner;
uniform float TessLevelOuter;

layout(vertices = 4) out;

in Attribs {
    vec4 couleur;
    vec2 textureCoord;
} AttribsIn[];

in myVec {
    vec3 normVec, obsVec;
    vec3 lumiDir[3];
}  myVecIn[];

out myVec {
    vec3 normVec, obsVec;
    vec3 lumiDir[3];
}  myVecOut[];

out Attribs {
    vec4 couleur;
    vec2 textureCoord;
} AttribsOut[];

void main()
{
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    if ( gl_InvocationID == 0 )
    {
        gl_TessLevelInner[0] = TessLevelInner;
        gl_TessLevelInner[1] = TessLevelInner;
        gl_TessLevelOuter[0] = TessLevelOuter;
        gl_TessLevelOuter[1] = TessLevelOuter;
        gl_TessLevelOuter[2] = TessLevelOuter;
        gl_TessLevelOuter[3] = TessLevelOuter;

    }

    // copier les autres attributs vers la sortie
    AttribsOut[gl_InvocationID].couleur = AttribsIn[gl_InvocationID].couleur;
    AttribsOut[gl_InvocationID].textureCoord = AttribsIn[gl_InvocationID].textureCoord;

    myVecOut[gl_InvocationID].normVec = myVecIn[gl_InvocationID].normVec;

    myVecOut[gl_InvocationID].obsVec = myVecIn[gl_InvocationID].obsVec;

    for(int i =0; i < 3; i++)
    {
        myVecOut[gl_InvocationID].lumiDir[i] = myVecIn[gl_InvocationID].lumiDir[i];
    }


}
#version 410

layout(quads) in;

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
}  myVecOut;

out Attribs {
    vec4 couleur;
    vec2 textureCoord;
} AttribsOut;


vec2 interpole( vec2 v0, vec2 v1, vec2 v2, vec2 v3 )
{
    // mix( x, y, f ) = x * (1-f) + y * f.
    vec2 v01 = mix( v0, v1, gl_TessCoord.x );
    vec2 v32 = mix( v2, v3, gl_TessCoord.x );
    return mix( v01, v32, gl_TessCoord.y );
}
vec3 interpole( vec3 v0, vec3 v1, vec3 v2, vec3 v3 )
{
    // mix( x, y, f ) = x * (1-f) + y * f.
    vec3 v01 = mix( v0, v1, gl_TessCoord.x );
    vec3 v32 = mix( v2, v3, gl_TessCoord.x );
    return mix( v01, v32, gl_TessCoord.y );
}
vec4 interpole( vec4 v0, vec4 v1, vec4 v2, vec4 v3 )
{
    // mix( x, y, f ) = x * (1-f) + y * f.
    vec4 v01 = mix( v0, v1, gl_TessCoord.x );
    vec4 v32 = mix( v2, v3, gl_TessCoord.x );
    return mix( v01, v32, gl_TessCoord.y );
}


void main()
{
    gl_Position = interpole( gl_in[0].gl_Position, gl_in[1].gl_Position, gl_in[2].gl_Position, gl_in[3].gl_Position );
    AttribsOut.couleur = interpole(AttribsIn[0].couleur, AttribsIn[1].couleur, AttribsIn[2].couleur, AttribsIn[3].couleur);
    AttribsOut.textureCoord = interpole(AttribsIn[0].textureCoord, AttribsIn[1].textureCoord, AttribsIn[2].textureCoord, AttribsIn[3].textureCoord);

    myVecOut.normVec = interpole( myVecIn[0].normVec, myVecIn[1].normVec, myVecIn[2].normVec, myVecIn[3].normVec);
    myVecOut.obsVec = interpole( myVecIn[0].obsVec, myVecIn[1].obsVec, myVecIn[2].obsVec, myVecIn[3].obsVec);


    for(int i = 0; i < 3; i++)
    {
        vec3 lumiDir = interpole(myVecIn[0].lumiDir[i], myVecIn[1].lumiDir[i], myVecIn[2].lumiDir[i], myVecIn[3].lumiDir[i] );
        myVecOut.lumiDir[i] = lumiDir;
    }
}

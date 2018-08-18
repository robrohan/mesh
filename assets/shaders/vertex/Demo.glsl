#version 120

attribute vec3 Pos;
attribute vec3 Color;
attribute vec2 TexCoord;
attribute vec3 Normal;
attribute vec3 Tangent;

uniform vec4 scaleMove;

varying vec3 fragmentColor;

void main()
{
  // If we don't use attributes they get dropped out
  // and GetAttribLocation fails to find them
  vec3 val = vec3(TexCoord, 1) * Normal * Tangent;

  // vec4 scaleMove = vec4(1,1,1,1);
  // YOU CAN OPTIMISE OUT cos(scaleMove.x) AND sin(scaleMove.y) AND UNIFORM THE VALUES IN
  vec3 scale = Pos.xyz * scaleMove.w;
  
  // rotate on z pole
  vec3 rotatez = vec3((scale.x * cos(scaleMove.x) - scale.y * sin(scaleMove.x)), (scale.x * sin(scaleMove.x) + scale.y * cos(scaleMove.x)), scale.z);
  // rotate on y pole
  vec3 rotatey = vec3((rotatez.x * cos(scaleMove.y) - rotatez.z * sin(scaleMove.y)), rotatez.y, (rotatez.x * sin(scaleMove.y) + rotatez.z * cos(scaleMove.y)));
  // rotate on x pole
  vec3 rotatex = vec3(rotatey.x, (rotatey.y * cos(scaleMove.z) - rotatey.z * sin(scaleMove.z)), (rotatey.y * sin(scaleMove.z) + rotatey.z * cos(scaleMove.z)));
  // move
  vec3 move = vec3(rotatex.xy, rotatex.z - 0.2);
  // terrible perspective transform
  vec3 persp = vec3( move.x  / ( (move.z + 2) / 3 ),
		                 move.y  / ( (move.z + 2) / 3 ),
		                                        move.z);


  fragmentColor = Color.xyz; // vec3(.5,.5,.5); // vec3(Color.x, .5, .5);

  gl_Position = vec4(persp, 1.0);
}
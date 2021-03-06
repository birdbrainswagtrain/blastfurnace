//
// utility functions
//

float saturate( float x) {
  return clamp( x, 0.0, 1.0);
}


//
// Global variable definitions
//

uniform sampler2D BaseTextureSampler;
uniform sampler2D DistortMapTextureSampler;


//
// User varying
//
varying vec4 xlat_varying_SV_POSITION;

//
// Shader's entry point
//
void main() {

	vec2 vOriginal = vec2( gl_TexCoord[0]);
	vec4 vRead;
	vec2 vGreen;
	vec4 vFinal;
	float fBoundsCheck;

	vRead = texture2D( DistortMapTextureSampler, vOriginal);
	vGreen.x  = ((vRead.x  + vRead.z ) / 2.00000);
	vGreen.y  = ((vRead.y  + vRead.w ) / 2.00000);
	vFinal.x  = texture2D( BaseTextureSampler, vRead.xy ).x ;
	vFinal.yw  = texture2D( BaseTextureSampler, vGreen).yw ;
	vFinal.z  = texture2D( BaseTextureSampler, vRead.zw ).z ;
	fBoundsCheck = saturate( (dot( vec2( lessThan( vGreen.xy , vec2( 0.0500000, 0.0500000)) ), vec2( 1.00000, 1.00000)) + dot( vec2( greaterThan( vGreen.xy , vec2( 0.950000, 0.950000)) ), vec2( 1.00000, 1.00000))) );
	vFinal.xyz  = mix( vFinal.xyz , vec3( 0.000000, 0.000000, 0.000000), vec3( fBoundsCheck));

	gl_FragData[0] = vec4( vFinal );
}


 

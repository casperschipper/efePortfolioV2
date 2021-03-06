#include <iostream>
#include "Perlin.h"

static inline float fade( float t ) { return t * t * t * (t * (t * 6 - 15) + 10); }
static inline float dfade( float t ) { return 30.0f * t * t * ( t * ( t - 2.0f ) + 1.0f ); }
inline float nlerp(float t, float a, float b) { return a + t * (b - a); }



Perlin::Perlin( uint8_t aOctaves, int32_t aSeed )
: mOctaves( aOctaves ), mSeed( aSeed ){
	initPermutationTable();
}

Perlin::Perlin( uint8_t aOctaves )
: mOctaves( aOctaves ), mSeed( 0x214 )
{
	initPermutationTable();
}


Perlin::~Perlin(){}

void Perlin::initPermutationTable()
{
    ofRandom(mSeed);
	//Rand rand( mSeed );
	for( size_t t = 0; t < 256; ++t ) {
		//mPerms[t] = mPerms[t + 256] = rand.nextInt() & 255;
        //this should be implemented with Boost
        mPerms[t] = mPerms[t + 256] = (int)ofRandom(0,2147483647) & 255;
	}
}

void Perlin::setSeed( int32_t aSeed )
{
	mSeed = aSeed;
	initPermutationTable();
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// fBm
float Perlin::fBm( float v ) const
{
	float result = 0.0f;
	float amp = 0.5f;
    
	for( uint8_t i = 0; i < mOctaves; i++ ) {
		result += noise( v ) * amp;
		v *= 2.0f;
		amp *= 0.5f;
	}
    
	return result;
}

float Perlin::fBm( const ofVec2f &v ) const
{
	float result = 0.0f;
	float amp = 0.5f;
    
	float x = v.x, y = v.y;
    
	for( uint8_t i = 0; i < mOctaves; i++ ) {
		result += noise( x, y ) * amp;
		x *= 2.0f; y *= 2.0f;
		amp *= 0.5f;
	}
    
	return result;
}

float Perlin::fBm( const ofVec3f &v ) const
{
	float result = 0.0f;
	float amp = 0.5f;
	float x = v.x, y = v.y, z = v.z;
    
	for( uint8_t i = 0; i < mOctaves; i++ ) {
		result += noise( x, y, z ) * amp;
		x *= 2.0f; y *= 2.0f; z *= 2.0f;
		amp *= 0.5f;
	}
    
	return result;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// dfBm
/*float Perlin::dfBm( float v ) const
 {
 float result = 0.0f;
 float amp = 0.5f;
 
 for( uint8_t i = 0; i < mOctaves; i++ ) {
 result += dnoise( v ) * amp;
 v *= 2.0f;
 amp *= 0.5f;
 }
 
 return result;
 }*/

ofVec2f Perlin::dfBm( const ofVec2f &v ) const
{
	ofVec2f result = ofVec2f(0,0);
	float amp = 0.5f;
    
	float x = v.x, y = v.y;
    
	for( uint8_t i = 0; i < mOctaves; i++ ) {
		result += dnoise( x, y ) * amp;
		x *= 2.0f; y *= 2.0f;
		amp *= 0.5f;
	}
    
	return result;
}

ofVec3f Perlin::dfBm( const ofVec3f &v ) const
{
	ofVec3f result = ofVec3f(0,0,0);
	float amp = 0.5f;
	float x = v.x, y = v.y, z = v.z;
    
	for( uint8_t i = 0; i < mOctaves; i++ ) {
		result += dnoise( x, y, z ) * amp;
		x *= 2.0f; y *= 2.0f; z *= 2.0f;
		amp *= 0.5f;
	}
    
	return result;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// noise
float Perlin::noise( float x ) const
{
	int32_t X = ((int32_t)floorf(x)) & 255;
	x -= floorf(x);
	float u = fade( x );
	int32_t A = mPerms[X], AA = mPerms[A], B = mPerms[X+1], BA = mPerms[B];
    
	return nlerp( u, grad( mPerms[AA  ], x ), grad( mPerms[BA], x-1 ) );
}

float Perlin::noise( float x, float y ) const
{
	int32_t X = ((int32_t)floorf(x)) & 255, Y = ((int32_t)floorf(y)) & 255;
	x -= floorf(x); y -= floorf(y);
	float	u = fade( x ), v = fade( y );
	int32_t A = mPerms[X  ]+Y, AA = mPerms[A], AB = mPerms[A+1],
	B = mPerms[X+1]+Y, BA = mPerms[B], BB = mPerms[B+1];
    
	return nlerp(v, nlerp(u, grad(mPerms[AA  ], x  , y   ),
                          grad(mPerms[BA  ], x-1, y   )),
                 nlerp(u, grad(mPerms[AB  ], x  , y-1   ),
                       grad(mPerms[BB  ], x-1, y-1   )));
}

float Perlin::noise( float x, float y, float z ) const
{
	// These floors need to remain that due to behavior with negatives.
	int32_t X = ((int32_t)floorf(x)) & 255, Y = ((int32_t)floorf(y)) & 255, Z = ((int32_t)floorf(z)) & 255;
	x -= floorf(x); y -= floorf(y); z -= floorf(z);
	float	u = fade(x), v = fade(y), w = fade(z);
	int32_t A = mPerms[X  ]+Y, AA = mPerms[A]+Z, AB = mPerms[A+1]+Z,
	B = mPerms[X+1]+Y, BA = mPerms[B]+Z, BB = mPerms[B+1]+Z;
    
	float a = grad(mPerms[AA  ], x  , y  , z   );
	float b = grad(mPerms[BA  ], x-1, y  , z   );
	float c = grad(mPerms[AB  ], x  , y-1, z   );
	float d = grad(mPerms[BB  ], x-1, y-1, z   );
	float e = grad(mPerms[AA+1], x  , y  , z-1 );
	float f = grad(mPerms[BA+1], x-1, y  , z-1 );
	float g = grad(mPerms[AB+1], x  , y-1, z-1 );
	float h = grad(mPerms[BB+1], x-1, y-1, z-1 );
    
	return	nlerp(w, nlerp( v, nlerp( u, a, b ),
                           nlerp( u, c, d ) ),
                  nlerp(v, nlerp( u, e, f ),
                        nlerp( u, g, h ) ) );	
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// dnoise
/*
 float Perlin::dnoise( float x ) const
 {
 int X = ((int)x) & 255;
 x -= ((int)x);
 float u = fade( x );
 int A = mPerms[X], AA = mPerms[A], B = mPerms[X+1], BA = mPerms[B];
 
 return nlerp( u, grad( mPerms[AA  ], x ), grad( mPerms[BA], x-1 ) );
 throw; //TODO
 return 0;
 }
 */

ofVec2f Perlin::dnoise( float x, float y ) const
{
	int32_t X = ((int32_t)x) & 255, Y = ((int32_t)y) & 255;
	x -= floorf(x); y -= floorf(y);
	float u = fade( x ), v = fade( y );
	float du = dfade( x ), dv = dfade( y );
	int32_t A = mPerms[X  ]+Y, AA = mPerms[A]+0, AB = mPerms[A+1]+0,
    B = mPerms[X+1]+Y, BA = mPerms[B]+0, BB = mPerms[B+1]+0;
    
	if( du < 0.000001f ) du = 1.0f;
	if( dv < 0.000001f ) dv = 1.0f;
    
	float a = grad( mPerms[AA], x  , y   );
	float b = grad( mPerms[BA], x-1, y   );
	float c = grad( mPerms[AB], x  , y-1   );
	float d = grad( mPerms[BB], x-1, y-1   );
	
    const float k1 =   b - a;
    const float k2 =   c - a;
    const float k4 =   a - b - c + d;
    
	return ofVec2f( du * ( k1 + k4 * v ), dv * ( k2 + k4 * u ) );
}

ofVec3f Perlin::dnoise( float x, float y, float z ) const
{
	int32_t X = ((int32_t)floorf(x)) & 255, Y = ((int32_t)floorf(y)) & 255, Z = ((int32_t)floorf(z)) & 255;
	x -= floorf(x); y -= floorf(y); z -= floorf(z);
	float u = fade( x ), v = fade( y ), w = fade( z );
	float du = dfade( x ), dv = dfade( y ), dw = dfade( z );
	int32_t A = mPerms[X  ]+Y, AA = mPerms[A]+Z, AB = mPerms[A+1]+Z,
    B = mPerms[X+1]+Y, BA = mPerms[B]+Z, BB = mPerms[B+1]+Z;
    
	if( du < 0.000001f ) du = 1.0f;
	if( dv < 0.000001f ) dv = 1.0f;
	if( dw < 0.000001f ) dw = 1.0f;	
    
	float a = grad( mPerms[AA  ], x  , y  , z   );
	float b = grad( mPerms[BA  ], x-1, y  , z   );
	float c = grad( mPerms[AB  ], x  , y-1, z   );
	float d = grad( mPerms[BB  ], x-1, y-1, z   );
	float e = grad( mPerms[AA+1], x  , y  , z-1 );
	float f = grad( mPerms[BA+1], x-1, y  , z-1 );
	float g = grad( mPerms[AB+1], x  , y-1, z-1 );
	float h = grad( mPerms[BB+1], x-1, y-1, z-1 );
    
    const float k1 =   b - a;
    const float k2 =   c - a;
    const float k3 =   e - a;
    const float k4 =   a - b - c + d;
    const float k5 =   a - c - e + g;
    const float k6 =   a - b - e + f;
    const float k7 =  -a + b + c - d + e - f - g + h;
    
	return ofVec3f(	du * ( k1 + k4*v + k6*w + k7*v*w ),
                 dv * ( k2 + k5*w + k4*u + k7*w*u ),
                 dw * ( k3 + k6*u + k5*v + k7*u*v ) );
}


float Perlin::grad( int32_t hash, float x ) const
{
	int32_t h = hash & 15;                      // CONVERT LO 4 BITS OF HASH CODE
	float	u = h<8 ? x : 0,                 // INTO 12 GRADIENT DIRECTIONS.
    v = h<4 ? 0 : h==12||h==14 ? x : 0;
	return ((h&1) == 0 ? u : -u) + ((h&2) == 0 ? v : -v);
}

float Perlin::grad( int32_t hash, float x, float y ) const
{
	int32_t h = hash & 15;                      // CONVERT LO 4 BITS OF HASH CODE
	float	u = h<8 ? x : y,                 // INTO 12 GRADIENT DIRECTIONS.
    v = h<4 ? y : h==12||h==14 ? x : 0;
	return ((h&1) == 0 ? u : -u) + ((h&2) == 0 ? v : -v);
}

float Perlin::grad( int32_t hash, float x, float y, float z ) const
{
	int32_t h = hash & 15;                      // CONVERT LO 4 BITS OF HASH CODE
	float u = h<8 ? x : y,                 // INTO 12 GRADIENT DIRECTIONS.
    v = h<4 ? y : h==12||h==14 ? x : z;
	return ((h&1) == 0 ? u : -u) + ((h&2) == 0 ? v : -v);
}

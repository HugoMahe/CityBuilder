shader_type particles;

uniform float rows = 4;
uniform float spacing = 1.0;

uniform sampler2D heightmap;
uniform float amplitude = 15.0;
uniform vec2 heightmap_size = vec2(300.0, 300.0);

float get_height(vec2 pos){
	pos -= 0.5 * heightmap_size;
	pos /= heightmap_size;
	
	return texture(heightmap, pos).r;
}

void vertex() {
	//Obtain our postion based on witch particle we're rendering
	vec3 pos = vec3(0.0,0.0,0.0);
	pos.z = float(INDEX);
	pos.x = mod(pos.z, rows);
	pos.z = (pos.z -pos.x) / rows;
	
	// center this
	pos.x -= rows *0.5;
	pos.z -= rows *0.5;
	
	pos *= spacing;
	
	pos.y = 1.0;
	
	TRANSFORM[3][0] = pos.x;
	TRANSFORM[3][1] = pos.y;
	TRANSFORM[3][2] = pos.z;
}
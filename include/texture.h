#ifndef __TEXTURE_H__
#define __TEXTURE_H__

#include "type.h"

// Datatype for a "texture sheet" : A texture that has several textures placed next to each other.
// All individual textures have same height. The individual texture width = individual texture height.
struct TextureSheet
{
    u8 *texture;

    // The width and height of entire texture sheet.
    u16 width;
    u16 height;

    // i.e the number of textures placed next to each other.
    u8 num_textures;

    u8 num_components;
};

#endif

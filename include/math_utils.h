#ifndef __MATH_UTILS_H__
#define __MATH_UTILS_H__

#include "type.h"
#include <math.h>

// Utility function to convert degree to radians.
f32 degree_to_radians(const f32 degree)
{
    return degree * (3.14159265f / 180.0f);
}

#endif

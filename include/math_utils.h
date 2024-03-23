#ifndef __MATH_UTILS_H__
#define __MATH_UTILS_H__

#include "type.h"
#include <math.h>

// Utility function to convert degree to radians.
f32 degree_to_radians(const f32 degree)
{
    return degree * (3.14159265f / 180.0f);
}

f32 radians_to_degrees(const f32 radians)
{
    return radians * (180.0f / 3.14159265f);
}

#endif

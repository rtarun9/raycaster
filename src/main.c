#include <stdio.h>
#include <stdlib.h>

#include "../include/type.h"

const u16 NUMBER_OF_COLUMNS = 512;
const u16 NUMBER_OF_ROWS = 512;
const u16 MAXIMUM_PIXEL_VALUE = 255;

// Write contents of framebuffer to a PPM file.
void write_to_file(const u32 *frame_buffer)
{
    FILE *file;
    errno_t err = fopen_s(&file, "output.ppm", "w+");

    if (err != 0)
    {
        printf("Failed to open / create file output.ppm");
        return;
    }

    fprintf(file, "P3\n%u %u\n%u\n", NUMBER_OF_COLUMNS, NUMBER_OF_ROWS, MAXIMUM_PIXEL_VALUE);

    for (u16 i = 0; i < NUMBER_OF_ROWS; i++)
    {
        for (u16 j = 0; j < NUMBER_OF_COLUMNS; j++)
        {
            u32 current_pixel_value = frame_buffer[i * NUMBER_OF_COLUMNS + j];
            fprintf(file, "%u %u %u ", (current_pixel_value >> 16) & 0xff, (current_pixel_value >> 8) & 0xff,
                    current_pixel_value & 0xff);
        }
        fprintf(file, "\n");
    }
    fclose(file);
}

int main()
{
    // PPM image format.
    // P3
    // Number_of_columns Number_of_rows
    // Maximum color value
    // Actual pixel data (RGB)

    // Framebuffer is just a large flattened 1D array.
    // bits 31:26 will be ignored. The other bits will be red (8bits), green  (8bits), blue (8bits).
    u32 *frame_buffer = (u32 *)malloc(sizeof(u32) * NUMBER_OF_COLUMNS * NUMBER_OF_ROWS);

    for (u16 i = 0; i < NUMBER_OF_ROWS; i++)
    {
        for (u16 j = 0; j < NUMBER_OF_COLUMNS; j++)
        {
            const u8 u = (u8)(((f32)i / (NUMBER_OF_ROWS - 1)) * MAXIMUM_PIXEL_VALUE);
            const u32 v = (u32)((float)j / (NUMBER_OF_COLUMNS - 1) * MAXIMUM_PIXEL_VALUE);

            frame_buffer[i * NUMBER_OF_COLUMNS + j] = u << 16 | v << 8;
        }
    }

    write_to_file(frame_buffer);

    free(frame_buffer);

    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "../include/type.h"

// Dimensions of the image / framebuffer.
#define NUMBER_OF_COLUMNS 512
#define NUMBER_OF_ROWS 512
#define MAXIMUM_PIXEL_VALUE 255

// Dimensions of the map.
#define MAP_NUMBER_OF_COLUMNS 16
#define MAP_NUMBER_OF_ROWS 16

// With respect to pixels of image and map grid cells, how many pixels one map entry will represent.
const u8 MAP_CELL_ENTRY_WIDTH = NUMBER_OF_COLUMNS / MAP_NUMBER_OF_COLUMNS;
const u8 MAP_CELL_ENTRY_HEIGHT = NUMBER_OF_ROWS / MAP_NUMBER_OF_ROWS;

// Write contents of framebuffer to a PPM file.
// Returns BOOL_FALSE if function failed to write to PPM file.
bool write_to_file(const u32 *frame_buffer)
{
    FILE *file = NULL;
    errno_t err = fopen_s(&file, "output.ppm", "w+");

    if (err != 0)
    {
        printf("Failed to open / create file output.ppm");
        return BOOL_FALSE;
    }

    // PPM image format.
    // P3
    // Number_of_columns Number_of_rows
    // Maximum color value
    // Actual pixel data (RGB)

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

    return BOOL_TRUE;
}

// A function that takes in the framebuffer, framebuffer coordinates, rectangle color and rectangle width / height
// and draws a rectangle to framebuffer.
void draw_rectangle(u32 *frame_buffer, const u32 color, const u16 x, const u16 y, const u16 rect_width,
                    const u16 rect_height)
{
    for (u16 k = 0; k < rect_height; k++)
    {
        for (u16 v = 0; v < rect_width; v++)
        {
            if (v + rect_width < NUMBER_OF_COLUMNS && k + rect_height < NUMBER_OF_ROWS)
            {
                frame_buffer[(y + k) * NUMBER_OF_COLUMNS + v + x] = color;
            }
        }
    }
}

int main()
{
    // Values of player position x and y.
    const u16 player_x = MAP_NUMBER_OF_COLUMNS / 2;
    const u16 player_y = MAP_NUMBER_OF_ROWS / 2;

    // Rules for the hardcoded game map.
    // Map width and height must be divisible by NUMBER_OF_COLUMNS and NUMBER_OF_ROWS.
    // In this map (1D char array), a 1 is a non-walled zone.
    // 0 entries are walls.
    // A 1 will imply that visually a MAP_CELL_ENTRY_WIDTH x MAP_CELL_ENTRY_HEIGHT area will be non-walled.
    const u8 game_map[MAP_NUMBER_OF_ROWS * MAP_NUMBER_OF_COLUMNS] = "1000000000000000"
                                                                    "0000000000000000"
                                                                    "0000000000000000"
                                                                    "0000000000000000"
                                                                    "0000001111100000"
                                                                    "0000001000000000"
                                                                    "0000001000000000"
                                                                    "0000001000000000"
                                                                    "0001111000000000"
                                                                    "0000000000000000"
                                                                    "0000001111100000"
                                                                    "0000001001100000"
                                                                    "0000000001100000"
                                                                    "0000000001100000"
                                                                    "0000000000000000"
                                                                    "0000000000000001";

    // Framebuffer is just a large flattened 1D array.
    // bits 31:26 will be ignored. The other bits will be red (8bits), green  (8bits), blue (8bits).
    u32 *frame_buffer = (u32 *)malloc(sizeof(u32) * NUMBER_OF_COLUMNS * NUMBER_OF_ROWS);

    for (u16 i = 0; i < NUMBER_OF_ROWS; i++)
    {
        for (u16 j = 0; j < NUMBER_OF_COLUMNS; j++)
        {
            const u8 u = (u8)(((f32)i / (NUMBER_OF_ROWS - 1)) * MAXIMUM_PIXEL_VALUE);
            const u8 v = (u8)((f32)j / (NUMBER_OF_COLUMNS - 1) * MAXIMUM_PIXEL_VALUE);

            frame_buffer[i * NUMBER_OF_COLUMNS + j] = u << 16 | v << 8;
        }
    }

    // Draw rectangles to create the game map.
    for (u16 i = 0; i < MAP_NUMBER_OF_ROWS; i++)
    {
        for (u16 j = 0; j < MAP_NUMBER_OF_COLUMNS; j++)
        {
            // If entry [i][j] of game_map is a 1, write black from i * MAP_CELL_ENTRY_WIDTH to i * MAP_CELL_ENTRY_WIDTH
            // + 1 (and similarly for the height).
            // Now, say in the MAP, (10, 10) is marked with a 1.
            // How will this be mapped onto the framebuffer?
            // The STARTING (i.e top left) pixel of rectangle will be 10 * MAP_CELL_ENTRY_WIDTH and similarly for the
            // other axis.
            if (game_map[i * MAP_NUMBER_OF_COLUMNS + j] == '1')
            {
                draw_rectangle(frame_buffer, 0u, j * MAP_CELL_ENTRY_WIDTH, i * MAP_CELL_ENTRY_HEIGHT,
                               MAP_CELL_ENTRY_WIDTH, MAP_CELL_ENTRY_HEIGHT);
            }
            else if (j == player_x && i == player_y)
            {
                // The player rect is hardcoded to a 2x2 grid.
                draw_rectangle(frame_buffer, 0xffffffff, j * MAP_CELL_ENTRY_WIDTH, i * MAP_CELL_ENTRY_HEIGHT, 8u, 8u);
            }
        }
    }

    if (write_to_file(frame_buffer) == BOOL_FALSE)
    {
        printf("Failed to write output to PPM file.\n");
    }

    free(frame_buffer);

    return 0;
}

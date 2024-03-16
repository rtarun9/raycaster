#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "../include/math_utils.h"
#include "../include/type.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

// Dimensions of the OVERALL framebuffer.
// Note that this includes dimension for both game map and the 3D image (which will be on the right side of game map).
#define FB_NUMBER_OF_COLUMNS 1024
#define FB_NUMBER_OF_ROWS 512

// Dimensions for each IMAGE the framebuffer constitutes.
// This includes a game map on the left, and 3D image on the right.
#define IMAGE_NUMBER_OF_COLUMNS (FB_NUMBER_OF_COLUMNS / 2)
#define IMAGE_NUMBER_OF_ROWS FB_NUMBER_OF_ROWS

#define MAXIMUM_PIXEL_VALUE 255

// Dimensions of the map.
#define MAP_NUMBER_OF_COLUMNS 16
#define MAP_NUMBER_OF_ROWS 16

// With respect to pixels of image and map grid cells, how many pixels one map entry will represent.
#define MAP_CELL_ENTRY_WIDTH (u16)(IMAGE_NUMBER_OF_COLUMNS / MAP_NUMBER_OF_COLUMNS)
#define MAP_CELL_ENTRY_HEIGHT (u16)(IMAGE_NUMBER_OF_ROWS / MAP_NUMBER_OF_ROWS)

// Forward declaration of window procedure.
LRESULT CALLBACK window_proc(HWND window_handle, UINT message, WPARAM wparam, LPARAM lparam);

// A function that takes in the framebuffer, framebuffer coordinates, rectangle color and rectangle width / height
// and draws a rectangle to framebuffer.
// NOTE : For simplicity, this function is to ONLY be used by the left (game map) image, and not for 3D image.
// This is to simplify the boundary checks that are preformed by this function.
void draw_rectangle(u32 *frame_buffer, const u32 color, const u16 x, const u16 y, const u16 rect_width,
                    const u16 rect_height)
{
    for (u16 k = 0; k < rect_height; k++)
    {
        for (u16 v = 0; v < rect_width; v++)
        {
            // Note the horizontal check is done against IMAGE_NUMBER_OF_COLUMNS (so we only draw on left half of FB),
            // But when writing to FB we use FB_NUMBER_OF_COLUMNS to index to FB (to prevent writing to right 3D image).
            if (x + v < IMAGE_NUMBER_OF_COLUMNS && y + k < IMAGE_NUMBER_OF_ROWS)
            {
                frame_buffer[(y + k) * FB_NUMBER_OF_COLUMNS + v + x] = color;
            }
        }
    }
}

int main()
{
    printf("Raycaster Config\nimage_number_of_rows :: %u, image_number_of_columns :: %u\nfb_number_of_rows :: %u, "
           "fb_number_of_columns :: %u\nmap_number_of_rows :: %u, map_number_of_columns :: %u\n",
           IMAGE_NUMBER_OF_ROWS, IMAGE_NUMBER_OF_COLUMNS, FB_NUMBER_OF_ROWS, FB_NUMBER_OF_COLUMNS, MAP_NUMBER_OF_ROWS,
           MAP_NUMBER_OF_COLUMNS);

    // Creation of the win32 window class.
    // Window class acts as a template for multiple windows and defines set of behaviors windows might have in common.
    const char window_class_name[] = "Base Window Class";

    WNDCLASSA window_class = {};
    window_class.lpfnWndProc = window_proc;
    window_class.hInstance = GetModuleHandle(NULL);
    window_class.lpszClassName = window_class_name;

    RegisterClassA(&window_class);

    // Calculate required size of window rectangle based on client rectangle size.
    // Initially it will have client coords, but after AdjustWindowRect it will be the window coords.
    RECT window_rect = {0, 0, FB_NUMBER_OF_COLUMNS, FB_NUMBER_OF_ROWS};
    printf("Client rect right :: %lu, Window rect bottom :: %lu\n", window_rect.right, window_rect.bottom);

    AdjustWindowRect(&window_rect, WS_OVERLAPPEDWINDOW, FALSE);

    printf("Window rect right :: %lu, Window rect bottom :: %lu\n", window_rect.right, window_rect.bottom);

    const HWND window_handle =
        CreateWindowExA(0, window_class_name, "Raycaster", WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT,
                        window_rect.right, window_rect.bottom, NULL, NULL, GetModuleHandle(NULL), NULL);
    if (!window_handle)
    {
        printf("Failed to create win32 window.");
        return 0;
    }

    // Framebuffer is just a large flattened 1D array.
    // bits 31:26 will be ignored. The other bits will be red (8bits), green  (8bits), blue (8bits).
    // Do note that for efficiency purposes the SAME framebuffer will also contain the 3D image on the right of the 2D
    // raycasting & game map image.
    u32 *frame_buffer = (u32 *)malloc(sizeof(u32) * FB_NUMBER_OF_COLUMNS * FB_NUMBER_OF_ROWS);

    ShowWindow(window_handle, SW_SHOW);

    f32 player_angle_in_degrees = 0.0f;

    bool close_window = BOOL_FALSE;
    while (close_window != BOOL_TRUE)
    {
        printf("Begin of frame.\n");

        MSG message = {};
        if (GetMessageA(&message, NULL, 0, 0))
        {
            TranslateMessage(&message);
            DispatchMessageA(&message);
        }

        if (message.message == WM_QUIT)
        {
            close_window = BOOL_TRUE;
        }

        // Color map (For walls).
        const u32 color_map[9] = {0x00000000, 0xffffffff, 0x00ff0000, 0x00f00000, 0x000f0000,
                                  0x0000f000, 0x00000f00, 0x000000f0, 0x0000000f};
        // Values of player position x and y.
        // These values are tied to map coordinates.
        // I.E the range of values for player x and y is 0, map_number_of_rows - 1 and so on.
        const u16 player_x = 6u;
        const u16 player_y = 2u;

        // player_angle is the angle (with respect to the x axis) that the player is looking at.
        const f32 player_angle = degree_to_radians(player_angle_in_degrees);

        // FOV (Field of view)
        // Let the FOV be theta.
        // Then, we consider that the player can see from -0.5f * theta + player_angle, 0.5f * theta + player_angle.
        const f32 player_fov = degree_to_radians(45.0f);

        // Rules for the hardcoded game map. Map width and height must be divisible by NUMBER_OF_COLUMNS and
        // NUMBER_OF_ROWS. In this map (1D char array), a number is a walled zone (the number is a index into color
        // map). Empty entries are non-walls. Number will imply that visually a MAP_CELL_ENTRY_WIDTH x
        // MAP_CELL_ENTRY_HEIGHT area will be non-walled.
        const u8 game_map[MAP_NUMBER_OF_ROWS * MAP_NUMBER_OF_COLUMNS + 1] = "0010000000000000"
                                                                            "1              1"
                                                                            "8      04000   0"
                                                                            "3     0        0"
                                                                            "3     0   000000"
                                                                            "0   00000      0"
                                                                            "0   0   0      0"
                                                                            "0   0   00000  0"
                                                                            "0   0   0      0"
                                                                            "0       0   0000"
                                                                            "0       0      0"
                                                                            "0       0      0"
                                                                            "0  000000      0"
                                                                            "0              0"
                                                                            "0              0"
                                                                            "0000000000000000";

        // Set a background color for entire FB.
        for (u32 i = 0; i < FB_NUMBER_OF_ROWS * FB_NUMBER_OF_COLUMNS; i++)
        {
            frame_buffer[i] = 0x000099cc;
        }

        // Create the game map.
        for (u16 i = 0; i < MAP_NUMBER_OF_ROWS; i++)
        {
            for (u16 j = 0; j < MAP_NUMBER_OF_COLUMNS; j++)
            {
                // If entry [i][j] of game_map is a 0, write black from i * MAP_CELL_ENTRY_WIDTH to i *
                // MAP_CELL_ENTRY_WIDTH
                // + 1 (and similarly for the height).
                const u8 game_map_value = game_map[i * MAP_NUMBER_OF_COLUMNS + j];
                if (game_map_value != ' ')
                {
                    draw_rectangle(frame_buffer, color_map[game_map_value - '0'], j * MAP_CELL_ENTRY_WIDTH,
                                   i * MAP_CELL_ENTRY_HEIGHT, MAP_CELL_ENTRY_WIDTH, MAP_CELL_ENTRY_HEIGHT);
                }
            }
        }

        // player_a : The angle the player is looking at, with respect to the x axis.
        // Consider the following triangle.
        // .............
        //   ...........
        //      ........
        //        ......
        //           ...
        //             .
        // In this right angle triangle, say the top left is player_x, player_y.
        // Now, the angle of top left vertex is player_angle.
        // The player is looking along the hypotenuse. Say 'c' is length of hypotenuse, and the other sides is 1.
        // Now, the vector from top left to bottom right, is basically sum of : player_x -> top right vertex vector +
        // the player_y -> bottom right vector. sin_a = opp / c, so opp (y_component) = sin_a * c . Similarly, adj
        // (x_component) = cos_a * c From player_position, with hypotenuse length as c, the vector that goes from
        // position to look at direction is: (player_x + c * cos_a, player_y + c * sin_a)

        // We will be shooting 512 rays. This is because when drawing the 3D image, the image width will be 512 pixels.
        // In the 3D image, each pixel (horizontally) represents one of these casted rays (which is why we need to cast
        // only 512 rays).

        const f32 angle_increment_to_cast_512_rays = player_fov / 512.0f;
        u16 ray_number = 0u;

        // player coordinates that are tied to image (player_x/y is tied to the map).
        const u16 image_player_x = (player_x * IMAGE_NUMBER_OF_COLUMNS / MAP_NUMBER_OF_COLUMNS);
        const u16 image_player_y = (player_y * IMAGE_NUMBER_OF_ROWS / MAP_NUMBER_OF_ROWS);

        for (f32 angle = -0.5f * player_fov; angle <= 0.5f * player_fov; angle += angle_increment_to_cast_512_rays)
        {
            u16 distance = 0xffff;
            u32 color = 0u;

            for (u16 c = 1u; c < IMAGE_NUMBER_OF_ROWS; c += 1)
            {
                const u16 look_at_x = (u16)(cos(player_angle + angle) * c + image_player_x);
                const u16 look_at_y = (u16)(sin(player_angle + angle) * c + image_player_y);

                // If the 'ray' hits a wall, break out of the loop.
                // For that, conversion from fb coordinate to map coordinate is required.
                const u16 map_look_at_x = (MAP_NUMBER_OF_COLUMNS * look_at_x / IMAGE_NUMBER_OF_COLUMNS);
                const u16 map_look_at_y = (MAP_NUMBER_OF_ROWS * look_at_y / IMAGE_NUMBER_OF_ROWS);

                const u8 game_map_value = game_map[map_look_at_x + map_look_at_y * MAP_NUMBER_OF_COLUMNS];
                if (map_look_at_x < MAP_NUMBER_OF_COLUMNS && map_look_at_y < MAP_NUMBER_OF_ROWS &&
                    game_map_value != ' ')
                {
                    // The distance / 2 is to make sure the walls close to player are not *TOO* big.
                    distance = (u16)(IMAGE_NUMBER_OF_ROWS - c) / 2;
                    color = color_map[game_map_value - '0'];
                    break;
                }

                // for debugging the ray cast (in dotted fashion).
                if (c & 1)
                {
                    draw_rectangle(frame_buffer, 0x00ff0fff, look_at_x, look_at_y, 4u, 4u);
                }
            }

            // Process to create 3D image.
            // Start with the center (vertically) of 3D image.
            // Each of 512 casted rays represent one pixel of 3D image horizontally.
            // When a obstacle has been hit, find the distance to player, find inverse, and move (inverse / 2) pixels up
            // and down from the center of 3D image. The color is the same as the obstacle color.
            for (i16 h = -distance / 2; h < distance / 2; h += 1)
            {
                frame_buffer[((IMAGE_NUMBER_OF_ROWS / 2) + h) * FB_NUMBER_OF_COLUMNS + ray_number +
                             IMAGE_NUMBER_OF_COLUMNS] = color;
            }

            ray_number++;
        }

        // Draw rectangle for player on the image (not the MAP).
        // This is done at the last so debug raycast do not cover player viz.
        draw_rectangle(frame_buffer, 0xffffffff, player_x * MAP_CELL_ENTRY_WIDTH, player_y * MAP_CELL_ENTRY_HEIGHT, 4u,
                       4u);

        const HDC window_device_context = GetDC(window_handle);
        for (u16 i = 0; i < FB_NUMBER_OF_ROWS; i++)
        {
            for (u16 j = 0; j < FB_NUMBER_OF_COLUMNS; j++)
            {
                const u32 pixel_value = frame_buffer[i * FB_NUMBER_OF_COLUMNS + j];
                SetPixel(window_device_context, j, i,
                         RGB(pixel_value >> 16 & 0xff, pixel_value >> 8 & 0xff, pixel_value & 0xff));
            }
        }

        player_angle_in_degrees += 15.0f;
        printf("End of frame.\n");
    }

    free(frame_buffer);

    return 0;
}

LRESULT CALLBACK window_proc(HWND window_handle, UINT message, WPARAM wparam, LPARAM lparam)
{
    switch (message)
    {
    case WM_KEYDOWN:
        if (wparam == VK_ESCAPE)
        {
            PostQuitMessage(0);
        }
        break;

    case WM_CLOSE:
        DestroyWindow(window_handle);
        break;
    default:
        return DefWindowProcA(window_handle, message, wparam, lparam);
    }
    return 0;
}

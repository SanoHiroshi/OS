#include <stdio.h>

void io_hlt(void);
void io_cli(void);
void io_out8(int port, int data);
int io_load_eflags(void);
void io_store_eflags(int eflags);

// 同じソースファイルでも、定義する前に使うなら、あらかじめ宣言しておかないといけない
void init_palette(void);
void set_palette(int start, int end, unsigned char *rgb);
void bookfill8(unsigned char *vram, int xsize, unsigned char c, int x0, int y0, int x1, int y1);
void init_screen(char *vram, int x, int y);
void putfont8(char *vram, int xsize, int x, int y, char c, char *font);
void putfont8_asc(char *vram, int xsize, int x, int y, char c, char *s);

void init_mouse_cursor8(char *mouse, char bc);
void putblock8_8(char *vram, int vxsize, int pxsize, int pysize, int px0, int py0, char *buf, int bxsize);

// 色の定義
#define COL8_000000 0
#define COL8_FF0000 1
#define COL8_00FF00 2
#define COL8_FFFF00 3
#define COL8_00FFFF 4
#define COL8_0000FF 5
#define COL8_FF00FF 6
#define COL8_FFFFFF 7
#define COL8_C6C6C6 8
#define COL8_840000 9
#define COL8_008400 10
#define COL8_848400 11
#define COL8_000084 12
#define COL8_840084 13
#define COL8_008484 14
#define COL8_848484 15

struct BOOTINFO{
  char cyls, leds, vmode, reserve;
  short scrnx, scrny;
  char *vram;
};

void HariMain(void)
{
  struct BOOTINFO *binfo = (struct BOOTINFO *) 0x0ff0;
  char s[40], mcursor[256];
  int mx, my;

  init_palette(); // パレットの設定（画面の色を設定すること）
  init_screen(binfo->vram, binfo->scrnx, binfo->scrny); // 画面の初期化処理
  // putfont8_asc(binfo->vram, binfo->scrnx, 8, 8, COL8_FFFFFF, "Welcome to"); // 文字を画面に書く
  // putfont8_asc(binfo->vram, binfo->scrnx, 31, 31, COL8_FFFFFF, "Sano First OS"); // 文字を画面に書く
  // putfont8_asc(binfo->vram, binfo->scrnx, 30, 30, COL8_FFFFFF, "Sano First OS"); // 文字を画面に書く
  mx = (binfo->scrnx - 16) / 2;
  my = (binfo->scrny - 28 - 16) / 2;
  sprintf(s, "(%d, %d)", mx, my);
  putfont8_asc(binfo->vram, binfo->scrnx, 16, 64, COL8_FFFFFF, s);

  init_mouse_cursor8(mcursor, COL8_008484);
  putblock8_8(binfo->vram, binfo->scrnx, 16, 16, mx, my, mcursor, 16);

  for (;;) { // 条件を省略したら無限ループ
    io_hlt(); // CPUを停止させて、省電力にする命令
  }

}

void init_palette()
{
  static unsigned char table_rgb[16 * 3] = {
    0x00, 0x00, 0x00, // 0: 黒
    0xff, 0x00, 0x00, // 1:明るい赤
    0x00, 0xff, 0x00, // 2:明るい緑
    0xff, 0xff, 0x00, // 3:明るい黄色
    0x00, 0x00, 0xff, // 4:明るい青
    0xff, 0x00, 0xff, // 5:明るい紫
    0x00, 0xff, 0xff, // 6:明るい水色
    0xff, 0xff, 0xff, // 7:白
    0xc6, 0xc6, 0xc6, // 8:明るい灰色
    0x84, 0x00, 0x00, // 9:暗い赤
    0x00, 0x84, 0x00, // 10:暗い緑
    0x84, 0x84, 0x00, // 12:暗い黄色
    0x00, 0x00, 0x84, // 11:暗い青
    0x84, 0x00, 0x84, // 13:暗い紫
    0x00, 0x84, 0x84, // 14:暗い水色
    0x84, 0x84, 0x84, // 15:暗い灰色
  };
  set_palette(0, 15, table_rgb);
  return;

  // static char 命令はデータにしか使えないけどDB命令相当
}

void init_screen(char *vram, int x, int y)
{
  bookfill8(vram, x, COL8_008484, 0, 0, x - 1, y - 29); //画面の色を1pxずつ塗っていく
  bookfill8(vram, x, COL8_C6C6C6, 0, y - 28, x - 1, y - 28);
  bookfill8(vram, x, COL8_FFFFFF, 0, y - 27, x - 1, y - 27);
  bookfill8(vram, x, COL8_C6C6C6, 0, y - 26, x - 1, y - 1);

  bookfill8(vram, x, COL8_FFFFFF, 3, y - 24, 59, y - 24);
  bookfill8(vram, x, COL8_FFFFFF, 2, y - 24, 2, y - 4);
  bookfill8(vram, x, COL8_848484, 3, y - 4, 59, y - 4);
  bookfill8(vram, x, COL8_848484, 59, y - 23, 59, y - 5);
  bookfill8(vram, x, COL8_000000, 2, y - 3, 59, y - 3);
  bookfill8(vram, x, COL8_000000, 60, y - 24, 60, y - 3);

  bookfill8(vram, x, COL8_848484, x - 47, y - 24, x - 4, y - 24);
  bookfill8(vram, x, COL8_848484, x - 47, y - 23, x - 47, y - 4);
  bookfill8(vram, x, COL8_FFFFFF, x - 47, y - 3, x - 4, y - 3);
  bookfill8(vram, x, COL8_FFFFFF, x - 3, y - 24, x - 3, y - 3);

  return;
}

void bookfill8(unsigned char *vram, int xsize, unsigned char c, int x0, int y0, int x1, int y1)
{
  int x, y;
  for (y = y0; y <= y1; y++){
    for (x = x0; x <= x1; x++){
      vram[y * xsize + x] = c;
    }
  }
  return;
}

void putfont8(char *vram, int xsize, int x, int y, char c, char *font)
{
  int i;
  char *p, d; // data
  for (i = 0; i < 16; i++){
    p = vram + (y + i) * xsize + x;
    d = font[i];
    if ((d & 0x80) != 0){ p[0] = c; }
    if ((d & 0x40) != 0){ p[1] = c; }
    if ((d & 0x20) != 0){ p[2] = c; }
    if ((d & 0x10) != 0){ p[3] = c; }
    if ((d & 0x08) != 0){ p[4] = c; }
    if ((d & 0x04) != 0){ p[5] = c; }
    if ((d & 0x02) != 0){ p[6] = c; }
    if ((d & 0x01) != 0){ p[7] = c; }
  }
  return;
}

void putfont8_asc(char *vram, int xsize, int x, int y, char c, char *s)
{
  extern char hankaku[4096];

  for (; *s != 0x00; s++)
  {
    putfont8(vram, xsize, x , y, c, hankaku + *s * 16);
    x += 8;
  }
  return;
}
void set_palette(int start, int end, unsigned char *rgb)
{
  int i, eflags;
  eflags = io_load_eflags(); // 割り込み許可フラグの値を記録する
  io_cli();
  io_out8(0x03c8, start);
  for (i = start; i <= end; ++i){
    io_out8(0x03c9, rgb[0] / 4);
    io_out8(0x03c9, rgb[1] / 4);
    io_out8(0x03c9, rgb[2] / 4);
    rgb += 3;
  }
  io_store_eflags(eflags); // 割り込み許可を元に戻す
  return;
}

void init_mouse_cursor8(char *mouse, char bc)
{
  static char cursor[16][16] = {
    "**************..",
    "*oooooooooooo*..",
    "*ooooooooooo*...",
    "*oooooooooo*....",
    "*ooooooooo*.....",
    "*oooooooo*......",
    "*oooooooo*......",
    "*ooooooooo*.....",
    "*oooo**oooo*....",
    "*ooo*..*ooo*....",
    "*oo*....*ooo*...",
    "*o*......*ooo*..",
    "**........*ooo*.",
    "*..........*ooo*",
    "............*oo*",
    ".............***",
  };
  int x, y;

  for (y = 0; y < 16; y++)
  {
    for (x = 0; x < 16; x++)
    {
      if (cursor[y][x] == '*')
      {
        mouse[y * 16 + x] = COL8_000000;
      }
      if (cursor[y][x] == 'o')
      {
        mouse[y * 16 + x] = COL8_FFFFFF;
      }
      if (cursor[y][x] == '.')
      {
        mouse[y * 16 + x] = bc;
      }
    }
  }
  return;
}

void putblock8_8(char *vram, int vxsize, int pxsize, int pysize, int px0, int py0, char *buf, int bxsize)
{
  int x, y;
  for (y = 0; y < pysize; y++)
  {
    for (x = 0; x < pxsize; x++)
    {
      vram[(py0 + y) * vxsize + (px0 + x)] = buf[y * bxsize + x];
    }
  }
  return;
}


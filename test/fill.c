// gcc -W -Wall -Wextra fill.c
// http://zh.scribd.com/doc/58438410/Color-Bars
// vlc --demux=rawvideo --rawvid-width=512 --rawvid-height=512 --rawvid-chroma=I420 --rawvid-fps=0.1 image.raw
#include <stdint.h>
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

struct color
{
   uint8_t y;
   uint8_t u;
   uint8_t v;
};

struct color color_list [] =
{
  {235,128,128},
  {210,16,146},
  {170,166,16},
  {145,54,34},
  {107,202,221},
  {82,90,240},
  {41,240,110},
  {16,128,128}
};

int main(void)
{
	int w = 512;
	int h = 512;
	int i,j,k;
	char* pbuf;
	char* py;
	char* pu;
	char* pv;
	FILE* fp;
	int sz = w*h*3/2;
	int n;

	pbuf = malloc(sz);
	assert(pbuf);

	for(i=0; i<h; i++)
	{
		py = pbuf + i * w;

		for(j=0; j<8; j++)
		{

			for(k=0; k<w/8; k++)
			{
				*py = color_list[j].y;
				++ py;
			}
		}

	}

	pu = pbuf + w * h;
	pv = pbuf + w * h * 5 / 4;

	for(i=0; i<h/2; i++)
	{

		for(j=0; j<8; j++)
		{

			for(k=0; k<w/8/2; k++)
			{
				*pu = color_list[j].u;
				++ pu;

				*pv = color_list[j].v;
				++ pv;
			}
		}

	}

	fp = fopen("image.raw", "wb");
	assert(fp);

	n = fwrite(pbuf, 1, sz, fp);
	assert(n == sz);
	fclose(fp);

	free(pbuf);

	return 0;
}

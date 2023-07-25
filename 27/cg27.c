#include<stdio.h>
#include<stddef.h>
unsigned entry(unsigned *const terrain, size_t len) {
	unsigned max = 0;
	for (size_t i = 0; i < len; i++) max = max > terrain[i] ? max : terrain[i];
	char barplot[(len+1)*max+1];
	for (size_t i = 0; i < max; i++) {
		for (size_t j = 0; j < len+1; j++) {
			if (i < terrain[j]) {
				barplot[i*len+j] = '#';
			} else {
				barplot[i*len+j] = ' ';
			}
			printf("%c",barplot[i*len+j]);
		}
		printf("%c",barplot[i*len+len+1]);
		barplot[i*len+len+1] = '\n';
		puts("");
	}
	puts("final:");
	puts(barplot);
	return 0;
}

int main() {
	unsigned a[12] = {0,1,0,2,1,0,1,3,2,1,2,1};
	printf("%u\n",entry(a,12));
	return 0;
}

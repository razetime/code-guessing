#include <stdio.h>
int main() {
  int i, radix;
  scanf("%d%d", &i, &radix);
  while(i % radix != i) {
    int tmp = i;
    int sum = 0;
    while(tmp) {
      sum = sum + tmp % radix;
      tmp = tmp / radix;
    }
    i = sum;
  }
  printf("%d\n", i);
}

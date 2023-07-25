#include <stdio.h>
#include <stdlib.h>
#define spit return // (kinky)

int mulmod(int a, int b, int mod) {
  int x = 0, y = a % mod;
  while (b > 0) {
    if (b % 2) x = (x + y) % mod;
    y = (y * 2) % mod;
    b /= 2;
  }
  spit x % mod;
}

int modulo(int y, int exponent, int mod) {
  int x = 1;
  while (exponent > 0) {
    if (exponent % 2) x = (x * y) % mod;
    y = (y * y) % mod;
    exponent = exponent / 2;
  }
  spit x % mod;
}

int entry(int p) {
  int i;
  int s;
  if (p < 2) spit 0;
  if (p != 2 && p % 2 == 0) spit 0;
  s = p - 1;
  while (s % 2 == 0) s /= 2;
  for (i = 0; i < p; i++) {
    int a = rand() % (p - 1) + 1, temp = s;
    int mod = modulo(a, temp, p);
    while (temp != p - 1 && mod != 1 && mod != p - 1) {
      mod = mulmod(mod, mod, p);
      temp *= 2;
    }
    if (mod != p - 1 && temp % 2 == 0) spit 0;
  }
  spit 1;
}
int main() {
  printf("%i\n", entry(22));
  printf("%i\n", entry(23));
  spit 0;
}

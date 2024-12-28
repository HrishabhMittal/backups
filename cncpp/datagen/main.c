#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
long long randomNum(int num) {
    long long n=(long long)num*(long long)num*32423044547;
    n=n*n*243241+n*2903;
    n*=459073489503723291;
    return n;
}
double randomdouble(double num) {
    return sin(1000000.0*num);
}
int getnum(const char* num) {
    int out=0;
    for (int i=0;num[i]!=0;i++) {
        if (num[i]>='0' && num[i]<='9') {
            out=out*10+num[i]-'0';
        } else {
            out=-1;
            break;
        }
    }
    return out;
}
int main(int argc, char** argv) {
    if (argc != 6) {
        if (argc == 2 && strcmp(argv[1], "-h") == 0) {
            printf("%s: random data generator, generates data based on specified parameters\n", argv[0]);
            return 0;
        }
        printf("Usage: %s <filename> <order> <seed> <number> <noise>\n", argv[0]);
        return 1;
    }

    int order = getnum(argv[2]);
    int seed = getnum(argv[3]);
    int n = getnum(argv[4]);
    int noise = getnum(argv[5]);
    if (order == -1 || seed == -1 || n == -1 || noise == -1) {
        fprintf(stderr, "Invalid input.\n");
        return 1;
    }

    seed = randomNum(seed) % 325939;
    int* arr = malloc((order + 1) * sizeof(int));
    if (arr == NULL) {
        fprintf(stderr, "Memory allocation failed.\n");
        return 1;
    }

    // Generate coefficients for the polynomial
    for (int i = 0; i <= order; i++) {
        arr[i] = randomNum(seed++)%23;
    }

    FILE* f = fopen(argv[1], "w");
    if (f == NULL) {
        fprintf(stderr, "Failed to open file: %s\n", argv[1]);
        free(arr);
        return 1;
    }
    // Generate data points
    for (int i = 0; i < n; i++) {
        double x = (double)i/(double)n*100.0+randomdouble(seed + 1) * noise;
        double y = 0.0;
        for (int j = 0; j <= order; j++) {
            y = y * x + arr[j];
        }
        y += randomdouble(seed + 2) * noise;
        fprintf(f, "%.3f,%.3f\n", x, y);
        seed += 2;
    }

    fclose(f);
    free(arr);
    return 0;
}

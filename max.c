#include <limits.h>

int items[] = { 17, 199, 253, 172, 193, 0 };

int main(void)
{
    int max = INT_MIN;
    for (int i = 0; items[i] != 0; ++i)
        if (items[i] > max)
            max = items[i];
    return max;
}

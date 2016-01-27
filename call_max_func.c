// link with max_abi.o

const int vals[] = { 17, 199, 253, 172, 193, 0 };

extern int max(const int *vals);

int main(void)
{
    return max(vals);
}

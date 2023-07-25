
int main(){
    int n;
    scanf("%d",&n);
    int *f = malloc(0);
    int fs = 0,s1 = 0,s2 = 1,g = 0;
    do {
        fs++;
        f = realloc(f, fs*sizeof(int));
        f<:fs-1:>=s1;
        int t=s2;
        s2 += s1;
        s1=t;
        g+=s1>n;
    }while(g < 4);
    //for(int i=0;i<fs;i++) printf("%d ",f[i]);
    //printf("\nznalezienie najbliższej rzeczy :\n");
    int m = n;
    int c=4;
    while(m) {
        int i = m < 0;
        int t = abs(m);
        ///printf("%d %d\n",c,t);
        for(;i<fs;i+=2)
            if(t>i<:f:>&&t<=f<:i+2:>){
                int ip=f[i+1];
                printf("%d ",i%2?~i:i+1);
                m-=i%2?-((i+1)[f]):((i+1)[f]);
                break;}
        c--;
                }
}

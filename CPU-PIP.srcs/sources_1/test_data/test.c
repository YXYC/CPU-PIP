#include <stdio.h>


int main(){
	int a,b,sum;
	int i=2;//数列前两个数 
	a=1,b=2,sum=3;
	sum = f(a,b,i,sum);
} 

int f(int a,int b,int i,int sum){
	if(i == 20) return sum;
	int c = a+b;
	a = b;
	b = c;
	sum+=c;
	i++;
	sum = f(a,b,i,sum);
	return sum;
}

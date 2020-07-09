#include <stdio.h>
#include <string.h>

extern int rarea(int, int);
extern int rcircum(int, int);
extern double carea(double);
extern double ccircum(double);
extern void sreverse(char *, int);
extern void adouble(double [], int);
extern double asum(double [], int);

int main(int argc, char *argv[])
{
    char rstring[64];
    int side1, side2, r_area, r_circum;
    double radius, c_area, c_circum;
    double darray[] = {70.0, 83.2, 91.5, 72.1, 55.5};
    long int len;
    double sum;

    // call asm func with int args

    printf("Compute area and circumference of a rectangle.\n");
    printf("Enter length of one side: \n");
    scanf("%d", &side1);
    printf("Enter length of other side :\n");
    scanf("%d", &side2);

    r_area = rarea(side1, side2);
    r_circum = rcircum(side1, side2);

    printf("The area of the rectangle = %d\n", r_area);
    printf("The circumference of the rectangle = %d\n\n", r_circum);

    // call an asm func with double (float) arg
    printf("Compute area and circumference of a circle.\n");
    printf("Enter the radius: \n");
    scanf("%lf", &radius);

#if 0
    c_area = carea(radius);
    c_circum = ccircum(radius);
    printf("The area of the circle = %lf\n", c_area);
    printf("The circumference of the circle = %lf\n\n", c_circum);
#endif

    // call asm func with string arg
    printf("Reverse a string.\n");
    printf("Enter the string: \n");
    scanf("%s", rstring);
    printf("The string is = %s\n", rstring);
    sreverse(rstring, strlen(rstring));
    printf("The reversed string = %s\n", rstring);

    // call asm func with array arg
    printf("Some array manipulations\n");
    len = sizeof (darray) / sizeof (double);

    printf("The array has %lu elements\n", len);
    printf("The elements of the array are: \n");
    for (int i = 0; i < len; i++) {
        printf("Element %d = %lf\n", i, darray[i]);    
    }

    sum = asum(darray, len);
    printf("The sum of the elements of this array = %lf\n", sum);

    adouble(darray, len);
    printf("The elements of the doubled array are: \n");
    for (int i = 0; i < len; i++) {
        printf("Element %d = %lf\n", i, darray[i]);
    }

    sum = asum(darray, len);
    printf("The sum of the elements of this doubled array = %lf\n", sum);

    return 0;
}

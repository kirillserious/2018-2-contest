#include <mex.h>
#include <complex.h>

void
mexFunction (int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    /* Проверка количества входных параметров */
    if (nrhs > 3) mexErrMsgTxt("Too many input arguments");
    if (nrhs < 3) mexErrMsgTxt("Too few input arguments");

    const mxArray *matrix_a = prhs[0];    // Матрица А
    const mxArray *matrix_b = prhs[1];    // Матрица В
    const mxArray *matrix_c = prhs[2];    // Матрица С

    /* Проверка, что входные параметры - действительные или комплексные матрицы */
    if( !mxIsDouble(matrix_a) && !mxIsComplex(matrix_a))
        mexErrMsgTxt("A must be a real or complex matrix");
    if( !mxIsDouble(matrix_b) && !mxIsComplex(matrix_b))
        mexErrMsgTxt("B must be a real or complex matrix");
    if( !mxIsDouble(matrix_c) && !mxIsComplex(matrix_c))
        mexErrMsgTxt("C must be a real or complex matrix");

    int m = mxGetM(matrix_a);   // Число строк матрицы А
    int n = mxGetN(matrix_a);   // Число столбцов матрицы А

    /* Проверка совпадения размерностей */
    if  (  (mxGetM(matrix_b) != m)
        || (mxGetN(matrix_b) != n) 
        || (mxGetM(matrix_c) != m)
        || (mxGetN(matrix_c) != n)  )
        mexErrMsgTxt("A, B, C must be same size");

    /* Cоздание матриц результата */
    if ((nlhs < 2) || (nlhs > 3))
        mexErrMsgTxt("Incorrect count of output arguments");
    
    /* Получение вещественной и мнимой частей матрицы */
    double *a_re  = mxGetPr(matrix_a);
    double *a_im  = mxGetPi(matrix_a);
    double *b_re  = mxGetPr(matrix_b);
    double *b_im  = mxGetPi(matrix_b);
    double *c_re  = mxGetPr(matrix_c);
    double *c_im  = mxGetPi(matrix_c);

    /* Если мнимой части нет */
    if (!a_im) a_im = mxCalloc(n*m, sizeof(double));
    if (!b_im) b_im = mxCalloc(n*m, sizeof(double));
    if (!c_im) c_im = mxCalloc(n*m, sizeof(double));

    /* Выделение памяти под результат */
    double *x1_re = mxMalloc(n*m*sizeof(double));
    double *x1_im = mxMalloc(n*m*sizeof(double));
    double *x2_re = mxMalloc(n*m*sizeof(double));
    double *x2_im = mxMalloc(n*m*sizeof(double));
    double *d_re  = mxMalloc(n*m*sizeof(double));
    double *d_im  = mxMalloc(n*m*sizeof(double));

    /* Алгоритм */
    for (int i = 0; i < n*m; ++i) {
        double complex A = a_re[i] + a_im[i] * I;
        double complex B = b_re[i] + b_im[i] * I;
        double complex C = c_re[i] + b_im[i] * I;

        double complex D  = B*B - 4*A*C;
        double complex X1 = (-B - csqrt(D))/(2*A);
        double complex X2 = (-B + csqrt(D))/(2*A);

        d_re[i]  = creal(D);
        d_im[i]  = cimag(D);
        x1_re[i] = creal(X1);
        x1_im[i] = cimag(X1);
        x2_re[i] = creal(X2);
        x2_im[i] = cimag(X2);        
    }

    /* Запись рзультата */
    plhs[0] = mxCreateDoubleMatrix(m, n, mxCOMPLEX);
    plhs[1] = mxCreateDoubleMatrix(m, n, mxCOMPLEX);
    mxSetPr(plhs[0], x1_re);
    mxSetPi(plhs[0], x1_im);
    mxSetPr(plhs[1], x2_re);
    mxSetPi(plhs[1], x2_im);

    if (nlhs == 3) {
        plhs[2] = mxCreateDoubleMatrix(m, n, mxCOMPLEX);
        mxSetPr(plhs[2], d_re);
        mxSetPi(plhs[2], d_im);
    } else {
        mxFree(d_re);
        mxFree(d_im);
    }

}
#include <mex.h>
#include <complex.h>

double complex *
inv (double complex *inputMatrix, int size);

void
mexFunction (int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    /* Проверка количества входных и выходных параметров */
    if (nrhs != 1) mexErrMsgTxt("Incorrect amount of input arguments.");
    if (nlhs != 1) mexErrMsgTxt("Incorrect amount of output values.");

    /* Проверка, что входной параметр - вещественная или комплексная матрица */
    const mxArray *inputMatrix = prhs[0];
    if (!mxIsDouble(inputMatrix) && !mxIsComplex(inputMatrix))
        mexErrMsgTxt("Input argument must be a float or complex matrix.");

    /* Проверка на совпадение размерностей */
    int m = mxGetM(inputMatrix);    // Число строк матрицы
    int n = mxGetN(inputMatrix);    // Число столбцов матрицы
    if (m != n) mexErrMsgTxt("Matrix dimentions must be equal.");

    /* Перевод inputMatrix в комплекную матрицу */
    double complex *inputCopiedMatrix = mxMalloc(m*m*sizeof(double complex));
    if (mxIsDouble(inputMatrix)) {
        /* Если матрица inputMatrix - вещественная */
        double *inputReMatrix = mxGetPr(inputMatrix);
        for (int i = 0; i < m*m; ++i)
            inputCopiedMatrix[i] = inputReMatrix[i];
    } else {
        /* Если - комплексная */
        double *inputReMatrix = mxGetPr(inputMatrix);
        double *inputImMatrix = mxGetPi(inputMatrix);
        for (int i = 0; i < m*m; ++i) {
            inputCopiedMatrix[i] = inputReMatrix[i] + I * inputImMatrix[i];
        }
    }

    double complex *invMatrix = inv(inputCopiedMatrix, m);
    mxFree(inputCopiedMatrix);

    double *invReMatrix = mxMalloc(m*m*sizeof(double));
    double *invImMatrix = mxMalloc(m*m*sizeof(double));
    int isComplex = 0;
    double EPS = mxGetEps();
    for (int i = 0; i < m*m; ++i) {
        if ( cimag(invMatrix[i]) > EPS ) isComplex = 1;

        invReMatrix[i] = creal(invMatrix[i]);
        invImMatrix[i] = cimag(invMatrix[i]);
    }
    mxFree(invMatrix);

    if (isComplex) {
        plhs[0] = mxCreateDoubleMatrix(m,m, mxCOMPLEX);
        mxSetPr(plhs[0], invReMatrix);
        mxSetPi(plhs[0], invImMatrix);
    } else {
        plhs[0] = mxCreateDoubleMatrix(m, m, mxREAL);
        mxSetPr(plhs[0], invReMatrix);
        mxFree(invImMatrix);
    }
}

double complex *
inv (double complex *inputMatrix, int size)
{
    /* Формируем единичную матрицу */
    double complex *invMatrix = mxCalloc(size*size, sizeof(double complex));
    for (int i = 0; i < size; ++i)
        invMatrix[i*size + i] = 1;

    /* Прямой ход метода Гаусса */
    double EPS = mxGetEps();
    for (int i = 0; i < size; ++i) {
        /* В случае нулевого элемента меняем строки местами*/
        if (cabs(inputMatrix[i*size + i]) < EPS) {
            /* Ищем максимальный ненулевой элемент */
            double complex maxElement = inputMatrix[i*size + i];
            int maxIndex = i;
            for (int j = i + 1; j < size; ++j) {
                if (cabs(inputMatrix[j*size + i]) > cabs(maxElement)){
                    maxElement = inputMatrix[j*size + i];
                    maxIndex = j;
                }
            }
            /* Если максимальный элемент тоже нулевой, то определитель - ноль */
            if (cabs(maxElement) < EPS) mexErrMsgTxt("Determenant of matrix is zero.");
            /* В противном случае, переставляем i и maxIndex строки местами */
            for (int j = i; j < size; ++j) {
                double complex tmpElement = inputMatrix[i*size + j];
                inputMatrix[i*size + j] = inputMatrix[maxIndex*size + j];
                inputMatrix[maxIndex*size + j] = tmpElement;
            }
            for (int j = 0; j < size; ++j) {
                double complex tmpElement = invMatrix[i*size + j];
                invMatrix[i*size + j] = invMatrix[maxIndex*size + j];
                invMatrix[maxIndex*size + j] = tmpElement;
            }
        }
        /* Делим i строку на первый элемент */
        for (int j = i + 1; j < size; ++j)
            inputMatrix[i*size + j] = inputMatrix[i*size + j] / inputMatrix[i*size + i];
        for (int j = 0; j < size; ++j)
            invMatrix[i*size + j] = invMatrix[i*size + j] / inputMatrix[i*size + i];
        inputMatrix[i*size + i] = 1;
        /* Вычитаем  строки */
        for (int j = i + 1; j < size; ++j) {
            /* Если первый элемент ноль */
            if (cabs(inputMatrix[j*size + i]) < EPS) continue;

            /* В противном случае */
            double complex subElement = inputMatrix[j*size + i];

            for (int k = i+1; k < size; ++k)
                inputMatrix[j*size + k] = inputMatrix[j*size + k] - subElement * inputMatrix[i*size + k];
            for (int k = 0; k < size; ++k)
                invMatrix[j*size + k] = invMatrix[j*size + k] - subElement * invMatrix[i*size + k];
            inputMatrix[j*size + i] = 0;
        }

    }
    /* Обратный ход метода Гаусса */
    for (int i = size-1; i > 0; --i) {
        for (int j = i - 1; j >= 0; --j) {
            double complex subElement = inputMatrix[j*size + i];
            for (int k = 0; k < size; ++k)
                invMatrix[j*size + k] = invMatrix[j*size + k] - subElement * invMatrix[i*size + k];
        }
    }

    return invMatrix;
}
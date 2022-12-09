void Math_RotateVector(const float vector[VECTOR_SIZE], const float degAngles[VECTOR_SIZE], float result[VECTOR_SIZE]) {
    float radAngles[VECTOR_SIZE];
    float rotationMatrix[VECTOR_SIZE][VECTOR_SIZE];

    Math_DegreesToRadiansVector(degAngles, radAngles);
    Math_GetRotationMatrix(radAngles, rotationMatrix);
    Math_MultiplyMatrixByVector(rotationMatrix, vector, result);
}

void Math_DegreesToRadiansVector(const float degAngles[VECTOR_SIZE], float radAngles[VECTOR_SIZE]) {
    radAngles[PITCH] = DegToRad(degAngles[PITCH]);
    radAngles[YAW] = DegToRad(degAngles[YAW]);
    radAngles[ROLL] = DegToRad(degAngles[ROLL]);
}

void Math_GetRotationMatrix(const float angles[VECTOR_SIZE], float rotationMat[VECTOR_SIZE][VECTOR_SIZE]) {
    float cosBeta = Cosine(angles[PITCH]);
    float sinBeta = Sine(angles[PITCH]);
    float cosAlpha = Cosine(angles[YAW]);
    float sinAlpha = Sine(angles[YAW]);
    float cosGamma = Cosine(angles[ROLL]);
    float sinGamma = Sine(angles[ROLL]);

    rotationMat[0][0] = cosAlpha * cosBeta;
    rotationMat[0][1] = cosAlpha * sinBeta * sinGamma - sinAlpha * cosGamma;
    rotationMat[0][2] = cosAlpha * sinBeta * cosGamma + sinAlpha * sinGamma;
    rotationMat[1][0] = sinAlpha * cosBeta;
    rotationMat[1][1] = sinAlpha * sinBeta * sinGamma + cosAlpha * cosGamma;
    rotationMat[1][2] = sinAlpha * sinBeta * cosGamma - cosAlpha * sinGamma;
    rotationMat[2][0] = -sinBeta;
    rotationMat[2][1] = cosBeta * sinGamma;
    rotationMat[2][2] = cosBeta * cosGamma;
}

void Math_MultiplyMatrixByVector(const float mat[VECTOR_SIZE][VECTOR_SIZE], const float vec[VECTOR_SIZE], float result[VECTOR_SIZE]) {
    for (int i = 0; i < VECTOR_SIZE; i++) {
        result[i] = 0.0;

        for (int j = 0; j < VECTOR_SIZE; j++) {
            result[i] += mat[i][j] * vec[j];
        }
    }
}

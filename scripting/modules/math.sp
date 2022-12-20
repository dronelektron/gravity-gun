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
}

void Math_GetRotationMatrix(const float angles[VECTOR_SIZE], float matrix[VECTOR_SIZE][VECTOR_SIZE]) {
    float cosBeta = Cosine(angles[PITCH]);
    float sinBeta = Sine(angles[PITCH]);
    float cosAlpha = Cosine(angles[YAW]);
    float sinAlpha = Sine(angles[YAW]);

    matrix[0][0] = cosAlpha * cosBeta;
    matrix[0][1] = cosAlpha * sinBeta - sinAlpha;
    matrix[0][2] = cosAlpha * sinBeta + sinAlpha;
    matrix[1][0] = sinAlpha * cosBeta;
    matrix[1][1] = sinAlpha * sinBeta + cosAlpha;
    matrix[1][2] = sinAlpha * sinBeta - cosAlpha;
    matrix[2][0] = -sinBeta;
    matrix[2][1] = cosBeta;
    matrix[2][2] = cosBeta;
}

void Math_MultiplyMatrixByVector(const float matrix[VECTOR_SIZE][VECTOR_SIZE], const float vector[VECTOR_SIZE], float result[VECTOR_SIZE]) {
    for (int i = 0; i < VECTOR_SIZE; i++) {
        result[i] = 0.0;

        for (int j = 0; j < VECTOR_SIZE; j++) {
            result[i] += matrix[i][j] * vector[j];
        }
    }
}

void Math_RotateVector(const float vector[VECTOR_SIZE], float pitchDeg, float yawDeg, float result[VECTOR_SIZE]) {
    float rotationMatrix[VECTOR_SIZE][VECTOR_SIZE];
    float pitchRad = DegToRad(pitchDeg);
    float yawRad = DegToRad(yawDeg);

    Math_GetRotationMatrix(pitchRad, yawRad, rotationMatrix);
    Math_MultiplyMatrixByVector(rotationMatrix, vector, result);
}

void Math_GetRotationMatrix(float pitchRad, float yawRad, float matrix[VECTOR_SIZE][VECTOR_SIZE]) {
    float cosBeta = Cosine(pitchRad);
    float sinBeta = Sine(pitchRad);
    float cosAlpha = Cosine(yawRad);
    float sinAlpha = Sine(yawRad);

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

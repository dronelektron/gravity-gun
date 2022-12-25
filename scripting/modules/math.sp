void Math_CalculateVelocityToDestination(int client, int target, float distance, float speedFactor, float velocity[VECTOR_SIZE]) {
    float clientEyePosition[VECTOR_SIZE];
    float clientEyeAngles[VECTOR_SIZE];
    float clientDirection[VECTOR_SIZE];
    float targetPosition[VECTOR_SIZE];
    float targetDestination[VECTOR_SIZE];

    GetClientEyePosition(client, clientEyePosition);
    GetClientEyeAngles(client, clientEyeAngles);
    GetClientAbsOrigin(target, targetPosition);
    GetAngleVectors(clientEyeAngles, clientDirection, NULL_VECTOR, NULL_VECTOR);
    ScaleVector(clientDirection, distance);
    AddVectors(clientEyePosition, clientDirection, targetDestination);
    SubtractVectors(targetDestination, targetPosition, velocity);
    ScaleVector(velocity, speedFactor);
}

void Math_CalculateThrowDirection(int client, float speed, float direction[VECTOR_SIZE]) {
    float eyeAngles[VECTOR_SIZE];

    GetClientEyeAngles(client, eyeAngles);
    GetAngleVectors(eyeAngles, direction, NULL_VECTOR, NULL_VECTOR);
    ScaleVector(direction, speed);
}

float Math_CalculateDistance(int client, int target) {
    float clientPosition[VECTOR_SIZE];
    float targetPosition[VECTOR_SIZE];

    GetClientAbsOrigin(client, clientPosition);
    GetClientAbsOrigin(target, targetPosition);

    return GetVectorDistance(clientPosition, targetPosition);
}

float Math_CalculateAngleToCone(int client, int target) {
    float clientEyePosition[VECTOR_SIZE];
    float clientEyeAngles[VECTOR_SIZE];
    float clientDirection[VECTOR_SIZE];
    float targetEyePosition[VECTOR_SIZE];
    float targetDirection[VECTOR_SIZE];

    GetClientEyePosition(client, clientEyePosition);
    GetClientEyeAngles(client, clientEyeAngles);
    GetClientEyePosition(target, targetEyePosition);
    GetAngleVectors(clientEyeAngles, clientDirection, NULL_VECTOR, NULL_VECTOR);
    SubtractVectors(targetEyePosition, clientEyePosition, targetDirection);
    NormalizeVector(targetDirection, targetDirection);

    float dotProduct = GetVectorDotProduct(targetDirection, clientDirection);
    float angleRad = ArcCosine(dotProduct);
    float angleDeg = RadToDeg(angleRad);

    return angleDeg;
}

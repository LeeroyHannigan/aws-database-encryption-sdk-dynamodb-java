package software.aws.cryptography.dynamoDbEncryption;

import software.amazon.awssdk.core.SdkRequest;
import software.amazon.awssdk.core.interceptor.ExecutionAttribute;

public class DynamoDbEncryptionExecutionAttribute {
    static final ExecutionAttribute<SdkRequest> ORIGINAL_REQUEST = new ExecutionAttribute<SdkRequest>("OriginalRequest");
}

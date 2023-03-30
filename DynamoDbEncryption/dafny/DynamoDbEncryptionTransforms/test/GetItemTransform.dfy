// Copyright Amazon.com Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0
include "../../DynamoDbEncryptionTransforms/src/Index.dfy"
include "../../DynamoDbEncryption/test/TestFixtures.dfy"

module GetItemTransformTest {
  import opened Wrappers
  import opened DynamoDbEncryptionTransforms
  import opened TestFixtures
  import DDB = ComAmazonawsDynamodbTypes
  import AwsCryptographyDynamoDbEncryptionTransformsTypes

  method {:test} TestGetItemInputPassthrough() {
    var middlewareUnderTest := TestFixtures.GetDynamoDbEncryptionTransforms();
    var input := DDB.GetItemInput(
      TableName := "no_such_table",
      Key := map[],
      AttributesToGet := None(),
      ConsistentRead := None(),
      ReturnConsumedCapacity := None(),
      ProjectionExpression := None(),
      ExpressionAttributeNames := None()
    );
    var transformed := middlewareUnderTest.GetItemInputTransform(
      AwsCryptographyDynamoDbEncryptionTransformsTypes.GetItemInputTransformInput(
        sdkInput := input
      )
    );
    expect_ok("GetItemInput", transformed);
    expect_equal("GetItemInput", transformed.value.transformedInput, input);
  }

  method {:test} TestGetItemOutputPassthrough() {
    var middlewareUnderTest := TestFixtures.GetDynamoDbEncryptionTransforms();
    var input := DDB.GetItemInput(
      TableName := "no_such_table",
      Key := map[],
      AttributesToGet := None(),
      ConsistentRead := None(),
      ReturnConsumedCapacity := None(),
      ProjectionExpression := None(),
      ExpressionAttributeNames := None()
    );
    var output := DDB.GetItemOutput(
      Item := None(),
      ConsumedCapacity := None()
    );
    var transformed := middlewareUnderTest.GetItemOutputTransform(
      AwsCryptographyDynamoDbEncryptionTransformsTypes.GetItemOutputTransformInput(
        sdkOutput := output,
        originalInput := input
      )
    );

    expect_ok("GetItemOutput", transformed);
    expect_equal("GetItemOutput", transformed.value.transformedOutput, output);
  }

}
#!/bin/bash

# A simple script for using our Polymorph package to generate
# all relevant code

pushd .

export CURRENT_DIR=`pwd`
export DEPS_ROOT=$CURRENT_DIR/../private-aws-encryption-sdk-dafny-staging
export POLYMORPH_ROOT=$CURRENT_DIR/../polymorph/smithy-polymorph

export MaterialProviders_ROOT=$DEPS_ROOT/AwsCryptographicMaterialProviders
export AwsCryptographyPrimitives_ROOT=$DEPS_ROOT/AwsCryptographyPrimitives
export ComAmazonawsKms_ROOT=$DEPS_ROOT/ComAmazonawsKms
export ComAmazonawsDynamoDb_ROOT=$CURRENT_DIR/../ComAmazonawsDynamoDb
export StructuredEncryption_ROOT=$CURRENT_DIR/../StructuredEncryption
export StandardLibrary_ROOT=$DEPS_ROOT/StandardLibrary
export DynamoDbItemEncryptor_ROOT=$CURRENT_DIR

cd "$POLYMORPH_ROOT"

# Generate code from DynamoDbItemEncryptor smithy model
./gradlew run --args="\
    --output-dafny \
    --include-dafny $StandardLibrary_ROOT/src/Index.dfy \
    --model $DynamoDbItemEncryptor_ROOT/Model \
    --dependent-model $ComAmazonawsKms_ROOT/Model \
    --dependent-model $ComAmazonawsDynamoDb_ROOT/Model \
    --dependent-model $MaterialProviders_ROOT/Model \
    --dependent-model $DEPS_ROOT/model \
    --dependent-model $AwsCryptographyPrimitives_ROOT/Model \
    --dependent-model $StructuredEncryption_ROOT/Model \
    --namespace aws.cryptography.dynamoDbItemEncryptor"

popd

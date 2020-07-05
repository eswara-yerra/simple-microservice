#!/bin/bash
OPERATION=$1
ENV=$2
MODULE=$3

REGION=us-east-1
PRODUCT_CODE=tg-demo
BASEDIR=$PWD/$(dirname $0)
TG_ROOT_DIR=$BASEDIR/modules
RUN_DIR=$TG_ROOT_DIR/$MODULE

TEMPLATE_FILE=$BASEDIR/terragrunt_template

TERRAGRUNT_FILE=$TG_ROOT_DIR/terragrunt.hcl
VAR_FILE=$BASEDIR/vars/$ENV
TARGET_VAR_FILE=$TG_ROOT_DIR/env.tfvars

clean(){
  rm -rf $TARGET_VAR_FILE
  rm -rf $TERRAGRUNT_FILE
  rm -rf $RUN_DIR/.terragrunt-cache
  ls $RUN_DIR/.terragrunt-cache
}
setup_template(){
  echo "Generating terragrunt template for $MODULE $ENV $REGION"
  echo "Using template for $TEMPLATE_FILE"


  cp $TEMPLATE_FILE $TERRAGRUNT_FILE
  sed -i.bak "s/{{THE_BUCKET}}/$PRODUCT_CODE-$ENV-$MODULE/g" $TERRAGRUNT_FILE
  sed -i.bak "s/{{THE_LOCK_TABLE}}/$PRODUCT_CODE-$ENV-$MODULE/g" $TERRAGRUNT_FILE
  sed -i.bak "s/{{THE_REGION}}/$REGION/g" $TERRAGRUNT_FILE
  sed -i.bak "s/{{TERRAGRUNT_ROOT}}/$(echo $TG_ROOT_DIR | sed 's_/_\\/_g')/g" $TERRAGRUNT_FILE
  rm -rf $TERRAGRUNT_FILE.bak
}

setup_vars(){
  echo "Setting up vars file:$TARGET_VAR_FILE"
  cp $VAR_FILE $TG_ROOT_DIR/env.tfvars
}


run(){
  clean
  setup_template
  setup_vars
  cd $RUN_DIR
  terragrunt apply
}


run
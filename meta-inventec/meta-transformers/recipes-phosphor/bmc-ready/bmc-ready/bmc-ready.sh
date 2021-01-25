#!/bin/sh

gpioutil -p b1 -d out -v 0
echo BMC ready !!
gpioutil -p f4 -d out -v 1
echo Release reset SGPIO !!

#/bin/bash

model_dir="./checkpoints/lm_model"

# python -m tf2onnx.convert \
#     --graphdef ${model_dir}/landmark68_detector.pb \
#     --inputs input_imgs:0 \
#     --outputs landmark:0 \
#     --output ${model_dir}/landmark68_detector.onnx

python -m tf2onnx.convert \
    --graphdef ${model_dir}/68lm_detector.pb \
    --inputs input_imgs:0 \
    --outputs lm:0 \
    --output ${model_dir}/68lm_detector.onnx
    
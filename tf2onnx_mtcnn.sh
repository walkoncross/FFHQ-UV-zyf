#/bin/bash
model_dir="./checkpoints/mtcnn_model"

python -m tf2onnx.convert \
    --graphdef ${model_dir}/mtcnn_model.pb \
    --inputs pnet/input:0 \
    --outputs pnet/conv4-2/BiasAdd:0,pnet/prob1:0 \
    --output ${model_dir}/pnet.onnx

python -m tf2onnx.convert \
    --graphdef ${model_dir}/mtcnn_model.pb \
    --inputs rnet/input:0 \
    --outputs rnet/conv5-2/conv5-2:0,rnet/prob1:0 \
    --output ${model_dir}/rnet.onnx

python -m tf2onnx.convert \
    --graphdef ${model_dir}/mtcnn_model.pb \
    --inputs onet/input:0 \
    --outputs onet/conv6-2/conv6-2:0,onet/conv6-3/conv6-3:0,onet/prob1:0 \
    --output ${model_dir}/onet.onnx

# 以下转换之后的模型无法使用，因为pb文件里面包括了3个单独的网络，但是每个onnx只能支持一个网络
# python -m tf2onnx.convert \
#     --graphdef ${model_dir}/mtcnn_model.pb \
#     --inputs pnet/input:0,rnet/input:0,onet/input:0 \
#     --outputs pnet/conv4-2/BiasAdd:0,pnet/prob1:0,rnet/conv5-2/conv5-2:0,rnet/prob1:0,onet/conv6-2/conv6-2:0,onet/conv6-3/conv6-3:0,onet/prob1:0 \
#     --output ${model_dir}/mtcnn_model.onnx

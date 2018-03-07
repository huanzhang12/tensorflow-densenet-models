Expert graph
--------------

```
python3 export_inference_graph.py --alsologtostderr --model_name densenet121 --output_file=densenet121_k32.pb --labels_offset=1
python3 export_inference_graph.py --alsologtostderr --model_name densenet169 --output_file=densenet169_k32.pb --labels_offset=1
python3 export_inference_graph.py --alsologtostderr --model_name densenet161 --output_file=densenet161_k48.pb --labels_offset=1
```

Freeze graph
---------------

Need to have a compiled Tensorflow at ../tensorflow-1.5.0

compiled by `bazel build tensorflow/python/tools/freeze_graph`

```
python3 freeze_graph.py --input_graph=densenet121_k32.pb --input_checkpoint=models/121/tf-densenet121.ckpt --input_binary=true --output_graph=densenet121_k32_frozen.pb --output_node_names=densenet121/predictions/Reshape_1
python3 freeze_graph.py --input_graph=densenet169_k32.pb --input_checkpoint=models/169/tf-densenet169.ckpt --input_binary=true --output_graph=densenet169_k32_frozen.pb --output_node_names=densenet169/predictions/Reshape_1
python3 freeze_graph.py --input_graph=densenet161_k48.pb --input_checkpoint=models/161/tf-densenet161.ckpt --input_binary=true --output_graph=densenet161_k48_frozen.pb --output_node_names=densenet161/predictions/Reshape_1
```

How to find nodes
-----------------
```
python3 viz.py densenet121_k32.pb /tmp/densenet121_k32_viz/
tensorboard --logdir=/tmp/densenet121_k32_viz/
```


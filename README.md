Download Models
--------------

```
cd models
./getmodels.sh
cd ..
```

Expert graph
--------------

```
python3 export_inference_graph.py --alsologtostderr --model_name densenet121 --output_file=densenet121_k32.pb --labels_offset=1
python3 export_inference_graph.py --alsologtostderr --model_name densenet169 --output_file=densenet169_k32.pb --labels_offset=1
python3 export_inference_graph.py --alsologtostderr --model_name densenet161 --output_file=densenet161_k48.pb --labels_offset=1
```

`--labeloffset=1` is needed when the classifier is trained with 1000 classes,
without an additional background class. Some ImageNet models are trained with
1001 classes.

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

Then point your browser to `localhost:6001` and check the input and output
nodes of the graph.  For densenet121, the input node is `input:0`, logit output
node is `densenet121/predictions/Reshape:0` and probability output (after
softmax) is `densenet121/predictions/Reshape_1:0`. Also take a note of the
input image size (224). At the final layer there is a tensor to reshape the
output, which is 'densenet121/predictions/Shape:0' (this is not required, if
the model does not have a reshape tensor, you can leave this field empty in
`setup_imagenet.py`)


Add entries to setup\_imagenet.py
----------------

```
AddModel('densenet121_k32', 'http://jaina.cs.ucdavis.edu/datasets/adv/imagenet/densenet121_k32_frozen.pb', 
         'densenet121_k32_frozen.pb', 224, 'labels.txt', 'input:0',                        
         'densenet121/predictions/Reshape:0', 'densenet121/predictions/Reshape_1:0', 'densenet121/predictions/Shape:0') 
AddModel('densenet169_k32', 'http://jaina.cs.ucdavis.edu/datasets/adv/imagenet/densenet169_k32_frozen.pb', 
         'densenet169_k32_frozen.pb', 224, 'labels.txt', 'input:0',
         'densenet169/predictions/Reshape:0', 'densenet169/predictions/Reshape_1:0', 'densenet169/predictions/Shape:0')
AddModel('densenet161_k48', 'http://jaina.cs.ucdavis.edu/datasets/adv/imagenet/densenet161_k48_frozen.pb', 
         'densenet161_k48_frozen.pb', 224, 'labels.txt', 'input:0', 
         'densenet161/predictions/Reshape:0', 'densenet161/predictions/Reshape_1:0', 'densenet161/predictions/Shape:0') 
```


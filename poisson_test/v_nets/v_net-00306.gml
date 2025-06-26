graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 306
  arrival_time 5816.527629292832
  lifetime 1234.4714413870754
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 6
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 8
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 45
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
]

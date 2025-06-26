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
  id 773
  arrival_time 16156.836212283175
  lifetime 1026.3914913599842
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 32
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 6
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
]

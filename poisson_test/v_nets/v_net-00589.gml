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
  id 589
  arrival_time 11711.198287647812
  lifetime 449.0171510135497
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 33
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 3
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 30
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 18
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
]

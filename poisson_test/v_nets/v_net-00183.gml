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
  id 183
  arrival_time 3388.6457211317384
  lifetime 561.9257924153865
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 35
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 39
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 33
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 19
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
]

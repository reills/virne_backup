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
  id 240
  arrival_time 4437.833608983283
  lifetime 1211.8634169264772
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 42
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 37
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 13
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 29
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 21
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
]

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
  id 1893
  arrival_time 41782.59321362861
  lifetime 597.7236265494042
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 50
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 28
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 0
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 40
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
]

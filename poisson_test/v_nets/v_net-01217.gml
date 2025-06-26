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
  id 1217
  arrival_time 25273.853264801
  lifetime 1.7783572984413654
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 27
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 42
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 31
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 31
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
]

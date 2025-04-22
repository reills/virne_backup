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
  id 1812
  arrival_time 40195.71164685749
  lifetime 2738.884612740324
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 42
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 40
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 29
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 41
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 10
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
]

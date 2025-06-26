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
  id 1043
  arrival_time 22089.683029412736
  lifetime 116.6059575311822
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 9
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 2
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 49
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 44
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 17
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 14
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
]

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
  id 805
  arrival_time 16707.47227498302
  lifetime 1622.5556135845118
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 2
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 49
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 4
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 38
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 23
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 28
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 47
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
]

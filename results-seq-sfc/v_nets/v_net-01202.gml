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
  id 1202
  arrival_time 25112.314754281713
  lifetime 248.73074394586757
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 12
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 12
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 49
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 37
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 37
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 18
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
]

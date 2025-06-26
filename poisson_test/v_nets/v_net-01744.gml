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
  id 1744
  arrival_time 38936.37649892609
  lifetime 1728.4933701564407
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 27
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 32
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 19
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 4
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 31
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 38
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
]

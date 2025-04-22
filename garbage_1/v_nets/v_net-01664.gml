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
  id 1664
  arrival_time 37169.85386259916
  lifetime 1196.2768761876996
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 40
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 6
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 8
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 42
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 46
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 11
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 23
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
]

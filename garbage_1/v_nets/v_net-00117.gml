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
  id 117
  arrival_time 2146.6179488732205
  lifetime 460.23423942910074
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 38
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 7
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 36
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 46
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 22
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 1
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 46
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
]

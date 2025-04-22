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
  id 1831
  arrival_time 40477.9563740157
  lifetime 340.2335281082731
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 13
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 4
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 21
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 28
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 5
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
]

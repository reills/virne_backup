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
  id 152
  arrival_time 2956.725978033904
  lifetime 178.28872193499254
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 43
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 8
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 0
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 22
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 33
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 3
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 2
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
]

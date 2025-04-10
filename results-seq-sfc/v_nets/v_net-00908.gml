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
  id 908
  arrival_time 19408.16696860139
  lifetime 52.27472131359145
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 40
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 12
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 28
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 3
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 2
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 31
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
]

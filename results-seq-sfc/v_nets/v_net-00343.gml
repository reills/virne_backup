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
  id 343
  arrival_time 6525.43919274853
  lifetime 659.5515437974927
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 3
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 37
    rom 50
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 43
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 11
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 49
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 25
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 11
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
]

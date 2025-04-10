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
  id 161
  arrival_time 3056.732364067216
  lifetime 1338.16792206626
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 40
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 26
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 32
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 33
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 32
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 48
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 18
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
]

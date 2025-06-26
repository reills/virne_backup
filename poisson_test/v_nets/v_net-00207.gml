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
  id 207
  arrival_time 3645.2634188221646
  lifetime 257.84271143101876
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 0
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 2
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 37
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 6
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 50
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
]

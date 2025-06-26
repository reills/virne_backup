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
  id 976
  arrival_time 20862.35146339558
  lifetime 614.2067350495543
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 31
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 44
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 3
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 22
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 23
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 29
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 43
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
]

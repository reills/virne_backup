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
  id 880
  arrival_time 18621.834986004116
  lifetime 50.67307898869309
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 34
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 19
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 16
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 36
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 31
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 29
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 24
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
]
